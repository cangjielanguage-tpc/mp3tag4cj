/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Mp3 file
 */
package mp3agic

from std import io.*
from std import collection.*
from std import fs.*

public class Mp3File <: FileWrapper {
    private static let DEFAULT_BUFFER_LENGTH: Int32 = 65536
    private static let MINIMUM_BUFFER_LENGTH: Int32 = 40
    private static let XING_MARKER_OFFSET_1: Int32 = 13
    private static let XING_MARKER_OFFSET_2: Int32 = 21
    private static let XING_MARKER_OFFSET_3: Int32 = 36

    protected var bufferLength: Int32 = 0
    private var xingOffset: Int32 = -1
    private var startOffset: Int32 = -1
    private var endOffset: Int32 = -1
    private var frameCounts: Int32 = 0
    private let bitrates: HashMap<Int32, MutableInteger> = HashMap<Int32, MutableInteger>()
    private var xingBitrate: Int32 = 0
    private var bitrate: Float64 = 0.0
    private var channelMode: String = ""
    private var emphasis: String = ""
    private var layer: String = ""
    private var modeExtension: String = ""
    private var sampleRate: Int32 = 0
    private var copyright: Bool = false
    private var original: Bool = false
    private var version: String = ""
    private var id3v1Tag: Option<ID3v1> = Option<ID3v1>.None
    private var id3v2Tag: Option<ID3v2> = Option<ID3v2>.None
    private var customTag: Option<Array<Int8>> = Option<Array<Int8>>.None
    private var scanFile: Bool = true

    protected init() {}

    /**
     * The Function is init constructor
     * 
     * @param filename of String
     * @since 0.31.4
     */
    public init(filename: String) {
        this(filename, DEFAULT_BUFFER_LENGTH, true)
    }

    /**
     * The Function is init constructor
     * 
     * @param filename of String
     * @param bufferLength of Int32
     * @since 0.31.4
     */
    public init(filename: String, bufferLength: Int32) {
        this(filename, bufferLength, true)
    }

    /**
     * The Function is init constructor
     * 
     * @param filename of String
     * @param scanFile of Bool
     * @since 0.31.4
     */
    public init(filename: String, scanFile: Bool) {
        this(filename, DEFAULT_BUFFER_LENGTH, scanFile)
    }

    /**
     * The Function is init constructor
     * 
     * @param filename of String
     * @param bufferLength of Int32
     * @param scanFile of Bool
     * @since 0.31.4
     */
    public init(filename: String, bufferLength: Int32, scanFile: Bool) {
        super(filename)
        initFunc(bufferLength, scanFile)
    }

    /**
     * The Function is init constructor
     * 
     * @param file of FileInfo
     * @since 0.31.4
     */
    public init(file: FileInfo) {
        this(file, DEFAULT_BUFFER_LENGTH, true)
    }

    /**
     * The Function is init constructor
     * 
     * @param file of FileInfo
     * @param bufferLength of Int32
     * @since 0.31.4
     */
    public init(file: FileInfo, bufferLength: Int32) {
        this(file, bufferLength, true)
    }

    /**
     * The Function is init constructor
     * 
     * @param file of FileInfo
     * @param bufferLength of Int32
     * @param scanFile of Bool
     * @since 0.31.4
     */
    public init(file: FileInfo, bufferLength: Int32, scanFile: Bool) {
        super(file)
        initFunc(bufferLength, scanFile)
    }

    private func initFunc(bufferLength: Int32, scanFile: Bool): Unit {
        if (bufferLength < MINIMUM_BUFFER_LENGTH + 1) {
            throw IllegalArgumentException("Buffer too small")
        }
        this.bufferLength = bufferLength
        this.scanFile = scanFile
        var file: File = File(super.path, OpenOption.Open(true, true))
        initId3v1Tag(file)
        scanFileFunc(file) //扫描文件获取音频数据流的帧头数据并解析。 涉及到Xing-header帧处理和是否扫描全部的容器大小
        if (startOffset < 0) { //此时startOffset的值应为第一个媒体数据帧的起始位置，不算Xing-header帧不算做媒体数据帧
            throw InvalidDataException("No mpegs frames found");
        }
        initId3v2Tag(file) //初始化Id3v2标签
        if (scanFile) {
            initCustomTag(file)
        }
    }

    private func scanFileFunc(seekableByteChannel: File): Unit {
        var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(this.bufferLength), {i => 0})
        var fileOffset: Int32 = preScanFile(seekableByteChannel)
        seekableByteChannel.seek(SeekPosition.Begin(Int64(fileOffset)))
        var lastBlock: Bool = false
        var lastOffset: Int32 = fileOffset
        while (!lastBlock) {
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer)
            var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
            if (bytesRead < Int64(bufferLength)) {
                lastBlock = true
            }
            if (bytesRead >= Int64(MINIMUM_BUFFER_LENGTH)) {
                while (true) {
                    try {
                        var offset: Int32 = 0 // 1设置偏移量为0
                        if (this.startOffset < 0) { // 1成员startOffset初始值为-1
                            offset = scanBlockForStart(bytes, Int32(bytesRead), fileOffset, offset)
                            if (this.startOffset >= 0 && !scanFile) {
                                return
                            }
                            lastOffset = startOffset
                        }
                        offset = scanBlock(bytes, Int32(bytesRead), fileOffset, offset)
                        fileOffset += offset
                        seekableByteChannel.seek(SeekPosition.Begin(Int64(fileOffset)))
                        break
                    } catch (e: Exception) {
                        if (frameCounts < 2) {
                            xingOffset = -1
                            frameCounts = 0
                            startOffset = -1
                            bitrates.clear()
                            lastBlock = false
                            fileOffset = 1 + lastOffset
                            if (fileOffset == 0) {
                                throw InvalidDataException("Valid start of mpeg frames not found ${e}")
                            }
                            seekableByteChannel.seek(SeekPosition.Begin(Int64(fileOffset)))
                            break
                        }
                        return
                    }
                }
            }
        }
    }

    private func scanBlock(bytes: Array<Int8>, bytesRead: Int32, absoluteOffset: Int32, offsets: Int32): Int32 {
        var offsets: Int32 = offsets
        while (offsets < bytesRead - MINIMUM_BUFFER_LENGTH) {
            var frame: MpegFrame = MpegFrame(
                bytes[Int64(offsets)],
                bytes[Int64(offsets) + 1],
                bytes[Int64(offsets) + 2],
                bytes[Int64(offsets) + 3]
            )
            sanityCheckFrame(frame, absoluteOffset + offsets)
            var newEndOffset: Int32 = absoluteOffset + offsets + frame.getLengthInBytes() - 1
            if (newEndOffset < maxEndOffset()) {
                endOffset = absoluteOffset + offsets + frame.getLengthInBytes() - 1
                frameCounts++
                addBitrates(frame.getBitrate())
                offsets += frame.getLengthInBytes()
            } else {
                break
            }
        }
        return offsets
    }

    private func maxEndOffset(): Int32 {
        var maxEndOffset: Int64 = getLength()
        if (hasId3v1Tag()) {
            maxEndOffset -= Int64(ID3v1Tag.TAG_LENGTH)
        }
        return Int32(maxEndOffset)
    }

    private func sanityCheckFrame(frame: MpegFrame, offset: Int32): Unit {
        if (sampleRate != frame.getSampleRate()) {
            throw InvalidDataException("Inconsistent frame header")
        }
        if (!layer.equals(frame.getLayer())) {
            throw InvalidDataException("Inconsistent frame header")
        }
        if (!version.equals(frame.getVersion())) {
            throw InvalidDataException("Inconsistent frame header")
        }
        if (Int64(offset) + Int64(frame.getLengthInBytes()) > getLength()) {
            throw InvalidDataException("Frame would extend beyond end of file")
        }
    }

    @overflowWrapping
    private func scanBlockForStart(bytes: Array<Int8>, bytesRead: Int32, absoluteOffset: Int32, offsets: Int32): Int32 {
        var offset: Int32 = offsets

        //循环可以得到音频数据帧的个数，不包括Xing-header帧
        while (offset < (bytesRead - MINIMUM_BUFFER_LENGTH)) {
            if (bytes[Int64(offset)] == Int8(0xFF) && (bytes[Int64(offset) + 1] & Int8(0xE0)) == Int8(0xE0)) {
                //对此块检查是否是帧同步镖旗
                try {
                    //构建媒体对象， 将此块的前4个字节拿到，也就是 数据帧头， 通过次块的帧头（每个音频数据帧的前4个字节）将许局封装进媒体对象
                    var frame: MpegFrame = MpegFrame(
                        bytes[Int64(offset)],
                        bytes[Int64(offset) + 1],
                        bytes[Int64(offset) + 2],
                        bytes[Int64(offset) + 3]
                    )

                    //判断Xing-header偏移量，和此帧是否是Xing-header帧
                    if (this.xingOffset < 0 && isXingFrame(bytes, offset)) {
                        this.xingOffset = absoluteOffset + offset

                        //设置xingOffset首次的值为 文件偏移量（标签末尾偏移量） + 0
                        this.xingBitrate = frame.getBitrate()
                        offset += frame.getLengthInBytes()
                    } else {
                        this.startOffset = absoluteOffset + offset
                        this.channelMode = frame.getChannelMode()
                        this.emphasis = frame.getEmphasis()
                        this.layer = frame.getLayer()
                        this.modeExtension = frame.getModeExtension()
                        this.sampleRate = frame.getSampleRate()
                        this.version = frame.getVersion()
                        this.copyright = frame.isCopyright()
                        this.original = frame.isOriginal()
                        frameCounts++

                        //存储每一个音频数据真的位率
                        addBitrates(frame.getBitrate())
                        offset += frame.getLengthInBytes()
                        return offset
                    }
                } catch (e: InvalidDataException) {
                    offset++
                }
            } else {
                offset++
            }
        }
        return offset
    }

    private func addBitrates(bitrate: Int32): Unit {
        match (bitrates.get(bitrate)) {
            case Some(x) =>
                x.increment()
                ()
            case None =>
                this.bitrates.put(bitrate, MutableInteger(1))
                ()
        }
        this.bitrate = ((this.bitrate * (Float64(frameCounts) - Float64(1))) + Float64(bitrate)) / Float64(frameCounts)
    }

    private func isXingFrame(bytes: Array<Int8>, offset: Int32): Bool {
        if (bytes.size >= Int64(offset) + Int64(XING_MARKER_OFFSET_1) + 3) {
            if ("Xing".equals(
                BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_1, 4).
                getOrDefault({ => ""})
            )) {
                return true
            }
            if ("Info".equals(
                BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_1, 4).
                getOrDefault({ => ""})
            )) {
                return true
            }
            if (bytes.size >= Int64(offset + XING_MARKER_OFFSET_2 + 3)) {
                if ("Xing".equals(
                    BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_2, 4).
                    getOrDefault({ => ""})
                )) {
                    return true
                }
                if ("Info".equals(
                    BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_2, 4).
                    getOrDefault({ => ""})
                )) {
                    return true
                }
                if (bytes.size >= Int64(offset + XING_MARKER_OFFSET_3 + 3)) {
                    if ("Xing".equals(
                        BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_3, 4).
                        getOrDefault({ => ""})
                    )) {
                        return true
                    }
                    if ("Info".equals(
                        BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_3, 4).
                        getOrDefault({ => ""})
                    )) {
                        return true
                    }
                }
            }
        }
        return false
    }

    protected func preScanFile(seekableByteChannel: File): Int32 {
        var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(AbstractID3v2Tag.HEADER_LENGTH), {i => 0})
        try {
            seekableByteChannel.seek(SeekPosition.Begin(0)) //将字节流的位置置为0
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer) //标签头的字节流 读入byteBuffer
            if (bytesRead == Int64(AbstractID3v2Tag.HEADER_LENGTH)) {
                try {
                    var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
                    ID3v2TagFactory.sanityCheckTag(bytes) //检查标签头合法
                    return AbstractID3v2Tag.HEADER_LENGTH + BufferTools.unpackSynchsafeInteger(
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET)],
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET) + 1],
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET) + 2],
                        bytes[Int64(AbstractID3v2Tag.DATA_LENGTH_OFFSET) + 3]
                    )
                    //这里返回的是标签的总大小 为 标签头大小（10） +  标签帧的大小
                } catch (e: NoSuchTagException) {}
            }
        } catch (e: Exception) {}
        return 0
    }

    private func initId3v2Tag(seekableByteChannel: File): Unit {
        if (xingOffset == 0 || startOffset == 0) { //通过这两个条件判断是否包含ID3V2标签
            id3v2Tag = Option<ID3v2>.None
        } else {
            var bufferLength: Int32
            if (hasXingFrame()) {
                bufferLength = xingOffset
                //如果存在Xing-header 定义一个长度为xing-header开始偏移量的大小
            } else {
                bufferLength = startOffset
                //如果没有xing-header的话 定义一个长度为 第一个音频数据帧开始的偏移量的大小
            }
            var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(bufferLength), {i => 0})
            seekableByteChannel.seek(SeekPosition.Begin(0)) //偏移量置换为零
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer) //读取这样大小的buffer 即为 ID3V2标签的内容
            if (bytesRead < Int64(bufferLength)) {
                throw Exception("Not enough bytes read")
            }
            try {
                var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
                var iD3v2 = (ID3v2TagFactory.createTag(bytes).getOrThrow() as ID3v2).getOrThrow()
                this.id3v2Tag = Option<ID3v2>.Some(iD3v2) //传入整个标签的内容，创建标签赋值给变量
            } catch (e: Exception) {
                id3v2Tag = Option<ID3v2>.None
            }
        }
    }

    private func initCustomTag(seekableByteChannel: File): Unit {
        var bufferLength: Int32 = (Int32(getLength()) - (endOffset + 1)) //文件长度 - 最后音频数据帧的结尾偏移量
        if (hasId3v1Tag()) {
            bufferLength -= ID3v1Tag.TAG_LENGTH
        } //包含ID3V1的时候 需要减去ID3V1标签的长度
        if (bufferLength <= 0) { //得到CusttomTag的长度
            customTag = Option<Array<Int8>>.None
        } else {
            var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(bufferLength), {i => 0})
            seekableByteChannel.seek(SeekPosition.Begin(Int64(endOffset) + 1)) //偏移量设置为，最后一个音频数据帧的结尾
            var bytesRead: Int64 = seekableByteChannel.read(byteBuffer) //读取整个CusttomTage的数据
            var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(byteBuffer)
            customTag = Option<Array<Int8>>.Some(bytes) //赋值给成员customTag
            if (bytesRead < Int64(bufferLength)) {
                throw Exception("Not enough bytes read")
            }
        }
    }

    private func initId3v1Tag(file: File): Unit {
        var byteBuffer: Array<Byte> = Array<Byte>(Int64(ID3v1Tag.TAG_LENGTH), {i => 0})
        var byteBuffer2: Array<Byte> = Array<Byte>(getLength(), {i => 0})
        file.read(byteBuffer2)
        file.seek(SeekPosition.Begin(getLength() - Int64(ID3v1Tag.TAG_LENGTH)))
        var bytesRead: Int64 = file.read(byteBuffer)
        if (bytesRead < Int64(ID3v1Tag.TAG_LENGTH)) {
            throw BaseException("Not enough bytes read")
        }
        try {
            this.id3v1Tag = Option<ID3v1>.Some(ID3v1Tag(byteBuffer))
        } catch (e: Exception) {
            this.id3v1Tag = Option<ID3v1>.None
        }
    }

    /**
     * The Function is hasId3v1Tag, Whether the ID3v1 tag is included
     * 
     * @return Type of Bool
     * @since 0.31.4
     */
    public func hasId3v1Tag(): Bool {
        return match (this.id3v1Tag) {
            case Some(x) => true
            case None => false
        }
    }

    /**
     * The Function is hasId3v2Tag, Whether the ID3v2 tag is included
     * 
     * @return Type of Bool
     * @since 0.31.4
     */
    public func hasId3v2Tag(): Bool {
        return match (this.id3v2Tag) {
            case Some(x) => true
            case None => false
        }
    }
    public func getId3v2Tag(): Option<ID3v2> {
        return id3v2Tag
    }

    public func setId3v2Tag(id3v2Tag: Option<ID3v2>): Unit {
        this.id3v2Tag = id3v2Tag
    }

    public func removeId3v2Tag(): Unit {
        this.id3v2Tag = Option<ID3v2>.None
    }

    /**
     * The Function is hasCustomTag, Include custom labels
     * 
     * @return Type of Bool
     * @since 0.31.4
     */
    public func hasCustomTag(): Bool {
        return match (this.customTag) {
            case Some(x) => true
            case None => false
        }
    }

    public func getCustomTag(): Option<Array<Int8>> {
        return customTag
    }

    public func setCustomTag(customTag: Option<Array<Int8>>): Unit {
        this.customTag = customTag
    }

    public func removeCustomTag(): Unit {
        this.customTag = Option<Array<Int8>>.None
    }

    /**
     * The Function is getId3v1Tag, Get Tags
     * 
     * @return Type of Option<ID3v1>
     * @since 0.31.4
     */
    public func getId3v1Tag(): Option<ID3v1> {
        return id3v1Tag
    }

    /**
     * The Function is setId3v1Tag, Set label
     * 
     * @param id3v1Tag of Option<ID3v1>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setId3v1Tag(id3v1Tag: Option<ID3v1>): Unit {
        this.id3v1Tag = id3v1Tag
    }

    /**
     * The Function is removeId3v1Tag, Remove id3v1tag
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    public func removeId3v1Tag(): Unit {
        this.id3v1Tag = Option<ID3v1>.None
    }

    public func getStartOffset(): Int32 {
        return startOffset
    }

    public func getXingOffset(): Int32 {
        return xingOffset
    }

    public func getEndOffset(): Int32 {
        return endOffset
    }

    public func getFrameCount(): Int32 {
        return frameCounts
    }

    public func getBitrate(): Int32 {
        return Int32(bitrate + 0.5)
    }

    public func getXingBitrate(): Int32 {
        return xingBitrate
    }

    public func getBitrates(): Map<Int32, MutableInteger> {
        return bitrates
    }

    public func getChannelMode(): String {
        return channelMode
    }

    public func getEmphasis(): String {
        return emphasis
    }

    public func getLayer(): String {
        return layer
    }

    public func getLengthInMilliseconds(): Int64 {
        return Int64((Float64(endOffset - startOffset) * (8.0 / bitrate)) + 0.5)
    }

    public func getLengthInSeconds(): Int64 {
        return ((getLengthInMilliseconds() + 500) / 1000)
    }

    public func getModeExtension(): String {
        return modeExtension
    }

    public func getSampleRate(): Int32 {
        return sampleRate
    }

    public func getVersion(): String {
        return version
    }

    public func isCopyright(): Bool {
        return copyright
    }

    public func isOriginal(): Bool {
        return original
    }

    public func isVbr(): Bool {
        return bitrates.size > 1
    }

    public func hasXingFrame(): Bool {
        return (xingOffset >= 0)
    }

    /**
     * The Function is save, Save file, cannot overwrite source file
     * 
     * @param newFilename of String
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    public func save(newFilename: String): Unit {
        var isExist: Bool = true
        try {
            FileInfo(newFilename).path.toCanonical().toString()
            ()
        } catch (e: Exception) {
            isExist = false
            ()
        }
        if (isExist && FileInfo(newFilename).path.toCanonical().toString() == super.path) {
            throw IllegalArgumentException("Save filename same as source filename")
        }
        try {
            var saveFile: File = File(newFilename, OpenOption.CreateOrTruncate(true))
            if (hasId3v2Tag()) {
                var bytes: Array<Int8> = this.id3v2Tag.getOrThrow().toBytes()
                var byteBuffer: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(bytes)
                saveFile.write(byteBuffer)
            }
            saveMpegFrames(saveFile);
            if (hasCustomTag()) {
                var byteBuffer: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(customTag.getOrThrow())
                saveFile.write(byteBuffer)
            }
            if (hasId3v1Tag()) {
                var bytes: Array<Int8> = this.id3v1Tag.getOrThrow().toBytes()
                var byteBuffer: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(bytes)
                saveFile.write(byteBuffer)
            }
        } catch (e: Exception) {}
    }

    private func saveMpegFrames(saveFile: File): Unit {
        var filePos: Int32 = xingOffset
        if (filePos < 0) {
            filePos = startOffset
        }
        if (filePos < 0) {
            return
        }
        if (endOffset < filePos) {
            return
        }
        var byteBuffer: Array<UInt8> = Array<UInt8>(Int64(bufferLength), {i => 0})
        try {
            var seekableByteChannel: File = File(super.path, OpenOption.Open(true, true))
            seekableByteChannel.seek(SeekPosition.Begin(Int64(filePos)))
            while (true) {
                var bytesRead: Int64 = seekableByteChannel.read(byteBuffer)
                if (Int64(filePos) + bytesRead <= Int64(endOffset)) {
                    saveFile.write(byteBuffer.slice(0, Int64(bytesRead)))
                    filePos += Int32(bytesRead)
                } else {
                    saveFile.write(byteBuffer.slice(0, Int64(endOffset - filePos + 1)))
                    break
                }
            }
        } catch (e: Exception) {}
    }
}
