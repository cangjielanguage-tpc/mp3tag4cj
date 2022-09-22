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
    private var frameCount: Int32 = 0
    private let bitrates: HashMap<Int32, MutableInteger> = HashMap<Int32, MutableInteger>()
    private var xingBitrate: Int32 = 0
    private var bitrate: Float64 = 0.0
    private var sampleRate: Int32 = 0
    private var copyright: Bool = false
    private var original: Bool = false
    private var version: String = ""
    private var id3v1Tag: Option<ID3v1> = Option<ID3v1>.None
    private var id3v2Tag: Option<ID3v2> = Option<ID3v2>.None
    private var customTag: Option<Array<Byte>> = Option<Array<Byte>>.None
    private var scanFile: Bool = true

    protected init (){}

    /**
     * The Function is init constructor
     *
     * @param filename of String
     * @since 0.31.4
     */
    public init (filename: String){
        this(filename, DEFAULT_BUFFER_LENGTH, true)
    }

    /**
     * The Function is init constructor
     *
     * @param filename of String
     * @param bufferLength of Int32
     * @since 0.31.4
     */
    public init (filename: String, bufferLength: Int32){
        this(filename, bufferLength, true)
    }

    /**
     * The Function is init constructor
     *
     * @param filename of String
     * @param scanFile of Bool
     * @since 0.31.4
     */
    public init (filename: String, scanFile: Bool){
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
    public init (filename: String, bufferLength: Int32, scanFile: Bool){
        super(filename)
        initFunc(bufferLength, scanFile)
    }

    /**
     * The Function is init constructor
     *
     * @param file of FileInfo
     * @since 0.31.4
     */
    public init (file: FileInfo){
        this(file, DEFAULT_BUFFER_LENGTH, true)
    }

    /**
     * The Function is init constructor
     *
     * @param file of FileInfo
     * @param bufferLength of Int32
     * @since 0.31.4
     */
    public init (file: FileInfo, bufferLength: Int32){
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
    public init (file: FileInfo, bufferLength: Int32, scanFile: Bool){
        super(file)
        initFunc(bufferLength, scanFile)
    }

    private  func initFunc (bufferLength: Int32, scanFile: Bool): Unit {
        if (bufferLength < MINIMUM_BUFFER_LENGTH + 1) {
            throw IllegalArgumentException("Buffer too small")
        }
        this.bufferLength = bufferLength
        this.scanFile = scanFile
        try {
            var file: File = File(super.path, AccessMode.ReadWrite, OpenMode.Open)
            initId3v1Tag(file)
        }catch (e: Exception) {
            throw BaseException("openFile fail")
        }
    }

    private func initId3v1Tag (file:  File): Unit {
        var byteBuffer: Array<Byte> = Array<Byte>(Int64(ID3v1Tag.TAG_LENGTH), { i => 0 })
        var byteBuffer2: Array<Byte> = Array<Byte>(getLength(), { i => 0 })
        file.read(byteBuffer2)
        file.seek(SeekPosition.Begin(getLength() - Int64(ID3v1Tag.TAG_LENGTH)))
        var bytesRead: Int64 = file.read(byteBuffer)
        if (bytesRead < Int64(ID3v1Tag.TAG_LENGTH)){
            throw BaseException("Not enough bytes read")
        }
        try {
            this.id3v1Tag = Option<ID3v1>.Some(ID3v1Tag(byteBuffer))
        } catch (e: Exception){
            this.id3v1Tag = Option<ID3v1>.None
        }
    }

    /**
     * The Function is hasId3v1Tag, Whether the ID3v1 tag is included
     *
     * @return Type of Bool
     * @since 0.31.4
     */
    public func hasId3v1Tag (): Bool {
        return match (this.id3v1Tag){
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
        return match (this.id3v2Tag){
            case Some(x) => true
            case None => false
        }
    }

    /**
     * The Function is hasCustomTag, Include custom labels
     *
     * @return Type of Bool
     * @since 0.31.4
     */
    public func hasCustomTag(): Bool {
        return match (this.customTag){
            case Some(x) => true
            case None => false
        }
    }

    /**
     * The Function is getId3v1Tag, Get Tags
     *
     * @return Type of Option<ID3v1>
     * @since 0.31.4
     */
    public func getId3v1Tag (): Option<ID3v1> {
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
    public func setId3v1Tag (id3v1Tag: Option<ID3v1>): Unit {
        this.id3v1Tag = id3v1Tag
    }

    /**
     * The Function is removeId3v1Tag, Remove id3v1tag
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func removeId3v1Tag (): Unit {
         this.id3v1Tag = Option<ID3v1>.None
    }

    /**
     * The Function is save, Save file, cannot overwrite source file
     *
     * @param newFilename of String
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func save (newFilename: String): Unit {
        var isExist: Bool = true
        try {
            FileInfo(newFilename).getCanonicalPath()
            ()
        }catch (e: Exception) {
            isExist = false
            ()
        }
        if (isExist && FileInfo(newFilename).getCanonicalPath() == super.path){
            throw IllegalArgumentException("Save filename same as source filename")
        }
        var saveFile: File = File(newFilename, AccessMode.ReadWrite, OpenMode.ForceCreate)
        if (!hasId3v2Tag() && !hasCustomTag() && this.frameCount == 0) {
            var sourceFile: File = File(super.path, AccessMode.Read, OpenMode.Open)
            var srcByte: Array<UInt8> = Array<UInt8>(getLength() - Int64(ID3v1Tag.TAG_LENGTH), {i => 0})
            sourceFile.read(srcByte)
            saveFile.write(srcByte)
        }
        if (hasId3v1Tag()) {
            var bytes: Array<Int8> = this.id3v1Tag.getOrThrow().toBytes()
            var byteBuffer: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(bytes)
            saveFile.write(byteBuffer)
        }
    }
}


