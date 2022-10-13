package mp3agic

from std import collection.*
from okio import okio.*
from okio import nio.ByteBuffer

public class ID3v2ChapterFrameData <: AbstractID3v2FrameData {
    protected var id: Option<String> = Option<String>.None
    protected var startTime: Int32 = 0
    protected var endTime: Int32 = 0
    protected var startOffset: Int32 = 0
    protected var endOffset: Int32 = 0
    protected var subframes: Option<ArrayList<ID3v2Frame>> = Option<ArrayList<ID3v2Frame>>.Some(ArrayList<ID3v2Frame>())

    public init(unsynchronisation: Bool) {
        super(unsynchronisation)
    }

    public init(unsynchronisation: Bool, id: Option<String>, startTime: Int32, endTime: Int32, startOffset: Int32, 
        endOffset: Int32) {
        super(unsynchronisation)
        this.id = id
        this.startTime = startTime
        this.endTime = endTime
        this.startOffset = startOffset
        this.endOffset = endOffset
    }

    public init(unsynchronisation: Bool, bytes: Array<Int8>) {
        super(unsynchronisation)
        synchroniseAndUnpackFrameData(bytes)
    }

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

    public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit {
        subframes.getOrThrow().append(ID3v2Frame(id, frame.toBytes()))
    }

    @overflowWrapping
    protected func packFrameData(): Array<Int8> {
        var bb: ByteBuffer = ByteBuffer.allocate(Int64(getLength()))
        bb.put(id.getOrDefault({ => ""}).toUtf8Array())
        bb.put(UInt8(0))

        bb.put(UInt8((startTime & 0x7F000000) >> 24))
        bb.put(UInt8((startTime & 0x00FF0000) >> 16))
        bb.put(UInt8((startTime & 0x0000FF00) >> 8))
        bb.put(UInt8(startTime & 0x000000FF))

        bb.put(UInt8((endTime & 0x7F000000) >> 24))
        bb.put(UInt8((endTime & 0x00FF0000) >> 16))
        bb.put(UInt8((endTime & 0x0000FF00) >> 8))
        bb.put(UInt8(endTime & 0x000000FF))

        bb.put(UInt8((startOffset & 0x7F000000) >> 24))
        bb.put(UInt8((startOffset & 0x00FF0000) >> 16))
        bb.put(UInt8((startOffset & 0x0000FF00) >> 8))
        bb.put(UInt8(startOffset & 0x000000FF))

        bb.put(UInt8((endOffset & 0x7F000000) >> 24))
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

    public func getId(): Option<String> {
        return id
    }

    public func setId(id: String): Unit {
        this.id = id
    }

    public func getStartTime(): Int32 {
        return startTime
    }

    public func setStartTime(startTime: Int32): Unit {
        this.startTime = startTime
    }

    public func getEndTime(): Int32 {
        return endTime
    }

    public func setEndTime(endTime: Int32): Unit {
        this.endTime = endTime
    }

    public func getStartOffset(): Int32 {
        return startOffset
    }

    public func setStartOffset(startOffset: Int32): Unit {
        this.startOffset = startOffset
    }

    public func getEndOffset(): Int32 {
        return endOffset
    }

    public func setEndOffset(endOffset: Int32): Unit {
        this.endOffset = endOffset
    }

    public func getSubframes(): Option<ArrayList<ID3v2Frame>> {
        return subframes
    }

    public func setSubframes(subframes: Option<ArrayList<ID3v2Frame>>): Unit {
        this.subframes = subframes
    }

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
}
