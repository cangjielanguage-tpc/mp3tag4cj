// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var TEST_DESCRIPTION: String = "DESCRIPTION"
    var TEST_DESCRIPTION_UNICODE: String = "\u{03B3}\u{03B5}\u{03B9}\u{03AC}"
    var TEST_URL: String = "http://ABCDEFGHIJKLMNOPQ"
    var frameData: ID3v2UrlFrameData = ID3v2UrlFrameData(false,
    Option<EncodedText>.Some(EncodedText(EncodedText.TEXT_ENCODING_UTF_16,TEST_DESCRIPTION_UNICODE)),
    Option<String>.Some(TEST_URL))
    var bytes: Array<Int8> = frameData.toBytes()
    var expectedBytes: Array<Int8> = transArray()
    if (bytes != expectedBytes) {
        return 1
    }
    var frameData1: ID3v2UrlFrameData = ID3v2UrlFrameData(true,
    Option<EncodedText>.Some(EncodedText(EncodedText.TEXT_ENCODING_UTF_16, TEST_DESCRIPTION_UNICODE)),
    Option<String>.Some(TEST_URL))
    var bytes1: Array<Int8> = frameData1.toBytes()
    var expectedBytes1: Array<Int8> = [1, -1, 0, -2, -77, 3, -75, 3, -71, 3, -84, 3, 0, 0, 104, 116, 116, 112, 58, 47, 47,
    65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]
    if (bytes1 != expectedBytes1) {
        return 1
    }
    0
}

@overflowWrapping
public func transArray(): Array<Int8> {
    var expectedBytes: Array<Int8> = [1, Int8(UInt32(0xff)), Int8(UInt32(0xfe)), Int8(UInt32(0xb3)), Int8(UInt32(0x03)),
    Int8(UInt32(0xb5)), Int8(UInt32(0x03)), Int8(UInt32(0xb9)), Int8(UInt32(0x03)), Int8(UInt32(0xac)), Int8(UInt32(0x03)),
    Int8(UInt32(0)), Int8(UInt32(0)), Int8(UInt32('h')), Int8(UInt32('t')), Int8(UInt32('t')), Int8(UInt32('p')),
    Int8(UInt32(':')), Int8(UInt32('/')), Int8(UInt32('/')), Int8(UInt32('A')), Int8(UInt32('B')), Int8(UInt32('C')),
    Int8(UInt32('D')), Int8(UInt32('E')), Int8(UInt32('F')), Int8(UInt32('G')), Int8(UInt32('H')), Int8(UInt32('I')),
    Int8(UInt32('J')), Int8(UInt32('K')), Int8(UInt32('L')), Int8(UInt32('M')), Int8(UInt32('N')), Int8(UInt32('O')),
    Int8(UInt32('P')),Int8(UInt32('Q'))]
    return expectedBytes
}



