/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package mp3tag4cj.mp3tag4cj

public class ID3v2WWWFrameData <: AbstractID3v2FrameData & Equatable<ID3v2WWWFrameData> {
    protected var url: Option<String> = Option<String>.None

    public init(unsynchronisation: Bool) {
        super(unsynchronisation)
    }

    public init(unsynchronisation: Bool, url: Option<String>) {
        super(unsynchronisation)
        this.url = url
    }

    public init(unsynchronisation: Bool, bytes: Array<Int8>) {
        super(unsynchronisation)
        synchroniseAndUnpackFrameData(bytes)
    }

    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        try {
            url = BufferTools.byteBufferToString(bytes, 0, Int32(bytes.size))
        } catch (e: Exception) {
            url = Option<String>.Some("")
        }
    }

    public func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        if (url != Option<String>.None && url.getOrThrow().size > 0) {
            try {
                BufferTools.stringIntoByteBuffer(url.getOrThrow(), 0, url.getOrThrow().size, bytes, 0)
            } catch (e: Exception) {}
        }
        return bytes
    }

    public func getLength(): Int32 {
        var length: Int32 = 0
        if (url != Option<String>.None) {
            length = Int32(url.getOrThrow().toArray().size)
        }
        return length
    }

    public func getUrl(): Option<String> {
        return url
    }

    public func setUrl(url: Option<String>): Unit {
        this.url = url
    }

    public operator func ==(rhs: ID3v2WWWFrameData): Bool {
        return refEq(this, rhs)
    }

    public operator func !=(rhs: ID3v2WWWFrameData): Bool {
        return !refEq(this, rhs)
    }
}
