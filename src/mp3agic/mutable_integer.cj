/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Self increasing data
 */
package mp3agic

public class MutableInteger {
    private var value: Int32 = 0

    /**
     * The Function is init constructor
     * 
     * @param value of Int32
     * @since 0.31.4
     */
    public init(value: Int32) {
        this.value = value
    }

    /**
     * The Function is increment
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    public func increment(): Unit {
        value++
    }

    /**
     * The Function is getValue
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    public func getValue(): Int32 {
        return this.value
    }

    /**
     * The Function is setValue
     * 
     * @param value of Int32
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setValue(value: Int32): Unit {
        this.value = value
    }

    /**
     * The Function is hashCode
     * 
     * @return Type of Int64
     * @since 0.31.4
     */
    @overflowWrapping
    public func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = 1
        result = prime * result + value
        return Int64(result)
    }
}
