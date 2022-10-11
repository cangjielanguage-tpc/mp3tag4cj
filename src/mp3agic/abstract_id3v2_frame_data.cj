/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Id3v2 tag frame data abstract class
 */
package mp3agic

/**
 * The class is AbstractID3v2FrameData
 * @since 0.32.5
 */
public abstract class AbstractID3v2FrameData {
    var unsynchronisation: Bool = false

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @since 0.32.5
     */
    public init(unsynchronisation: Bool) {
        this.unsynchronisation = unsynchronisation
    }

    protected open func synchroniseAndUnpackFrameData(bytes: Array<Int8>): Unit {
        if (unsynchronisation && BufferTools.sizeSynchronisationWouldSubtract(bytes) > 0) {
            var synchronisedBytes: Array<Int8> = BufferTools.synchroniseBuffer(bytes)
            unpackFrameData(synchronisedBytes)
        } else {
            unpackFrameData(bytes)
        }
    }

    protected open func packAndUnsynchroniseFrameData(): Array<Int8> {
        var bytes: Array<Int8> = packFrameData()
        if (unsynchronisation && BufferTools.sizeUnsynchronisationWouldAdd(bytes) > 0) {
            return BufferTools.unsynchroniseBuffer(bytes)
        }
        return bytes
    }

    protected open func toBytes(): Array<Int8> {
        return packAndUnsynchroniseFrameData()
    }

    /**
     * The Function is hashCode
     * 
     * @return Type of Int64
     * @since 0.32.5
     */
    @overflowWrapping
    public open func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = 1
        if (unsynchronisation) {
            result = prime * result + 1231
        } else {
            result = prime * result + 1237
        }
        return Int64(result)
    }

    protected func unpackFrameData(bytes: Array<Int8>): Unit

    protected func packFrameData(): Array<Int8>

    protected func getLength(): Int32
}
