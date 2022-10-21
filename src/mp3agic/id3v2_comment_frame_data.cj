/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * COMM, USLT Identify data type
 */
package mp3agic

from std import io.*

/**
 * The class is ID3v2CommentFrameData inherited from AbstractID3v2FrameData & Hashable & Equatable<ID3v2CommentFrameData>
 * @since 0.32.5
 */
public class ID3v2CommentFrameData <: AbstractID3v2FrameData & Hashable & Equatable<ID3v2CommentFrameData> {
    private static let DEFAULT_LANGUAGE: String = "eng"
    private var language: Option<String> = Option<String>.None
    private var description: Option<EncodedText> = Option<EncodedText>.None
    private var comment: Option<EncodedText> = Option<EncodedText>.None

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
     * @param language of Option<String>
     * @param description of Option<EncodedText>
     * @param comment of Option<EncodedText>
     * @since 0.33.3
     */
    public init(unsynchronisation: Bool, language: Option<String>, description: Option<EncodedText>, 
        comment: Option<EncodedText>) {
        super(unsynchronisation)
        if (description != Option<EncodedText>.None) {
            if (comment != Option<EncodedText>.None) {
                if (description.getOrThrow().getTextEncoding() != comment.getOrThrow().getTextEncoding()) {
                    throw Exception("description and comment must have same text encoding")
                }
            }
        }
        this.language = language
        this.description = description
        this.comment = comment
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

    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        try {
            language = Option<String>.Some(BufferTools.byteBufferToString(bytes, 1, 3))
        } catch (e: Exception) {
            language = Option<String>.Some("")
        }
        var marker: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, 4, Int32(bytes[0]))
        if (marker >= Int32(4)) {
            description = Option<EncodedText>.Some(
                EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 4, Int64(marker) - 4)))
            marker += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = Option<EncodedText>.Some(EncodedText(bytes[0], ""))
            marker = 4
        }
        comment = Option<EncodedText>.Some(
            EncodedText(bytes[0], BufferTools.copyBuffer(bytes, Int64(marker), bytes.size - Int64(marker))))
    }

    protected func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {i => 0})
        if (comment != Option<EncodedText>.None) {
            bytes[0] = comment.getOrThrow().getTextEncoding()
        } else {
            bytes[0] = 0
        }
        var langPadded: String
        if (language == Option<String>.None) {
            langPadded = DEFAULT_LANGUAGE
        } else if (language.getOrThrow().size > 3) {
            langPadded = language.getOrThrow().substring(0, 3)
        } else {
            langPadded = BufferTools.padStringRight(language.getOrThrow(), 3, '\u{0}')
        }
        try {
            BufferTools.stringIntoByteBuffer(langPadded, 0, 3, bytes, 1)
        } catch (e: Exception) {}
        var marker: Int32 = 4
        if (description != Option<EncodedText>.None) {
            var descriptionBytes: Array<Int8> = description.getOrThrow().toBytes(true, true)
            BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.size, bytes, Int64(marker))
            marker += Int32(descriptionBytes.size)
        } else {
            var terminatorBytes: Array<Int8>
            if (comment != Option<EncodedText>.None) {
                terminatorBytes = comment.getOrThrow().getTerminator()
            } else {
                terminatorBytes = [0]
            }
            BufferTools.copyIntoByteBuffer(terminatorBytes, 0, terminatorBytes.size, bytes, Int64(marker))
            marker += Int32(terminatorBytes.size)
        }
        if (comment != Option<EncodedText>.None) {
            var commentBytes: Array<Int8> = comment.getOrThrow().toBytes(true, false)
            BufferTools.copyIntoByteBuffer(commentBytes, 0, commentBytes.size, bytes, Int64(marker))
        }
        return bytes
    }

    protected func getLength(): Int32 {
        var length: Int32 = 4
        if (description != Option<EncodedText>.None) {
            length += Int32(description.getOrThrow().toBytes(true, true).size)
        } else {
            if (comment != Option<EncodedText>.None) {
                length += Int32(comment.getOrThrow().getTerminator().size)
            } else {
                length += 1
            }
        }
        if (comment != Option<EncodedText>.None) {
            length += Int32(comment.getOrThrow().toBytes(true, false).size)
        }
        return length
    }

    /**
     * The Function is getLanguage
     *
     * @return Type of Option<String>
     * @since 0.33.3
     */
    public func getLanguage(): Option<String> {
        return language
    }

    /**
     * The Function is setLanguage
     *
     * @param language of Option<String>
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setLanguage(language: Option<String>): Unit {
        this.language = language
    }

    /**
     * The Function is getComment
     *
     * @return Type of Option<EncodedText>
     * @since 0.33.3
     */
    public func getComment(): Option<EncodedText> {
        return comment
    }

    /**
     * The Function is setComment
     *
     * @param comment of Option<EncodedText>
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setComment(comment: Option<EncodedText>): Unit {
        this.comment = comment
    }

    /**
     * The Function is getDescription
     *
     * @return Type of Option<EncodedText>
     * @since 0.33.3
     */
    public func getDescription(): Option<EncodedText> {
        return description
    }

    /**
     * The Function is setDescription
     *
     * @param description of Option<EncodedText>
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setDescription(description: Option<EncodedText>): Unit {
        this.description = description
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
        var result: Int32 = Int32(super.hashCode())
        if (comment == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(comment.getOrThrow().hashCode())
        }
        if (description == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(description.getOrThrow().hashCode())
        }
        if (language == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(language.getOrThrow().hashCode())
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
    public operator func ==(rhs: ID3v2CommentFrameData): Bool {
        return match (rhs as ID3v2CommentFrameData) {
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
    public operator func !=(rhs: ID3v2CommentFrameData): Bool {
        return match (rhs as ID3v2CommentFrameData) {
            case Some(x) => !refEq(this, x)
            case None => false
        }
    }
}
