/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * CHAP Identify the corresponding data type
 */
package mp3agic

from std import collection.*
from okio import okio.*
from okio import nio.ByteBuffer

public class ID3v2ChapterFrameData <: AbstractID3v2FrameData & Equatable<ID3v2ChapterFrameData> {
    protected var id: Option<String> = Option<String>.None
    protected var startTime: Int32 = 0
    protected var endTime: Int32 = 0
    protected var startOffset: Int32 = 0
    protected var endOffset: Int32 = 0
    protected var subframes: Option<ArrayList<ID3v2Frame>> = Option<ArrayList<ID3v2Frame>>.Some(ArrayList<ID3v2Frame>())

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @since 0.33.3
     */
    public init(unsynchronisation: Bool) {
        super(unsynchronisation)
    }

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @param id of Option<String>
     * @param startTime of Int32
     * @param endTime of Int32
     * @param startOffset of Int32
     * @param endOffset of Int32
     * @since 0.33.3
     */
    public init(
        unsynchronisation: Bool,
        id: Option<String>,
        startTime: Int32,
        endTime: Int32,
        startOffset: Int32,
        endOffset: Int32
    ) {
        super(unsynchronisation)
        this.id = id
        this.startTime = startTime
        this.endTime = endTime
        this.startOffset = startOffset
        this.endOffset = endOffset
    }

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @param bytes of Array<Int8>
     * @since 0.33.3
     */
    public init(unsynchronisation: Bool, bytes: Array<Int8>) {
        super(unsynchronisation)
        synchroniseAndUnpackFrameData(bytes)
    }

    @overflowWrapping
    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        var bb: ByteBuffer = ByteBuffer.wrap(BufferTools.transInt8ArrayToUInt8(bytes))
        id = Option<String>.Some(ByteBufferUtils.extractNullTerminatedString(bb))
        bb.position(id.getOrDefault({ => ""}).size + 1)
        startTime |= (Int32(bb.get()) << 24)
        startTime |= (Int32(bb.get()) << 16)
        startTime |= (Int32(bb.get()) << 8)
        startTime |= (Int32(bb.get()))
        endTime |= (Int32(bb.get()) << 24)
        endTime |= (Int32(bb.get()) << 16)
        endTime |= (Int32(bb.get()) << 8)
        endTime |= (Int32(bb.get()))
        startOffset |= (Int32(bb.get()) << 24)
        startOffset |= (Int32(bb.get()) << 16)
        startOffset |= (Int32(bb.get()) << 8)
        startOffset |= (Int32(bb.get()))
        endOffset |= (Int32(bb.get()) << 24)
        endOffset |= (Int32(bb.get()) << 16)
        endOffset |= (Int32(bb.get()) << 8)
        endOffset |= (Int32(bb.get()))
        var offset: Int64 = bb.position()
        while (offset < bytes.size) {
            var frame: ID3v2Frame = ID3v2Frame(bytes, Int32(offset))
            frame.unpackFrame(bytes, Int32(offset))
            offset += Int64(frame.getLength())
            subframes.getOrDefault({ => ArrayList<ID3v2Frame>()}).append(frame)
        }
    }

    /**
     * The Function is addSubframe
     * 
     * @param id of String
     * @param frame of AbstractID3v2FrameData
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit {
        subframes.getOrThrow().append(ID3v2Frame(id, frame.toBytes()))
    }

    @overflowWrapping
    protected func packFrameData(): Array<Int8> {
        var bb: ByteBuffer = ByteBuffer.allocate(Int64(getLength()))
        bb.put(id.getOrDefault({ => ""}).toUtf8Array())
        bb.put(UInt8(0))

        bb.put(UInt8((startTime & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((startTime & 0x00FF0000) >> 16))
        bb.put(UInt8((startTime & 0x0000FF00) >> 8))
        bb.put(UInt8(startTime & 0x000000FF))

        bb.put(UInt8((endTime & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((endTime & 0x00FF0000) >> 16))
        bb.put(UInt8((endTime & 0x0000FF00) >> 8))
        bb.put(UInt8(endTime & 0x000000FF))

        bb.put(UInt8((startOffset & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((startOffset & 0x00FF0000) >> 16))
        bb.put(UInt8((startOffset & 0x0000FF00) >> 8))
        bb.put(UInt8(startOffset & 0x000000FF))

        bb.put(UInt8((endOffset & Int32(0xFF000000)) >> 24))
        bb.put(UInt8((endOffset & 0x00FF0000) >> 16))
        bb.put(UInt8((endOffset & 0x0000FF00) >> 8))
        bb.put(UInt8(endOffset & 0x000000FF))
        for (frame in subframes.getOrDefault({ => ArrayList<ID3v2Frame>()})) {
            try {
                bb.put(BufferTools.transInt8ArrayToUInt8(frame.toBytes()))
            } catch (e: Exception) {
                println(e.toString())
            }
        }
        return BufferTools.transUInt8ArrayToInt8(bb.array())
    }

    /**
     * The Function is getId
     * 
     * @return Type of Option<String>
     * @since 0.33.3
     */
    public func getId(): Option<String> {
        return id
    }

    /**
     * The Function is setId
     * 
     * @param id of String
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setId(id: String): Unit {
        this.id = id
    }

    /**
     * The Function is getStartTime
     * 
     * @return Type of Int32
     * @since 0.33.3
     */
    public func getStartTime(): Int32 {
        return startTime
    }

    /**
     * The Function is setStartTime
     * 
     * @param startTime of Int32
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setStartTime(startTime: Int32): Unit {
        this.startTime = startTime
    }

    /**
     * The Function is getEndTime
     * 
     * @return Type of Int32
     * @since 0.33.3
     */
    public func getEndTime(): Int32 {
        return endTime
    }

    /**
     * The Function is setEndTime
     * 
     * @param endTime of Int32
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setEndTime(endTime: Int32): Unit {
        this.endTime = endTime
    }

    /**
     * The Function is getStartOffset
     * 
     * @return Type of Int32
     * @since 0.33.3
     */
    public func getStartOffset(): Int32 {
        return startOffset
    }

    /**
     * The Function is setStartOffset
     * 
     * @param startOffset of Int32
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setStartOffset(startOffset: Int32): Unit {
        this.startOffset = startOffset
    }

    /**
     * The Function is getEndOffset
     * 
     * @return Type of Int32
     * @since 0.33.3
     */
    public func getEndOffset(): Int32 {
        return endOffset
    }

    /**
     * The Function is setEndOffset
     * 
     * @param endOffset of Int32
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setEndOffset(endOffset: Int32): Unit {
        this.endOffset = endOffset
    }

    /**
     * The Function is getSubframes
     * 
     * @return Type of Option<ArrayList<ID3v2Frame>>
     * @since 0.33.3
     */
    public func getSubframes(): Option<ArrayList<ID3v2Frame>> {
        return subframes
    }

    /**
     * The Function is setSubframes
     * 
     * @param subframes of Option<ArrayList<ID3v2Frame>>
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setSubframes(subframes: Option<ArrayList<ID3v2Frame>>): Unit {
        this.subframes = subframes
    }

    /**
     * The Function is getLength
     * 
     * @return Type of Int32
     * @since 0.33.3
     */
    public func getLength(): Int32 {
        var length: Int32 = 1
        length += 16
        if (id != Option<String>.None) {
            length += Int32(id.getOrThrow().size)
        }
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            for (frame in subframes.getOrThrow()) {
                length += frame.getLength()
            }
        }
        return length
    }

    /**
     * The Function is toString
     * 
     * @return Type of String
     * @since 0.33.3
     */
    public func toString(): String {
        var builder: StringBuilder = StringBuilder()
        builder.append("ID3v2ChapterFrameData [id=")
        builder.append(id)
        builder.append(", startTime=")
        builder.append(startTime)
        builder.append(", endTime=")
        builder.append(endTime)
        builder.append(", startOffset=")
        builder.append(startOffset)
        builder.append(", endOffset=")
        builder.append(endOffset)
        builder.append(", subframes=")
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            for (frame in subframes.getOrThrow()) {
                builder.append(frame.getId())
                builder.append(frame.getData())
            }
        }
        builder.append("]")
        return builder.toString()
    }

    /**
     * The Function is hashCode
     * 
     * @return Type of Int64
     * @since 0.33.3
     */
    @overflowWrapping
    public override func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = 1
        result = prime * result + endOffset
        result = prime * result + endTime
        if (id == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(id.getOrThrow().hashCode())
        }
        result = prime * result + startOffset
        result = prime * result + startTime
        if (subframes == Option<ArrayList<ID3v2Frame>>.None) {
            result = prime * result + 0
        } else {
            var subframesStr = ""
            if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
                for (frame in subframes.getOrThrow()) {
                    subframesStr += frame.getData().toString()
                }
            }
            result = prime * result + Int32(subframesStr.hashCode())
        }
        return Int64(result)
    }

    /**
     * The Function is ==
     * 
     * @param rhs of ID3v2CommentFrameData
     * 
     * @return Type of Bool
     * @since 0.33.3
     */
    public operator func ==(rhs: ID3v2ChapterFrameData): Bool {
        return match (rhs as ID3v2ChapterFrameData) {
            case Some(x) => refEq(this, x)
            case None => false
        }
    }

    /**
     * The Function is !=
     * 
     * @param rhs of ID3v2CommentFrameData
     * 
     * @return Type of Bool
     * @since 0.33.3
     */
    public operator func !=(rhs: ID3v2ChapterFrameData): Bool {
        return match (rhs as ID3v2ChapterFrameData) {
            case Some(x) => !refEq(this, x)
            case None => false
        }
    }
}
