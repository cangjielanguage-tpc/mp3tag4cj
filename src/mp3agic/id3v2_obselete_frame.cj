/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Data encapsulation class of tag frame under observer
 */
package mp3agic

/**
 * The class is ID3v2ObseleteFrame inherited from ID3v2Frame
 * @since 0.32.5
 */
public class ID3v2ObseleteFrame <: ID3v2Frame {
    private static let HEADER_LENGTH: Int32 = 6
    private static let ID_OFFSET: Int32 = 0
    private static let ID_LENGTH: Int32 = 3
    private static let DATA_LENGTH_OFFSET_ZI: Int32 = 3

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

    protected override func unpackHeader(buffer: Array<Int8>, offset: Int32): Int32 {
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(
            buffer,
            offset + ID_OFFSET,
            ID_LENGTH
        )) {
            case Some(x) => id = x
            case None => ()
        }
        unpackDataLength(buffer, offset)
        return offset + HEADER_LENGTH
    }

    protected override func unpackDataLength(buffer: Array<Int8>, offset: Int32): Unit {
        dataLength = BufferTools.unpackInteger(
            Int8(0),
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET_ZI)],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET_ZI) + 1],
            buffer[Int64(offset) + Int64(DATA_LENGTH_OFFSET_ZI) + 2]
        )
    }

    public override func packFrame(bytes: Array<Int8>, offset: Int32): Unit {
        var bytesTmp = bytes
        var offsetTmp = offset
        throw NotSupportedException("Packing Obselete frames is not supported")
    }

    /**
     * The Function is getLength, Get the length of the label frame.
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public override func getLength(): Int32 {
        return dataLength + HEADER_LENGTH
    }
}
