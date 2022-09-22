/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Intermediate class of code conversion
 */
package mp3agic

from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import collection.*
from std import random.*

public class EncodedText <: Hashable & Equatable<EncodedText> {
    protected let CODE = Random().nextInt64()
    public static let TEXT_ENCODING_ISO_8859_1: Int8 = 0
    public static let TEXT_ENCODING_UTF_16: Int8 = 1
    public static let TEXT_ENCODING_UTF_16BE: Int8 = 2
    public static let TEXT_ENCODING_UTF_8: Int8 = 3

    public static let CHARSET_ISO_8859_1: String = "iso-8859-1"
    public static let CHARSET_UTF_16: String = "UTF-16LE"
    public static let CHARSET_UTF_16BE: String = "UTF-16BE"
    public static let CHARSET_UTF_8: String = "UTF-8"

    private static let characterSets: Array<String> = [
        CHARSET_ISO_8859_1,
        CHARSET_UTF_16,
        CHARSET_UTF_16BE,
        CHARSET_UTF_8
    ]
    private static let textEncodingFallback: Array<Int8> = [0, 2, 1, 3]
    private static let boms: Array<Array<Int8>> = transBoms()
    private static let terminators: Array<Array<Int8>> = [[0], [0, 0], [0, 0], [0]]
    public var value: Option<Array<Int8>> = Option<Array<Int8>>.None
    private var textEncoding: Int8 = 0

    @overflowWrapping
    private static func transBoms(): Array<Array<Int8>> {
        var bomsTemp: Array<Array<Int8>> = [[], [Int8(0xff), Int8(0xfe)], [Int8(0xfe), Int8(0xff)], []]
        return bomsTemp
    }

    /**
     * The Function is init constructor.
     * 
     * @param textEncoding of Int8, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8
     * @param value of Array<Int8>, Byte data
     * @since 0.32.5
     */
    public init(textEncoding: Int8, value: Array<Int8>) {
        if ((textEncoding == TEXT_ENCODING_UTF_16) && (textEncodingForBytesFromBOM(value) == TEXT_ENCODING_UTF_16BE)) {
            this.textEncoding = TEXT_ENCODING_UTF_16BE
        } else {
            this.textEncoding = textEncoding
        }
        this.value = Option<Array<Int8>>.Some(value)
        this.stripBomAndTerminator();
    }

    /**
     * The Function is init constructor.
     * 
     * @param string of String
     * @since 0.32.5
     */
    public init(string: String) {
        for (textEncodingTmp in textEncodingFallback) {
            this.textEncoding = textEncodingTmp
            value = stringToBytes(string, characterSetForTextEncoding(textEncoding))
            match (value) {
                case Some(x) =>
                    if (this.toString() != Option<String>.None) {
                        this.stripBomAndTerminator()
                        return
                    }
                case None => ()
            }
        }
        throw IllegalArgumentException("Invalid string, could not find appropriate encoding");
    }

    /**
     * The Function is init constructor.
     * 
     * @param string of String
     * @param transcodeToTextEncoding of Int8, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE
     * 3-CHARSET_UTF_8
     * @since 0.32.5
     */
    public init(string: String, transcodeToTextEncoding: Int8) {
        this(string)
        setTextEncoding(transcodeToTextEncoding, true)
    }

    /**
     * The Function is init constructor.
     * 
     * @param textEncoding of Int8, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8
     * @param string of String
     * @since 0.32.5
     */
    public init(textEncoding: Int8, string: String) {
        this.textEncoding = textEncoding
        value = stringToBytes(string, characterSetForTextEncoding(textEncoding))
        this.stripBomAndTerminator()
    }

    public init(value: Array<Int8>) {
        this(textEncodingForBytesFromBOM(value), value)
    }

    @overflowWrapping
    private static func textEncodingForBytesFromBOM(value: Array<Int8>): Int8 {
        if (value.size >= 2 && value[0] == Int8(0xff) && value[1] == Int8(0xfe)) {
            return TEXT_ENCODING_UTF_16
        } else if (value.size >= 2 && value[0] == Int8(0xfe) && value[1] == Int8(0xff)) {
            return TEXT_ENCODING_UTF_16BE
        } else if (value.size >= 3 && (value[0] == Int8(0xef) && value[1] == Int8(0xbb) && value[2] == Int8(0xbf))) {
            return TEXT_ENCODING_UTF_8
        } else {
            return TEXT_ENCODING_ISO_8859_1
        }
    }

    private static func characterSetForTextEncoding(textEncoding: Int8): String {
        try {
            return characterSets[Int64(textEncoding)]
        } catch (e: Exception) {
            throw IllegalArgumentException("Invalid text encoding ${textEncoding}")
        }
    }

    @overflowWrapping
    private func stripBomAndTerminator(): Unit {
        match (this.value) {
            case Some(valueOp) =>
                var leadingCharsToRemove: Int32 = 0
                if (valueOp.size >= 2 && ((valueOp[0] == Int8(0xfe) && valueOp[1] == Int8(0xff)) || (valueOp[0] == Int8(0xff)&&
                    valueOp[1] == Int8(0xfe)))) {
                    leadingCharsToRemove = 2
                } else if (valueOp.size >= 3 && (valueOp[0] == Int8(0xef) && valueOp[1] == Int8(0xbb) && valueOp[2] ==
                    Int8(0xbf))) {
                    leadingCharsToRemove = 3
                }
                var trailingCharsToRemove: Int32 = 0
                var terminator: Array<Int8> = terminators[Int64(textEncoding)]
                if (valueOp.size - Int64(leadingCharsToRemove) >= terminator.size) {
                    var haveTerminator: Bool = true
                    for (i in 0..terminator.size) {
                        if (valueOp[valueOp.size - terminator.size + i] != terminator[i]) {
                            haveTerminator = false
                            break
                        }
                    }
                    if (haveTerminator) {
                        trailingCharsToRemove = Int32(terminator.size)
                    }
                }
                if (leadingCharsToRemove + trailingCharsToRemove > 0) {
                    var newLength: Int32 = Int32(valueOp.size) - leadingCharsToRemove - trailingCharsToRemove
                    var newValue: Array<Int8> = Array<Int8>(Int64(newLength), {i => 0})
                    if (newLength > 0) {
                        BufferTools.arraycopys(valueOp, Int64(leadingCharsToRemove), newValue, 0, newValue.size)
                    }
                    this.value = newValue
                }
            case None => ()
        }
    }

    /**
     * The Function is getTextEncoding, Get the corresponding number of the code set.
     * 
     * @return Type of Int8
     * @since 0.32.5
     */
    public func getTextEncoding(): Int8 {
        return textEncoding
    }

    /**
     * Set encoding and perform encoding conversion on value, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16,
     * 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8.
     * 
     * @param textEncoding of Int8
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setTextEncoding(textEncoding: Int8): Unit {
        setTextEncoding(textEncoding, true)
    }

    /**
     * Set encoding and perform encoding conversion on value, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16,
     * 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8.
     * 
     * @param textEncoding of Int8
     * @param transcode of Bool
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setTextEncoding(textEncoding: Int8, transcode: Bool): Unit {
        var transcodeTmp = transcode
        if (this.value != Option<Array<Int8>>.None) {
            if (this.textEncoding != textEncoding) {
                var charBuffer: String = bytesToCharBuffer(
                    this.value.getOrThrow(),
                    characterSetForTextEncoding(this.textEncoding)
                )
                var transcodedBytes: Array<Int8> = charBufferToBytes(
                    charBuffer,
                    characterSetForTextEncoding(textEncoding)
                )
                this.textEncoding = textEncoding
                this.value = Option<Array<Int8>>.Some(transcodedBytes)
            }
        }
    }

    public func getTerminator(): Array<Int8> {
        return terminators[Int64(textEncoding)]
    }

    /**
     * The Function is toBytes, Get byte data.
     * 
     * @return Type of Array<Int8>
     * @since 0.32.5
     */
    public func toBytes(): Array<Int8> {
        return toBytes(false, false)
    }

    public func toBytes(includeBom: Bool): Array<Int8> {
        return toBytes(includeBom, false)
    }

    @overflowWrapping
    public func toBytes(includeBom: Bool, includeTerminator: Bool): Array<Int8> {
        match (this.value) {
            case Some(valueOp) =>
                characterSetForTextEncoding(textEncoding);

                // ensured textEncoding is valid
                var includeBomNum: Int32
                var includeTerminatorNum: Int32
                if (includeBom) {
                    includeBomNum = Int32(boms[Int64(textEncoding)].size)
                } else {
                    includeBomNum = Int32(0)
                }
                if (includeTerminator) {
                    includeTerminatorNum = Int32(getTerminator().size)
                } else {
                    includeTerminatorNum = Int32(0)
                }
                var newLength: Int32 = Int32(valueOp.size) + includeBomNum + includeTerminatorNum
                if (Int64(newLength) == valueOp.size) {
                    return valueOp
                } else {
                    var bytes: Array<Int8> = Array<Int8>(Int64(newLength), {i => 0})
                    var i: Int32 = 0;
                    if (includeBom) {
                        var bom: Array<Int8> = boms[Int64(textEncoding)]
                        if (bom.size > 0) {
                            BufferTools.arraycopys(
                                boms[Int64(textEncoding)],
                                0,
                                bytes,
                                Int64(i),
                                boms[Int64(textEncoding)].size
                            )
                            i += Int32(boms[Int64(textEncoding)].size)
                        }
                    }
                    if (valueOp.size > 0) {
                        BufferTools.arraycopys(valueOp, 0, bytes, Int64(i), valueOp.size)
                        i += Int32(valueOp.size)
                    }
                    if (includeTerminator) {
                        var terminator: Array<Int8> = getTerminator()
                        if (terminator.size > 0) {
                            BufferTools.arraycopys(terminator, 0, bytes, Int64(i), terminator.size);
                        }
                    }
                    return bytes
                }
            case None => return []
        }
    }

    public func toString(): Option<String> {
        try {
            return bytesToString(this.value.getOrDefault({ => []}), characterSetForTextEncoding(textEncoding))
        } catch (e: Exception) {
            return Option<String>.None
        }
    }

    public func getCharacterSet(): String {
        return characterSetForTextEncoding(textEncoding)
    }

    private static func bytesToString(bytes: Array<Int8>, characterSet: String): String {
        var s: String = bytesToCharBuffer(bytes, characterSet)
        var length: Int64 = match (s.indexOf(Char(0))) {
            case Some(x) => x
            case None => -1
        }
        if (length == -1) {
            return s
        }
        return s.substring(0, length)
    }

    protected static func bytesToCharBuffer(bytes: Array<Int8>, characterSet: String): String {
        var charSet: Charset = match (Charsets.forName(characterSet)) {
            case Some(x) => x
            case None => throw BaseException("Character set not found")
        }
        return charSet.newDecoder().decode(BufferTools.transInt8ArrayToUInt8(bytes))
    }

    private static func stringToBytes(s: String, characterSet: String): Option<Array<Int8>> {
        try {
            return charBufferToBytes(s, characterSet);
        } catch (e: Exception) {
            return Option<Array<Int8>>.None
        }
    }

    protected static func charBufferToBytes(charBuffer: String, characterSet: String): Array<Int8> {
        var charSet: Charset = match (Charsets.forName(characterSet)) {
            case Some(x) => x
            case None => throw BaseException("Character set not found")
        }
        var byteBuffer: Array<UInt8> = charSet.newEncoder().encode(charBuffer)
        if (checkByteBuffer(byteBuffer)) {
            throw BaseException("Character set not found")
        }
        return BufferTools.transUInt8ArrayToInt8(BufferTools.copyBuffer(byteBuffer, 0, byteBuffer.size))
    }

    private static func checkByteBuffer(byteBuffer: Array<UInt8>): Bool {
        var times: Int64 = 0
        for (temp in byteBuffer) {
            if (temp == 26) {
                times++
            }
        }
        if (times > 0) {
            return true
        } else {
            return false
        }
    }

    /**
     * The Function is hashCode
     * 
     * @return Type of Int64
     * @since 0.32.5
     */
    public func hashCode(): Int64 {
        return CODE
    }

    public operator func ==(rhs: EncodedText): Bool {
        return match (rhs as EncodedText) {
            case Some(x) => refEq(this, x)
            case None => false
        }
    }

    public operator func !=(rhs: EncodedText): Bool {
        return match (rhs as EncodedText) {
            case Some(x) => !refEq(this, x)
            case None => false
        }
    }
}
