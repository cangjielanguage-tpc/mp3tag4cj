/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * Id3v23 version label
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is ID3v23Tag inherited from AbstractID3v2Tag
 * @since 0.32.5
 */
public class ID3v23Tag <: AbstractID3v2Tag {
    public static let VERSION: String = "3.0"

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
    }
}
