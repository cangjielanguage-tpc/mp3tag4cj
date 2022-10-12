package mp3agic

from std import io.*

public class ID3v2WWWFrameData <: AbstractID3v2FrameData {

    protected var url: Option<String> = Option<String>.None
    
    public init (unsynchronisation: Bool){
        super(unsynchronisation)
    }

    public init (unsynchronisation: Bool, url: Option<String>){
        super(unsynchronisation)
        this.url = url
    }

    public init (unsynchronisation: Bool, bytes: Array<Int8>){
        super(unsynchronisation)
        synchroniseAndUnpackFrameData(bytes)
    }

    protected func unpackFrameData (bytes: Array<Int8>): Unit {
		try {
			url = BufferTools.byteBufferToString(bytes, 0, Int32(bytes.size))
		} catch (e: Exception) {
			url = Option<String>.Some("")
		}
    }

    public func packFrameData (): Array<Int8> {
		var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), { i => 0 })
		if (url != Option<String>.None && url.getOrThrow().size > 0) {
			try {
				BufferTools.stringIntoByteBuffer(url.getOrThrow(), 0, url.getOrThrow().size, bytes, 0)
			} catch (e: Exception) {}
		}
		return bytes
    }

    protected func getLength (): Int32 {
		var length: Int32 = 0
		if (url != Option<String>.None) {
		    length = Int32(url.getOrThrow().size)
		}
		return length
    }

    public func getUrl (): Option<String> {
        return url
    }

    public func setUrl (url: Option<String>): Unit {
        this.url = url
    }
}


