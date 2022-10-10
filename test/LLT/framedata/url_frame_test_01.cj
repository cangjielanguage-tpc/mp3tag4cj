// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var TEST_DESCRIPTION: String = "DESCRIPTION"
    var TEST_DESCRIPTION_UNICODE: String = "\u{03B3}\u{03B5}\u{03B9}\u{03AC}"
    var TEST_URL: String = "http://ABCDEFGHIJKLMNOPQ"
    var frameData: ID3v2UrlFrameData = ID3v2UrlFrameData(false, Option<EncodedText>.Some(EncodedText(Int8(0), TEST_DESCRIPTION)), Option<String>.Some(TEST_URL))
    var bytes: Array<Int8> = frameData.toBytes()
    var expectedBytes: Array<Int8> = [0, Int8(UInt32('D')), Int8(UInt32('E')), Int8(UInt32('S')), Int8(UInt32('C')),
    Int8(UInt32('R')), Int8(UInt32('I')), Int8(UInt32('P')), Int8(UInt32('T')), Int8(UInt32('I')), Int8(UInt32('O')),
    Int8(UInt32('N')), Int8(UInt32(0)), Int8(UInt32('h')), Int8(UInt32('t')), Int8(UInt32('t')), Int8(UInt32('p')),
    Int8(UInt32(':')), Int8(UInt32('/')), Int8(UInt32('/')), Int8(UInt32('A')), Int8(UInt32('B')), Int8(UInt32('C')),
    Int8(UInt32('D')), Int8(UInt32('E')), Int8(UInt32('F')), Int8(UInt32('G')), Int8(UInt32('H')), Int8(UInt32('I')),
    Int8(UInt32('J')), Int8(UInt32('K')), Int8(UInt32('L')), Int8(UInt32('M')), Int8(UInt32('N')), Int8(UInt32('O')),
    Int8(UInt32('P')), Int8(UInt32('Q'))]
    if (bytes != expectedBytes) {
        return 1
    }
    0
}


