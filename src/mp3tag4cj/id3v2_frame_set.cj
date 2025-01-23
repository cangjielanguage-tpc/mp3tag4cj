/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * The whole label frame encapsulates the class
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is ID3v2FrameSet, The whole label frame encapsulates the class
 * @since 0.32.5
 */
public open class ID3v2FrameSet <: Equatable<ID3v2FrameSet> {
    private var id: String = ""
    private var frames: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>()

    /**
     * The Function is init constructor.
     *
     * @param id of String, Tag frame identification.
     * @since 0.32.5
     */
    public init(id: String) {
        this.id = id
        frames = ArrayList<ID3v2Frame>()
    }

    /**
     * The Function is getId, Get tag frame identification.
     *
     * @return Type of String
     * @since 0.32.5
     */
    public open func getId(): String {
        return id
    }

    /**
     * The Function is clear, Empty Label Frame Collection.
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func clear(): Unit {
        frames.clear()
    }

    /**
     * The Function is addFrame, Add label frame objects.
     *
     * @param frame of ID3v2Frame
     *
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func addFrame(frame: ID3v2Frame): Unit {
        frames.add(frame)
    }

    /**
     * The Function is getFrames, Get a collection of tag frames.
     *
     * @return Type of ArrayList<ID3v2Frame>
     * @since 0.32.5
     */
    public open func getFrames(): ArrayList<ID3v2Frame> {
        frames.sortBy(
            stable: true,
            comparator: {
                rht: ID3v2Frame, lht: ID3v2Frame =>
                if (rht.getId() < lht.getId()) {
                    return Ordering.LT
                }
                if (rht.getId() > lht.getId()) {
                    return Ordering.GT
                }
                return Ordering.EQ
            }
        )
        return frames
    }

    /**
     * The Function is toString
     *
     * @return Type of String
     * @since 0.32.5
     */
    public open func toString(): String {
        return this.id + ": " + frames.size.toString()
    }

    public operator func ==(rhs: ID3v2FrameSet): Bool {
        return refEq(this, rhs)
    }

    public operator func !=(rhs: ID3v2FrameSet): Bool {
        return !refEq(this, rhs)
    }
}
