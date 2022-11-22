/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Id3v2 tag frame data type.
 */
package mp3agic

from std import io.*
from std import collection.*
from std import random.*

public open class ID3v2Frame <: Hashable & Equatable<ID3v2Frame> {
    private static let HEADER_LENGTH: Int32 = 10
    private static let ID_OFFSET: Int32 = 0
    private static let ID_LENGTH: Int32 = 4
    protected static let DATA_LENGTH_OFFSET: Int32 = 4
    private static let FLAGS1_OFFSET: Int32 = 8
    private static let FLAGS2_OFFSET: Int32 = 9
    private static let PRESERVE_TAG_BIT: Int32 = 6
    private static let PRESERVE_FILE_BIT: Int32 = 5
    private static let READ_ONLY_BIT: Int32 = 4
    private static let GROUP_BIT: Int32 = 6
    private static let COMPRESSION_BIT: Int32 = 3
    private static let ENCRYPTION_BIT: Int32 = 2
    private static let UNSYNCHRONISATION_BIT: Int32 = 1
    private static let DATA_LENGTH_INDICATOR_BIT: Int32 = 0

    public var id: String = ""
    protected var dataLength: Int32 = 0
    protected var data: Array<Int8> = Array<Int8>()
    private var preserveTag: Bool = false
    private var preserveFile: Bool = false
    private var readOnly: Bool = false
    private var group: Bool = false
    private var compression: Bool = false
    private var encryption: Bool = false
    private var unsynchronisation: Bool = false
    private var dataLengthIndicator: Bool = false

    /**
     * The Function is init constructor.
     * 
     * @param buffer of Array<Int8>, Data of the whole label frame.
     * @param offset of Int32, Offset from label start.
     * @since 0.32.5
     */
    public init(buffer: Array<Int8>, offset: Int32) {
        var bufferTmp = buffer
        var offsetTmp = offset
    }

    /**
     * The Function is init constructor.
     * 
     * @param id of String, Tag frame ID.
     * @param data of Array<Int8>, Label frame data.
     * @since 0.32.5
     */
    public init(id: String, data: Array<Int8>) {
        this.id = id
        this.data = data
        dataLength = Int32(data.size)
    }

    /**
     * The Function is unpackFrame, Extract byte data.
     * 
     * @param buffer of Array<Int8>, Offset from label start.
     * @param offset of Int32, Offset from label start.
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func unpackFrame(buffer: Array<Int8>, offset: Int32): Unit {
        var dataOffset: Int32 = unpackHeader(buffer, offset) //解析标签帧，帧头数据
        sanityCheckUnpackedHeader() //检查标签帧 帧头标志的合法性
        data = BufferTools.copyBuffer(buffer, Int64(dataOffset), Int64(dataLength))
    }

    protected open func unpackHeader(buffer: Array<Int8>, offset: Int32): Int32 {
        //标签帧前4个字符 代表标签帧的标识
        //给成员id赋值
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(
            buffer,
            offset + ID_OFFSET,
            ID_LENGTH
        )) {
            case Some(x) => id = x
            case None => ()
        }
        unpackDataLength(buffer, offset) //计算标签帧 长度， 不包含 帧头的10个字节
        unpackFlags(buffer, offset) // 接续数据帧头中的标志，位置在帧头的9字节 和 10字节
        return offset + HEADER_LENGTH
    }

    protected open func unpackDataLength(buffer: Array<Int8>, offset: Int32): Unit {
        dataLength = BufferTools.unpackInteger(
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET)],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 1],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 2],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 3]
        )
    } //给成员dataLength 计算标签帧 长度， 不包含 帧头的10个字节

    private func unpackFlags(buffer: Array<Int8>, offset: Int32): Unit {
        //解析标签帧的 帧头标记数据
        //给成员
        preserveTag = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS1_OFFSET)], Int64(PRESERVE_TAG_BIT))
        preserveFile = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS1_OFFSET)], Int64(PRESERVE_FILE_BIT))
        readOnly = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS1_OFFSET)], Int64(READ_ONLY_BIT))
        group = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS2_OFFSET)], Int64(GROUP_BIT))
        compression = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS2_OFFSET)], Int64(COMPRESSION_BIT))
        encryption = BufferTools.checkBit(buffer[Int64(offset) + Int64(FLAGS2_OFFSET)], Int64(ENCRYPTION_BIT))
        unsynchronisation = BufferTools.checkBit(
            buffer[Int64(offset) + Int64(FLAGS2_OFFSET)],
            Int64(UNSYNCHRONISATION_BIT)
        )
        dataLengthIndicator = BufferTools.checkBit(
            buffer[Int64(offset) + Int64(FLAGS2_OFFSET)],
            Int64(DATA_LENGTH_INDICATOR_BIT)
        )
    }

    protected func sanityCheckUnpackedHeader(): Unit {
        for (i in 0..id.size) {
            if (!((id.charAt(i) >= 'A' && id.charAt(i) <= 'Z') || (id.charAt(i) >= '0' && id.charAt(i) <= '9'))) {
                throw InvalidDataException("Not a valid frame - invalid tag ")
            }
        }
    }

    /**
     * The Function is toBytes, Convert label frame object to byte data.
     * 
     * @return Type of Array<Int8>
     * @since 0.32.5
     */
    public open func toBytes(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {i => 0})
        packFrame(bytes, 0)
        return bytes
    }

    public open func toBytes(bytes: Array<Int8>, offset: Int32): Unit {
        packFrame(bytes, offset)
    }

    public open func packFrame(bytes: Array<Int8>, offset: Int32): Unit {
        packHeader(bytes, offset)
        BufferTools.copyIntoByteBuffer(data, 0, data.size, bytes, Int64(offset) + Int64(HEADER_LENGTH))
    }

    private func packHeader(bytes: Array<Int8>, i: Int32): Unit {
        var iTmp = i
        try {
            BufferTools.stringIntoByteBuffer(id, 0, id.size, bytes, 0)
        } catch (e: Exception) {}
        BufferTools.copyIntoByteBuffer(packDataLength(), 0, 4, bytes, 4)
        BufferTools.copyIntoByteBuffer(packFlags(), 0, 2, bytes, 8)
    }

    protected open func packDataLength(): Array<Int8> {
        return BufferTools.packInteger(dataLength)
    }

    private func packFlags(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(2, {i => 0})
        bytes[0] = BufferTools.setBit(bytes[0], Int64(PRESERVE_TAG_BIT), preserveTag)
        bytes[0] = BufferTools.setBit(bytes[0], Int64(PRESERVE_FILE_BIT), preserveFile)
        bytes[0] = BufferTools.setBit(bytes[0], Int64(READ_ONLY_BIT), readOnly)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(GROUP_BIT), group)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(COMPRESSION_BIT), compression)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(ENCRYPTION_BIT), encryption)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(UNSYNCHRONISATION_BIT), unsynchronisation)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(DATA_LENGTH_INDICATOR_BIT), dataLengthIndicator)
        return bytes
    }

    /**
     * The Function is getId
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public open func getId(): String {
        return id
    }

    /**
     * The Function is getDataLength
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public open func getDataLength(): Int32 {
        return dataLength
    }

    /**
     * The Function is getLength, Get the length of the label frame.
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public open func getLength(): Int32 {
        return dataLength + HEADER_LENGTH
    }

    /**
     * The Function is getData, Get the data length of the tag frame.
     * 
     * @return Type of Array<Int8>
     * @since 0.32.5
     */
    public open func getData(): Array<Int8> {
        return data
    }

    /**
     * The Function is setData
     * 
     * @param data of Array<Int8>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setData(data: Array<Int8>): Unit {
        this.data = data
        this.dataLength = Int32(data.size)
    }

    /**
     * The Function is hasDataLengthIndicator
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasDataLengthIndicator(): Bool {
        return dataLengthIndicator
    }

    /**
     * The Function is hasCompression
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasCompression(): Bool {
        return compression
    }

    /**
     * The Function is hasEncryption
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasEncryption(): Bool {
        return encryption
    }

    /**
     * The Function is hasGroup
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasGroup(): Bool {
        return group
    }

    /**
     * The Function is hasPreserveFile
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasPreserveFile(): Bool {
        return preserveFile
    }

    /**
     * The Function is hasPreserveTag
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasPreserveTag(): Bool {
        return preserveTag
    }

    /**
     * The Function is isReadOnly
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func isReadOnly(): Bool {
        return readOnly
    }

    /**
     * The Function is hasUnsynchronisation
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasUnsynchronisation(): Bool {
        return unsynchronisation
    }

    /**
     * The Function is hashCode.Implementing the onresponselistener interface is the hashcode method of the hashable interface
     * that needs to be implemented.
     * 
     * @return Type of Int64
     * @since 0.32.5
     */
    @overflowWrapping
    public open func hashCode(): Int64 {
        var arr: Array<String> = [
            compression.toString(),
            dataLength.toString(),
            dataLengthIndicator.toString(),
            encryption.toString(),
            group.toString(),
            id.toString(),
            preserveFile.toString(),
            preserveTag.toString(),
            readOnly.toString(),
            unsynchronisation.toString()
        ]
        return 31 * arr.toString().hashCode() + data.toString().hashCode()
    }

    /**
     * Implementing the onresponselistener interface is the == method of the equatable interface
     * that needs to be implemented.
     * 
     * @param rhs of OnResponseListener
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open operator func ==(rhs: ID3v2Frame): Bool {
        return match (rhs as ID3v2Frame) {
            case Some(x) => refEq(this, x)
            case None => false
        }
    }

    /**
     * Implementing the onresponselistener interface is the != method of the equatable interface
     * that needs to be implemented.
     * 
     * @param rhs of OnResponseListener
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open operator func !=(rhs: ID3v2Frame): Bool {
        return match (rhs as ID3v2Frame) {
            case Some(x) => !refEq(this, x)
            case None => false
        }
    }

    public init() {}
}
