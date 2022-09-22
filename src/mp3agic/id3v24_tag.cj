/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Id3v24 version label
 */
package mp3agic

/**
 * The class is ID3v24Tag inherited from AbstractID3v2Tag
 * @since 0.32.5
 */
public class ID3v24Tag <: AbstractID3v2Tag {
    public static let VERSION: String = "4.0"

    public static let ID_RECTIME: String = "TDRC"

    /**
     * The Function is init constructor
     * 
     * @since 0.32.5
     */
    public init() {
        super()
        version = VERSION
    }

    /**
     * The Function is init constructor
     * 
     * @param buffer of Array<Int8>
     * @since 0.32.5
     */
    public init(buffer: Array<Int8>) {
        super(buffer)
        super.unpackTag(buffer)
    }

    protected func unpackFlags(buffer: Array<Int8>): Unit {
        unsynchronisation = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(UNSYNCHRONISATION_BIT))
        extendedHeader = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(EXTENDED_HEADER_BIT))
        experimental = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(EXPERIMENTAL_BIT))
        footer = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(FOOTER_BIT))
    }

    protected func packFlags(bytes: Array<Int8>, offset: Int32): Unit {
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(UNSYNCHRONISATION_BIT),
            unsynchronisation
        )
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXTENDED_HEADER_BIT),
            extendedHeader
        )
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXPERIMENTAL_BIT),
            experimental
        )
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(FOOTER_BIT),
            footer
        )
    }

    protected func useFrameUnsynchronisation(): Bool {
        return unsynchronisation
    }

    protected func createFrame(buffer: Array<Int8>, currentOffset: Int32): ID3v2Frame {
        return ID3v24Frame(buffer, currentOffset)
    }

    protected func createFrame(id: String, data: Array<Int8>): ID3v2Frame {
        return ID3v24Frame(id, data)
    }

    /**
     * The Function is setGenreDescription
     * 
     * @param text of String
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setGenreDescription(text: String): Unit {
        var frameData: ID3v2TextFrameData = ID3v2TextFrameData(useFrameUnsynchronisation(), EncodedText(text))
        var frameSet: ID3v2FrameSet = ID3v2FrameSet("")
        var isNone: Bool = false
        match (getFrameSets().get(ID_GENRE)) {
            case Some(x) => frameSet = x
            case None => isNone = true
        }
        if (isNone) {
            frameSet = ID3v2FrameSet(ID_GENRE)
            getFrameSets().put(ID_GENRE, frameSet)
        }
        frameSet.clear()
        frameSet.addFrame(createFrame(ID_GENRE, frameData.toBytes()))
    }

    /**
     * The Function is getRecordingTime
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public func getRecordingTime(): Option<String> {
        match (extractTextFrameData(ID_RECTIME)) {
            case Some(x) =>
                match (x.getText()) {
                    case Some(y) => return y.toString()
                    case None => return Option<String>.None
                }
            case None => return Option<String>.None
        }
    }

    /**
     * The Function is setRecordingTime
     * 
     * @param recTime of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setRecordingTime(recTime: Option<String>): Unit {
        match (recTime) {
            case Some(x) =>
                if (x.size > 0) {
                    invalidateDataLength()
                    var frameData: ID3v2TextFrameData = ID3v2TextFrameData(useFrameUnsynchronisation(), EncodedText(x))
                    addFrame(createFrame(ID_RECTIME, frameData.toBytes()), true)
                }
            case None => ()
        }
    }
}
