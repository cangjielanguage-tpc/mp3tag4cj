// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var TEST_MIME_TYPE: String = "mime/type"
    var TEST_DESCRIPTION: String = "DESCRIPTION"
    var DUMMY_IMAGE_DATA: Array<Int8> = [1, 2, 3, 4, 5]
    var frameData: ID3v2PictureFrameData = ID3v2PictureFrameData(false, Option<String>.Some(TEST_MIME_TYPE), 3,
    Option<EncodedText>.Some(EncodedText(0, TEST_DESCRIPTION)), Option<Array<Int8>>.Some(DUMMY_IMAGE_DATA))
    var bytes: Array<Int8> = frameData.toBytes()
    var expectedBytes: Array<Int8> = [0, Int8(UInt32('m')), Int8(UInt32('i')), Int8(UInt32('m')), Int8(UInt32('e')), Int8(UInt32('/')),
    Int8(UInt32('t')), Int8(UInt32('y')), Int8(UInt32('p')), Int8(UInt32('e')), 0, 3, Int8(UInt32('D')), Int8(UInt32('E')), Int8(UInt32('S')),
    Int8(UInt32('C')), Int8(UInt32('R')), Int8(UInt32('I')), Int8(UInt32('P')), Int8(UInt32('T')), Int8(UInt32('I')), Int8(UInt32('O')),
    Int8(UInt32('N')), 0, 1, 2, 3, 4, 5]
    if (bytes != expectedBytes) {
        return 1
    }
    0
}
