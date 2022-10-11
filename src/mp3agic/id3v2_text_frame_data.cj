/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Id3v2 tag frame data class
 */
package mp3agic

from std import random.*

/**
 * The class is ID3v2TextFrameData inherited from AbstractID3v2FrameData & Hashable & Equatable<ID3v2TextFrameData>
 * @since 0.32.5
 */
public class ID3v2TextFrameData <: AbstractID3v2FrameData & Hashable & Equatable<ID3v2TextFrameData> {
    protected var text: Option<EncodedText> = Option<EncodedText>.None

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @since 0.32.5
     */
    public init(unsynchronisation: Bool) {
        super(unsynchronisation)
    }

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @param text of EncodedText
     * @since 0.32.5
     */
    public init(unsynchronisation: Bool, text: EncodedText) {
        super(unsynchronisation);
        this.text = text
    }

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @param bytes of Array<Int8>
     * @since 0.32.5
     */
    public init(unsynchronisation: Bool, bytes: Array<Int8>) {
        super(unsynchronisation)
        synchroniseAndUnpackFrameData(bytes)
    }

    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        text = EncodedText(
            bytes[0],
            BufferTools.transUInt8ArrayToInt8(
                BufferTools.copyBuffer(BufferTools.transInt8ArrayToUInt8(bytes), 1, bytes.size - 1))
        )
    }

    protected func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {i => 0})
        if (text != Option<EncodedText>.None) {
            bytes[0] = text.getOrThrow().getTextEncoding()
            var textBytes: Array<Int8> = text.getOrThrow().toBytes(true, false)
            if (textBytes.size > 0) {
                BufferTools.copyIntoByteBuffer(textBytes, 0, textBytes.size, bytes, 1)
            }
        }
        return bytes
    }

    @overflowWrapping
    protected func getLength(): Int32 {
        var length: Int32 = 1
        if (text != Option<EncodedText>.None) {
            length += Int32(text.getOrThrow().toBytes(true, false).size)
        }
        return length
    }

    /**
     * The Function is getText, Get encoding conversion type.
     * 
     * @return Type of Option<EncodedText>
     * @since 0.32.5
     */
    public func getText(): Option<EncodedText> {
        return text
    }

    /**
     * The Function is setText
     * 
     * @param text of EncodedText
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setText(text: EncodedText): Unit {
        this.text = Option<EncodedText>.Some(text)
    }

    /**
     * The Function is hashCode
     * 
     * @return Type of Int64
     * @since 0.32.5
     */
    @overflowWrapping
    public func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (text == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(text.getOrThrow().hashCode())
        }
        return Int64(result)
    }

    public operator func ==(rhs: ID3v2TextFrameData): Bool {
        return match (rhs as ID3v2TextFrameData) {
            case Some(x) => refEq(this, x)
            case None => false
        }
    }

    public operator func !=(rhs: ID3v2TextFrameData): Bool {
        return match (rhs as ID3v2TextFrameData) {
            case Some(x) => !refEq(this, x)
            case None => false
        }
    }
}
