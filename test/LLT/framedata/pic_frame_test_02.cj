// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var TEST_MIME_TYPE: String = "mime/type"
    var TEST_DESCRIPTION_UNICODE: String = "\u{03B3}\u{03B5}\u{03B9}\u{03AC}"
    var DUMMY_IMAGE_DATA: Array<Int8> = [1, 2, 3, 4, 5]
    var frameData: ID3v2PictureFrameData = ID3v2PictureFrameData(
        false,
        Option<String>.Some(TEST_MIME_TYPE),
        3,
        Option<EncodedText>.Some(EncodedText(EncodedText.TEXT_ENCODING_UTF_16, TEST_DESCRIPTION_UNICODE)),
        Option<Array<Int8>>.Some(DUMMY_IMAGE_DATA)
    )
    var bytes: Array<Int8> = frameData.toBytes()
    var expectedBytes: Array<Int8> = [
        Int8(UInt32(0x01)),
        Int8(UInt32('m')),
        Int8(UInt32('i')),
        Int8(UInt32('m')),
        Int8(UInt32('e')),
        Int8(UInt32('/')),
        Int8(UInt32('t')),
        Int8(UInt32('y')),
        Int8(UInt32('p')),
        Int8(UInt32('e')),
        0,
        3,
        -1,
        -2,
        -77,
        3,
        -75,
        3,
        -71,
        3,
        -84,
        3,
        0,
        0,
        1,
        2,
        3,
        4,
        5
    ]
    if (expectedBytes != bytes) {
        return 1
    }
    0
}
