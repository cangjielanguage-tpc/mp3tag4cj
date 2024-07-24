/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * Byte operation tool
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is BufferTools
 * @since 0.31.4
 */
public class BufferTools {
    private static let defaultCharsetName: String = "iso-8859-1"

    private init() {}

    /**
     * The Function is byteBufferToStringIgnoringEncodingIssues, Gets the data of the specified offset and length in
     * the byte array
     * 
     * @param bytes of Array<Byte>, Get byte array of data
     * @param offset of Int32, Offset of source data
     * @param length of Int32, Data length
     * 
     * @return Type of Option<String>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func byteBufferToStringIgnoringEncodingIssues(bytes: Array<Byte>, offset: Int32, length: Int32): Option<String> {
        try {
            return byteBufferToString(bytes, offset, length, defaultCharsetName)
        } catch (e: Exception) {
            return Option<String>.None
        }
    }

    public static func byteBufferToStringIgnoringEncodingIssues(bytes: Array<Int8>, offset: Int32, length: Int32): Option<String> {
        try {
            return byteBufferToString(bytes, offset, length, defaultCharsetName)
        } catch (e: Exception) {
            return Option<String>.None
        }
    }

    /**
     * The Function is byteBufferToString, Gets the data of the specified offset and length in the byte array
     * 
     * @param bytes of Array<Byte>, Get byte array of data
     * @param offset of Int32, Offset of source data
     * @param length of Int32, Data length
     * 
     * @return Type of String
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func byteBufferToString(bytes: Array<Byte>, offset: Int32, length: Int32): String {
        return byteBufferToString(bytes, offset, length, defaultCharsetName);
    }

    public static func byteBufferToString(bytes: Array<Int8>, offset: Int32, length: Int32): String {
        return byteBufferToString(bytes, offset, length, defaultCharsetName);
    }

    /**
     * The Function is byteBufferToString, Gets the data of the specified offset and length in the byte array
     * 
     * @param bytes of Array<Byte>, Get byte array of data
     * @param offset of Int32, Offset of source data
     * @param length of Int32, Data length
     * @param charsetName of String, Character set name
     * 
     * @return Type of String
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func byteBufferToString(bytes: Array<Byte>, offset: Int32, length: Int32, _: String): String {
        if (length < 1) {
            return ""
        }
        unsafe {
        return String.fromUtf8Unchecked(bytes.slice(Int64(offset), Int64(length)))
        }
    }

    @OverflowWrapping
    public static func byteBufferToString(bytes: Array<Int8>, offset: Int32, length: Int32, _: String): String {
        if (length < 1) {
            return ""
        }
        unsafe {
        return String.fromUtf8Unchecked(BufferTools.transInt8ArrayToUInt8(bytes.slice(Int64(offset), Int64(length))))
        }
    }

    /**
     * The Function is stringToByteBufferIgnoringEncodingIssues, According to the length of the string,
     * the offset gets the byte array
     * 
     * @param s of String, Source string
     * @param offset of Int64, Start offset
     * @param length of Int64, Data length
     * 
     * @return Type of Option<Array<Byte>>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func stringToByteBufferIgnoringEncodingIssues(s: String, offset: Int64, length: Int64): Option<Array<Byte>> {
        try {
            return stringToByteBuffer(s, offset, length)
        } catch (e: Exception) {
            return Option<Array<Byte>>.None
        }
    }

    /**
     * The Function is stringToByteBuffer, According to the length of the string the offset gets the byte array
     * 
     * @param s of String, Source string
     * @param offset of Int64, Start offset
     * @param length of Int64, Data length
     * 
     * @return Type of Array<Byte>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func stringToByteBuffer(s: String, offset: Int64, length: Int64): Array<Byte> {
        return stringToByteBuffer(s, offset, length, defaultCharsetName)
    }

    /**
     * The Function is stringToByteBuffer, According to the length of the string the offset gets the byte array
     * 
     * @param s of String, Source string
     * @param offset of Int64, Start offset
     * @param length of Int64, Data length
     * @param charsetName of String, Character set name
     * 
     * @return Type of Array<Byte>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func stringToByteBuffer(s: String, offset: Int64, length: Int64, _: String): Array<Byte> {
        var stringToCopy: String = s[offset..length + offset]
        return stringToCopy.toArray()
    }

    /**
     * The Function is stringIntoByteBuffer, string into the specified byte array
     * 
     * @param s of String, Source string
     * @param offset of Int64, Start offset
     * @param length of Int64, Data length
     * @param bytes of Array<Byte>, Target byte array
     * @param destOffset of Int64, Target byte array offset
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func stringIntoByteBuffer(
        s: String,
        offset: Int64,
        length: Int64,
        bytes: Array<Byte>,
        destOffset: Int64
    ): Unit {
        stringIntoByteBuffer(s, offset, length, bytes, destOffset, defaultCharsetName)
    }

    public static func stringIntoByteBuffer(
        s: String,
        offset: Int64,
        length: Int64,
        bytes: Array<Int8>,
        destOffset: Int64
    ): Unit {
        stringIntoByteBuffer(s, offset, length, bytes, destOffset, defaultCharsetName)
    }

    /**
     * The Function is stringIntoByteBuffer, string into the specified byte array
     * 
     * @param s of String, Source string
     * @param offset of Int64, Start offset
     * @param length of Int64, Data length
     * @param bytes of Array<Byte>, Target byte array
     * @param destOffset of Int64, Target byte array offset
     * @param charsetName of String, Character set name
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func stringIntoByteBuffer(
        s: String,
        offset: Int64,
        length: Int64,
        bytes: Array<Byte>,
        destOffset: Int64,
        _: String
    ): Unit {
        var stringToCopy: String = s[offset..offset + length]
        var srcBytes: Array<UInt8> = stringToCopy.toArray()
        if (srcBytes.size > 0) {
            srcBytes.copyTo(bytes, offset, destOffset, Int64(srcBytes.size))
        }
    }

    @OverflowWrapping
    public static func stringIntoByteBuffer(
        s: String,
        offset: Int64,
        length: Int64,
        bytes: Array<Int8>,
        destOffset: Int64,
        _: String
    ): Unit {
        var stringToCopy: String = s[offset..offset + length]
        var srcBytes: Array<UInt8> = stringToCopy.toArray()
        if (srcBytes.size > 0) {
            transUInt8ArrayToInt8(srcBytes).copyTo(bytes, offset, destOffset, Int64(srcBytes.size))
        }
    }

    @OverflowWrapping
    public static func arraycopys(
        srcBytes: Array<Int8>,
        offset: Int64,
        bytes: Array<Int8>,
        destOffset: Int64,
        length: Int64
    ) {
        var flag: Bool = false
        var isOffSet: Bool = false
        var destOffsets = destOffset
        for (index in 0..bytes.size) {
            if (index >= destOffsets && !isOffSet) {
                flag = true
                isOffSet = true
            }
            if (flag) {
                for (i in offset..length + offset) {
                    bytes[destOffsets] = srcBytes[i]
                    destOffsets++
                }
                flag = false
            }
        }
    }

    /**
     * The Function is trimStringRight
     * 
     * @param s of String
     * 
     * @return Type of String
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func trimStringRight(s: String): String {
        var endPosition: Int64 = (s.toRuneArray().size - 1) // 3
        var endChar: Rune
        while (endPosition >= 0) {
            endChar = s.toRuneArray()[endPosition]
            if (UInt32(endChar) > 32) {
                break
            }
            endPosition--
        }
        if (endPosition == s.toRuneArray().size - 1) {
            return s
        } else if (endPosition < 0) {
            return ""
        }
        return s[..endPosition + 1]
    }

    /**
     * The Function is padStringRight
     * 
     * @param s of String
     * @param length of Int64
     * @param padWith of Char
     * 
     * @return Type of String
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func padStringRight(s: String, length: Int64, padWith: Rune): String {
        if (s.toRuneArray().size >= length) {
            return s
        }
        var stringBuffer: StringBuilder = StringBuilder(s)
        while (stringBuffer.toString().toRuneArray().size < length) {
            stringBuffer.append(padWith)
        }
        return stringBuffer.toString()
    }

    /**
     * The Function is checkBit
     * 
     * @param b of Int8
     * @param bitPosition of Int64
     * 
     * @return Type of Bool
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func checkBit(b: Int8, bitPosition: Int64): Bool {
        return ((b & (1 << bitPosition)) != 0)
    }

    /**
     * The Function is setBit
     * 
     * @param b of Int8
     * @param bitPosition of Int64
     * @param value of Bool
     * 
     * @return Type of Int8
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func setBit(b: Int8, bitPosition: Int64, value: Bool): Int8 {
        var newByte: Int8
        if (value) {
            newByte = Int8(b | (0x01 << bitPosition))
        } else {
            newByte = Int8((b & (!(0x01 << bitPosition))))
        }
        return newByte
    }

    /**
     * The Function is shiftByte
     * 
     * @param c of Int8
     * @param places of Int32
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func shiftByte(c: Int8, places: Int32): Int32 {
        var i: Int32 = Int32(c) & 0xff
        if (places < 0) {
            return i << -places
        } else if (places > 0) {
            var j: UInt32 = UInt32(i)
            j = j >> places
            i = Int32(j)
            return i
        }
        return i
    }

    /**
     * The Function is unpackInteger
     * 
     * @param b1 of Int8
     * @param b2 of Int8
     * @param b3 of Int8
     * @param b4 of Int8
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func unpackInteger(b1: Int8, b2: Int8, b3: Int8, b4: Int8): Int32 {
        var value: Int32 = Int32(b4) & 0xff
        value += BufferTools.shiftByte(b3, -8)
        value += BufferTools.shiftByte(b2, -16)
        value += BufferTools.shiftByte(b1, -24)
        return value
    }

    /**
     * The Function is packInteger
     * 
     * @param i of Int32
     * 
     * @return Type of Array<Int8>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func packInteger(i: Int32): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(4, {_ => 0})
        bytes[3] = Int8(i & (0xff))
        bytes[2] = Int8((i >> 8) & 0xff)
        bytes[1] = Int8((i >> 16) & 0xff)
        bytes[0] = Int8((i >> 24) & 0xff)
        return bytes
    }

    /**
     * The Function is unpackSynchsafeInteger
     * 
     * @param b1 of Int8
     * @param b2 of Int8
     * @param b3 of Int8
     * @param b4 of Int8
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func unpackSynchsafeInteger(b1: Int8, b2: Int8, b3: Int8, b4: Int8): Int32 {
        var value: Int32 = Int32(Int8(b4 & 127))
        value += shiftByte(Int8(b3 & 127), -7)
        value += shiftByte(Int8(b2 & 127), -14)
        value += shiftByte(Int8(b1 & 127), -21)
        return value
    }

    /**
     * The Function is packSynchsafeInteger
     * 
     * @param i of Int32
     * 
     * @return Type of Array<Int8>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func packSynchsafeInteger(i: Int32): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(4, {_ => 0})
        packSynchsafeInteger(i, bytes, 0)
        return bytes
    }

    /**
     * The Function is packSynchsafeInteger
     * 
     * @param i of Int32
     * @param bytes of Array<Int8>
     * @param offset of Int32
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func packSynchsafeInteger(i: Int32, bytes: Array<Int8>, offset: Int32): Unit {
        bytes[Int64(offset) + 3] = Int8(i & 127)
        bytes[Int64(offset) + 2] = Int8((i >> 7) & 127)
        bytes[Int64(offset) + 1] = Int8((i >> 14) & 127)
        bytes[Int64(offset) + 0] = Int8((i >> 21) & 127)
    }

    /**
     * The Function is copyBuffer
     * 
     * @param bytes of Array<Byte>
     * @param offset of Int64
     * @param length of Int64
     * 
     * @return Type of Array<Byte>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func copyBuffer(bytes: Array<Byte>, offset: Int64, length: Int64): Array<Byte> {
        var copy: Array<Byte> = Array<Byte>(length, {_ => 0})
        if (length > 0) {
            bytes.copyTo(copy, offset, 0, length)
        }
        return copy
    }
    public static func copyBuffer(bytes: Array<Int8>, offset: Int64, length: Int64): Array<Int8> {
        var copy: Array<Int8> = Array<Int8>(length, {_ => 0})
        if (length > 0) {
            bytes.copyTo(copy, offset, 0, length)
        }
        return copy
    }

    /**
     * The Function is copyIntoByteBuffer
     * 
     * @param bytes of Array<Byte>
     * @param offset of Int64
     * @param length of Int64
     * @param destBuffer of Array<Byte>
     * @param destOffset of Int64
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func copyIntoByteBuffer(
        bytes: Array<Byte>,
        offset: Int64,
        length: Int64,
        destBuffer: Array<Byte>,
        destOffset: Int64
    ): Unit {
        if (length > 0) {
            bytes.copyTo(destBuffer, offset, destOffset, length)
        }
    }

    @OverflowWrapping
    public static func copyIntoByteBuffer(
        bytes: Array<Int8>,
        offset: Int64,
        length: Int64,
        destBuffer: Array<Int8>,
        destOffset: Int64
    ): Unit {
        if (length > 0) {
            bytes.copyTo(destBuffer, offset, destOffset, length)
        }
    }

    /**
     * The Function is sizeUnsynchronisationWouldAdd
     * 
     * @param bytes of Array<Int8>
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func sizeUnsynchronisationWouldAdd(bytes: Array<Int8>): Int32 {
        var count: Int32 = 0
        for (i in (0..bytes.size - 1)) {
            if (bytes[i] == Int8(0xff) && ((bytes[i + 1] & Int8(0xe0)) == Int8(0xe0) || bytes[i + 1] == 0)) {
                count++
            }
        }
        if (bytes.size > 0 && bytes[bytes.size - 1] == Int8(0xff)) {
            count++
        }
        return count
    }

    /**
     * The Function is unsynchroniseBuffer
     * 
     * @param bytes of Array<Int8>
     * 
     * @return Type of Array<Int8>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func unsynchroniseBuffer(bytes: Array<Int8>): Array<Int8> {
        var count: Int32 = sizeUnsynchronisationWouldAdd(bytes)
        if (count == 0) {
            return bytes
        }
        var newBuffer: Array<Int8> = Array<Int8>(bytes.size + Int64(count), {_ => 0})
        var j: Int64 = 0
        for (i in 0..(bytes.size - 1)) {
            newBuffer[j] = bytes[i]
            j++
            if (bytes[i] == Int8(0xff) && ((bytes[i + 1] & Int8(0xe0)) == Int8(0xe0) || bytes[i + 1] == 0)) {
                newBuffer[j] = 0
                j++
            }
        }
        newBuffer[j] = bytes[bytes.size - 1]
        j++
        if (bytes[bytes.size - 1] == Int8(0xff)) {
            newBuffer[j] = 0
            j++
        }
        return newBuffer
    }

    /**
     * The Function is sizeSynchronisationWouldSubtract
     * 
     * @param bytes of Array<Int8>
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func sizeSynchronisationWouldSubtract(bytes: Array<Int8>): Int32 {
        var count: Int32 = 0
        for (i in 0..(bytes.size - 2)) {
            if (bytes[i] == Int8(0xff) && bytes[i + 1] == 0 && ((bytes[i + 2] & Int8(0xe0)) == Int8(0xe0) ||
                bytes[i + 2] == 0)) {
                count++
            }
        }
        if (bytes.size > 1 && bytes[bytes.size - 2] == Int8(0xff) && bytes[bytes.size - 1] == 0) {
            count++
        }
        return count
    }

    /**
     * The Function is synchroniseBuffer
     * 
     * @param bytes of Array<Int8>
     * 
     * @return Type of Array<Int8>
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func synchroniseBuffer(bytes: Array<Int8>): Array<Int8> {
        var count: Int32 = sizeSynchronisationWouldSubtract(bytes)
        if (count == 0) {
            return bytes
        }
        var newBuffer: Array<Int8> = Array<Int8>(bytes.size - Int64(count), {_ => 0})
        var i: Int64 = 0
        for (j in 0..newBuffer.size - 1) {
            newBuffer[j] = bytes[i]
            if (bytes[i] == Int8(0xff) && bytes[i + 1] == 0 && ((bytes[i + 2] & Int8(0xe0)) == Int8(0xe0) ||
                bytes[i + 2] == 0)) {
                i++
            }
            i++
        }
        newBuffer[newBuffer.size - 1] = bytes[i]
        return newBuffer
    }

    /**
     * The Function is substitute, Replace all substrings
     * 
     * @param s of String, Source data
     * @param replaceThis of String, Substring to be replaced
     * @param withThis of Option<String>, Substring after replacement
     * 
     * @return Type of String
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func substitute(s: String, replaceThis: String, withThis: Option<String>): String {
        if (replaceThis.size < 1 || !s.contains(replaceThis)) {
            return s
        }
        var newString: StringBuilder = StringBuilder()
        var lastPosition: Int64 = 0;
        var position: Int64 = 0;
        position = match (s.indexOf(replaceThis, position)) {
            case Some(x) => x
            case None => -1
        }
        while (position >= 0) {
            if (position > lastPosition) {
                var subStr = s[lastPosition..position]
                newString.append(subStr)
            }
            match (withThis) {
                case Some(x) => newString.append(x)
                case None => ()
            }
            lastPosition = position + replaceThis.size
            position++
            position = match (s.indexOf(replaceThis, position)) {
                case Some(x) => x
                case None => -1
            }
        }
        if (lastPosition < s.size) {
            newString.append(s[lastPosition..])
        }
        return newString.toString()
    }

    /**
     * The Function is asciiOnly
     * 
     * @param s of String
     * 
     * @return Type of String
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func asciiOnly(s: String): String {
        var newString: StringBuilder = StringBuilder()
        let charArray = s.toRuneArray()
        for (i in 0..charArray.size) {
            var ch: Rune = charArray[i]
            if (UInt32(ch) < 32 || UInt32(ch) > 126) {
                newString.append('?')
            } else {
                newString.append(ch)
            }
        }
        return newString.toString()
    }

    /**
     * The Function is indexOfTerminator
     * 
     * @param bytes of Array<Int8>
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func indexOfTerminator(bytes: Array<Int8>): Int32 {
        return indexOfTerminator(bytes, 0)
    }

    /**
     * The Function is indexOfTerminator
     * 
     * @param bytes of Array<Int8>
     * @param fromIndex of Int32
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func indexOfTerminator(bytes: Array<Int8>, fromIndex: Int32): Int32 {
        var fromIndexDef: Int32 = fromIndex
        fromIndexDef = 0
        return indexOfTerminator(bytes, fromIndexDef, 1)
    }

    /**
     * The Function is indexOfTerminator
     * 
     * @param bytes of Array<Int8>
     * @param fromIndex of Int32
     * @param terminatorLength of Int32
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func indexOfTerminator(bytes: Array<Int8>, fromIndex: Int32, terminatorLength: Int32): Int32 {
        var marker: Int32 = -1
        for (i in fromIndex..(Int32(bytes.size) - terminatorLength) + 1) {
            if ((i - fromIndex) % terminatorLength == 0) {
                var matched: Int32 = 0
                for (_ in 0..terminatorLength) {
                    if (bytes[Int64(i) + Int64(matched)] != 0) {
                        break
                    }
                    matched++
                }
                if (matched == terminatorLength) {
                    marker = i
                    break
                }
            }
        }
        return marker
    }

    /**
     * The Function is indexOfTerminatorForEncoding
     * 
     * @param bytes of Array<Int8>
     * @param fromIndex of Int32
     * @param encoding of Int32
     * 
     * @return Type of Int32
     * @since 0.31.4
     */
    @OverflowWrapping
    public static func indexOfTerminatorForEncoding(bytes: Array<Int8>, fromIndex: Int32, encoding: Int32): Int32 {
        var terminatorLength: Int32 = 0
        if (encoding == 1 || encoding == 2) {
            terminatorLength = 2
        } else {
            terminatorLength = 1
        }
        return indexOfTerminator(bytes, fromIndex, terminatorLength);
    }

    @OverflowWrapping
    public static func transUInt8ArrayToInt8(bytes: Array<Byte>): Array<Int8> {
        var tarr: Array<Int8> = Array<Int8>(bytes.size, {_ => 0})
        for (i in 0..bytes.size) {
            tarr[i] = Int8(bytes[i])
        }
        return tarr
    }

    @OverflowWrapping
    public static func transInt8ArrayToUInt8(bytes: Array<Int8>): Array<Byte> {
        var tarr: Array<Byte> = Array<Byte>(bytes.size, {_ => 0})
        for (i in 0..bytes.size) {
            tarr[i] = UInt8(bytes[i])
        }
        return tarr
    }
}
