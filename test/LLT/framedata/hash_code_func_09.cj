// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var TEST_MIME_TYPE: String = "mime/type"
    var TEST_DESCRIPTION_UNICODE: String = "\u{03B3}\u{03B5}\u{03B9}\u{03AC}"
    var DUMMY_IMAGE_DATA: Array<Int8> = [1, 2, 3, 4, 5]
    var TEST_DESCRIPTION: String = "DESCRIPTION"
    var frameData1: ID3v2PictureFrameData = ID3v2PictureFrameData(false, Option<String>.Some(TEST_MIME_TYPE), 3,
    Option<EncodedText>.Some(EncodedText(0, TEST_DESCRIPTION)), Option<Array<Int8>>.Some(DUMMY_IMAGE_DATA))
    var hashCode1 = frameData1.hashCode()
    var frameData2: ID3v2PictureFrameData = ID3v2PictureFrameData(false, Option<String>.Some(TEST_MIME_TYPE), 3,
    Option<EncodedText>.Some(EncodedText(EncodedText.TEXT_ENCODING_UTF_16, TEST_DESCRIPTION_UNICODE)),
    Option<Array<Int8>>.Some(DUMMY_IMAGE_DATA))
    var hashCode2 = frameData2.hashCode()
    var frameData3: ID3v2PictureFrameData = ID3v2PictureFrameData(false, Option<String>.Some(TEST_MIME_TYPE), 3,
    Option<EncodedText>.Some(EncodedText(0, TEST_DESCRIPTION)), Option<Array<Int8>>.Some(DUMMY_IMAGE_DATA))
    var hashCode3 = frameData3.hashCode()
    var frameData4: ID3v2PictureFrameData = ID3v2PictureFrameData(false, Option<String>.Some(TEST_MIME_TYPE), 3,
    Option<EncodedText>.Some(EncodedText(EncodedText.TEXT_ENCODING_UTF_16, TEST_DESCRIPTION_UNICODE)),
    Option<Array<Int8>>.Some(DUMMY_IMAGE_DATA))
    var hashCode4 = frameData4.hashCode()
    println("${hashCode1}")
    println("${hashCode2}")
    println("${hashCode3}")
    println("${hashCode4}")
    if (hashCode1 != hashCode3 || hashCode2 != hashCode4) {
        return 1
    }
    if (hashCode1 == hashCode2 || hashCode3 == hashCode4){
        return 1
    }
    0
}