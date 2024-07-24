/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * Id3v22 version label
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is ID3v22Tag inherited from AbstractID3v2Tag
 * @since 0.32.5
 */
public class ID3v22Tag <: AbstractID3v2Tag {
    public static var VERSION: String = "2.0"

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

    /**
     * The Function is init constructor
     * 
     * @param buffer of Array<Int8>
     * @param obseleteFormat of Bool
     * @since 0.32.5
     */
    public init(buffer: Array<Int8>, obseleteFormat: Bool) {
        super(buffer, obseleteFormat)
        super.unpackTag(buffer)
    }

    protected override func unpackFlags(bytes: Array<Int8>): Unit {
        unsynchronisation = BufferTools.checkBit(bytes[Int64(FLAGS_OFFSET)], Int64(UNSYNCHRONISATION_BIT))
        compression = BufferTools.checkBit(bytes[Int64(FLAGS_OFFSET)], Int64(COMPRESSION_BIT))
    }

    protected override func packFlags(bytes: Array<Int8>, offset: Int32): Unit {
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(UNSYNCHRONISATION_BIT),
            unsynchronisation
        )
        bytes[Int64(offset) + Int64(FLAGS_OFFSET)] = BufferTools.setBit(
            bytes[Int64(offset) + Int64(FLAGS_OFFSET)],
            Int64(COMPRESSION_BIT),
            compression
        )
    }
}
