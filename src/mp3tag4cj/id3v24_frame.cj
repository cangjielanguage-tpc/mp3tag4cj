/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * ID3v24 label frame data encapsulation class
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is ID3v24Frame inherited from ID3v2Frame
 * @since 0.32.5
 */
public class ID3v24Frame <: ID3v2Frame {
    /**
     * The Function is init constructor
     * 
     * @param buffer of Array<Int8>
     * @param offset of Int32
     * @since 0.32.5
     */
    public init(buffer: Array<Int8>, offset: Int32) {
        super(buffer, offset)
        super.unpackFrame(buffer, offset)
    }

    /**
     * The Function is init constructor
     * 
     * @param id of String
     * @param data of Array<Int8>
     * @since 0.32.5
     */
    public init(id: String, data: Array<Int8>) {
        super(id, data)
    }

    protected func unpackDataLength(buffer: Array<Int8>, offset: Int32): Unit {
        dataLength = BufferTools.unpackSynchsafeInteger(
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET)],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 1],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 2],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET) + 3]
        )
    }

    protected func packDataLength(): Array<Int8> {
        return BufferTools.packSynchsafeInteger(dataLength)
    }
}
