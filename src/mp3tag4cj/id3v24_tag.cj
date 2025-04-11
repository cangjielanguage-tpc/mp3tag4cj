/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * Id3v24 version label
 */
package mp3tag4cj.mp3tag4cj

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
     * @since 0.34.3
     */
    public init() {
        super()
        version = VERSION
    }

    public init(buffer: Array<Int8>) {
        super(buffer)
        super.unpackTag(buffer)
    }

    /*
     * The Function is unpackFlags
     *
     * @param buffer of Array<Int8>
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    protected func unpackFlags (buffer: Array<Int8>): Unit {
        unsynchronisation = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(UNSYNCHRONISATION_BIT))
        extendedHeader = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(EXTENDED_HEADER_BIT))
        experimental = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(EXPERIMENTAL_BIT))
        footer = BufferTools.checkBit(buffer[Int64(FLAGS_OFFSET)], Int64(FOOTER_BIT))
    }

    /*
     * The Function is packFlags
     *
     * @param bytes of Array<Int8>
     * @param offset of Int32
     *
     * @return Type of Unit
     * @since 0.34.3
     */
    protected func packFlags(bytesDes: Array<Int8>, offset: Int32): Unit {
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(UNSYNCHRONISATION_BIT),
            unsynchronisation
        )
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXTENDED_HEADER_BIT),
            extendedHeader
        )
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(EXPERIMENTAL_BIT),
            experimental
        )
        bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytesDes[Int64(offset) + Int64(FLAGS_OFFSET)],
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
