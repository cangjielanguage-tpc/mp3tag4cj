package mp3agic

from std import io.*

public class ID3v2UrlFrameData <: AbstractID3v2FrameData & Equatable<ID3v2UrlFrameData> {
    protected var url: Option<String> = Option<String>.None
    protected var description: Option<EncodedText> = Option<EncodedText>.None

    public init(unsynchronisation: Bool) {
        super(unsynchronisation)
    }

    public init(unsynchronisation: Bool, description: Option<EncodedText>, url: Option<String>) {
        super(unsynchronisation)
        this.description = description
        this.url = url
    }

    public init(unsynchronisation: Bool, bytes: Array<Int8>) {
        super(unsynchronisation)
        super.synchroniseAndUnpackFrameData(bytes)
    }

    public override func toBytes(): Array<Int8> {
        return super.toBytes()
    }

    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        var marker: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, 1, Int32(bytes[0]))
        if (marker >= 0) {
            description = EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 1, Int64(marker - 1)))
            marker += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = EncodedText(bytes[0], "")
            marker = 1
        }
        try {
            url = Option<String>.Some(BufferTools.byteBufferToString(bytes, marker, Int32(bytes.size - Int64(marker))))
        } catch (e: Exception) {
            url = Option<String>.Some("")
        }
    }

    protected func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {i => 0})
        if (description != Option<EncodedText>.None) {
            bytes[0] = description.getOrThrow().getTextEncoding()
        } else {
            bytes[0] = 0
        }
        var marker: Int32 = 1
        if (description != Option<EncodedText>.None) {
            var descriptionBytes: Array<Int8> = description.getOrThrow().toBytes(true, true)
            BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.size, bytes, Int64(marker))
            marker += Int32(descriptionBytes.size)
        } else {
            marker++
            bytes[Int64(marker)] = 0
        }
        if (url != Option<String>.None && url.getOrThrow().size > 0) {
            try {
                BufferTools.stringIntoByteBuffer(url.getOrThrow(), 0, url.getOrThrow().size, bytes, Int64(marker))
            } catch (e: Exception) {}
        }
        return bytes
    }

    protected func getLength(): Int32 {
        var length: Int32 = 1
        if (description != Option<EncodedText>.None) {
            length += Int32(description.getOrThrow().toBytes(true, true).size)
        } else {
            length++
        }
        if (url != Option<String>.None) {
            length += Int32(url.getOrThrow().size)
        }
        return length
    }

    public func getDescription(): Option<EncodedText> {
        return description
    }

    public func setDescription(description: Option<EncodedText>): Unit {
        this.description = description
    }

    public func getUrl(): Option<String> {
        return url
    }

    public func setUrl(url: Option<String>): Unit {
        this.url = url
    }

    @overflowWrapping
    public override func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (description == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(description.getOrThrow().hashCode())
        }
        if (url == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(url.getOrThrow().hashCode())
        }
        return Int64(result)
    }

    public operator func ==(rhs: ID3v2UrlFrameData): Bool {
        return match (rhs as ID3v2UrlFrameData) {
            case Some(x) => refEq(this, x)
            case None => false
        }
    }

    public operator func !=(rhs: ID3v2UrlFrameData): Bool {
        return match (rhs as ID3v2UrlFrameData) {
            case Some(x) => !refEq(this, x)
            case None => false
        }
    }
}
