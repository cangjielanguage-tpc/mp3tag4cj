/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * CTOC Identify the corresponding data type
 */
package mp3agic

from std import collection.*
from okio import okio.*
from okio import nio.ByteBuffer

public class ID3v2ChapterTOCFrameData <: AbstractID3v2FrameData {
    protected var isRoots: Bool = false
    protected var isOrdereds: Bool = false
    protected var id: Option<String> = Option<String>.None
    protected var children: Option<Array<String>> = Option<Array<String>>.None
    protected var subframes: Option<ArrayList<ID3v2Frame>> = Option<ArrayList<ID3v2Frame>>.Some(ArrayList<ID3v2Frame>())

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
     * @param isRoot of Bool
     * @param isOrdered of Bool
     * @param id of Option<String>
     * @param children of Option<Array<String>>
     * @since 0.33.3
     */
    public init(unsynchronisation: Bool, isRoot: Bool, isOrdered: Bool, id: Option<String>, 
        children: Option<Array<String>>) {
        super(unsynchronisation)
        this.isRoots = isRoot
        this.isOrdereds = isOrdered
        this.id = id
        this.children = children
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

    /*
     * The Function is unpackFrameData
     *
     * @param bytes of Array<Int8>
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    @overflowWrapping
    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        var bb: ByteBuffer = ByteBuffer.wrap(BufferTools.transInt8ArrayToUInt8(bytes))

        id = Option<String>.Some(ByteBufferUtils.extractNullTerminatedString(bb))

        var flags: Int8 = Int8(bb.get())
        if ((flags & 0x01) == 0x01) {
            isRoots = true
        }
        if ((flags & 0x02) == 0x02) {
            isOrdereds = true
        }

        var childCount: Int32 = Int32(bb.get()) // TODO: 0xFF -> int = 255; byte = -128;

        children = Option<Array<String>>.Some(Array<String>(Int64(childCount), {i => ""}))

        for (i in 0..childCount) {
            children.getOrThrow()[Int64(i)] = ByteBufferUtils.extractNullTerminatedString(bb)
        }

        var offset: Int64 = bb.position()
        while (offset < bytes.size) {
            var frame: ID3v2Frame = ID3v2Frame(bytes, Int32(offset))
            frame.unpackFrame(bytes, Int32(offset))
            offset += Int64(frame.getLength())
            subframes.getOrDefault({ => ArrayList<ID3v2Frame>()}).append(frame)
        }
    }

    /**
     * The Function is addSubframe
     *
     * @param id of String
     * @param frame of AbstractID3v2FrameData
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit {
        subframes.getOrThrow().append(ID3v2Frame(id, frame.toBytes()))
    }

    /*
     * The Function is packFrameData
     *
     * @return Type of Array<Int8>
     * @since 0.33.3
     */
    protected func packFrameData(): Array<Int8> {
        var bb: ByteBuffer = ByteBuffer.allocate(Int64(getLength()))
        bb.put(id.getOrDefault({ => ""}).toUtf8Array())
        bb.put(UInt8(0))
        bb.put(UInt8(getFlags()))
        bb.put(UInt8(children.getOrThrow().size))

        for (child in children.getOrThrow()) {
            bb.put(child.toUtf8Array())
            bb.put(UInt8(0))
        }

        for (frame in subframes.getOrThrow()) {
            try {
                bb.put(BufferTools.transInt8ArrayToUInt8(frame.toBytes()))
            } catch (e: Exception) {
                println(e.toString())
            }
        }
        return BufferTools.transUInt8ArrayToInt8(bb.array())
    }

    /*
     * The Function is getFlags
     *
     * @return Type of Int8
     * @since 0.33.3
     */
    private func getFlags(): Int8 {
        var b: Int8 = 0
        if (isRoots) {
            b |= 0x01
        }
        if (isOrdereds) {
            b |= 0x02
        }
        return b
    }

    /**
     * The Function is isRoot
     *
     * @return Type of Bool
     * @since 0.33.3
     */
    public func isRoot(): Bool {
        return isRoots
    }

    /**
     * The Function is setRoot
     *
     * @param isRoot of Bool
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setRoot(isRoot: Bool): Unit {
        this.isRoots = isRoot
    }

    /**
     * The Function is isOrdered
     *
     * @return Type of Bool
     * @since 0.33.3
     */
    public func isOrdered(): Bool {
        return isOrdereds
    }

    /**
     * The Function is setOrdered
     *
     * @param isOrdered of Bool
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setOrdered(isOrdered: Bool): Unit {
        this.isOrdereds = isOrdered
    }

    /**
     * The Function is getId
     *
     * @return Type of Option<String>
     * @since 0.33.3
     */
    public func getId(): Option<String> {
        return id
    }

    /**
     * The Function is setId
     *
     * @param id of Option<String>
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setId(id: Option<String>): Unit {
        this.id = id
    }

    /**
     * The Function is getChildren
     *
     * @return Type of Option<Array<String>>
     * @since 0.33.3
     */
    public func getChildren(): Option<Array<String>> {
        return children
    }

    /**
     * The Function is setChildren
     *
     * @param children of Option<Array<String>>
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setChildren(children: Option<Array<String>>): Unit {
        this.children = children
    }

    /**
     * The Function is getSubframes
     *
     * @return Type of Option<ArrayList<ID3v2Frame>>
     * @since 0.33.3
     */
    public func getSubframes(): Option<ArrayList<ID3v2Frame>> {
        return subframes
    }

    /**
     * The Function is setSubframes
     *
     * @param subframes of Option<ArrayList<ID3v2Frame>>
     *
     * @return Type of Unit
     * @since 0.33.3
     */
    public func setSubframes(subframes: Option<ArrayList<ID3v2Frame>>): Unit {
        this.subframes = subframes
    }

    /**
     * The Function is getLength
     *
     * @return Type of Int32
     * @since 0.33.3
     */
    public func getLength(): Int32 {
        var length: Int32 = 3
        if (id != Option<String>.None) {
            length += Int32(id.getOrThrow().size)
        }
        if (children != Option<Array<String>>.None) {
            length += Int32(children.getOrThrow().size)
            for (child in children.getOrThrow()) {
                length += Int32(child.size)
            }
        }
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            for (frame in subframes.getOrThrow()) {
                length += Int32(frame.getLength())
            }
        }
        return length
    }

    /**
     * The Function is toString
     *
     * @return Type of String
     * @since 0.33.3
     */
    public func toString(): String {
        var builder: StringBuilder = StringBuilder()
        builder.append("ID3v2ChapterTOCFrameData [isRoot=")
        builder.append(isRoots)
        builder.append(", isOrdered=")
        builder.append(isOrdereds)
        builder.append(", id=")
        builder.append(id)
        builder.append(", children=");
        builder.append(children.toString());
        builder.append(", subframes=");
        if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
            if (subframes.getOrThrow().size > 0) {
                for (frame in subframes.getOrThrow()) {
                    builder.append(frame.getId())
                    builder.append(frame.getData())
                }
            } else {
                builder.append("[]")
            }
        }
        builder.append("]")
        return builder.toString()
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
        var childStr = ""
        if (children != Option<Array<String>>.None) {
            for (child in children.getOrThrow()) {
                childStr += child
            }
        }
        result = prime * result + Int32(childStr.hashCode())
        if (id == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(id.getOrThrow().hashCode())
        }
        if (isOrdereds) {
            result = prime * result + 1231
        } else {
            result = prime * result + 1237
        }
        if (isRoots) {
            result = prime * result + 1231
        } else {
            result = prime * result + 1237
        }
        if (subframes == Option<ArrayList<ID3v2Frame>>.None) {
            result = prime * result + 0
        } else {
            var subframesStr = ""
            if (subframes != Option<ArrayList<ID3v2Frame>>.None) {
                for (frame in subframes.getOrThrow()) {
                    subframesStr += frame.getData().toString()
                }
            }
            result = prime * result + Int32(subframesStr.hashCode())
        }
        return Int64(result)
    }
}
