// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var TEST_DESCRIPTION: String = "DESCRIPTION"
    var TEST_URL: String = "http://ABCDEFGHIJKLMNOPQ"
    var urlFrame1: ID3v2UrlFrameData = ID3v2UrlFrameData(false)
    var hashCode1 = urlFrame1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var urlFrame2: ID3v2UrlFrameData = ID3v2UrlFrameData(false, Option<EncodedText>.Some(EncodedText(Int8(0),
    TEST_DESCRIPTION)),Option<String>.Some(TEST_URL))
    var hashCode2 = urlFrame2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var urlFrame3: ID3v2UrlFrameData = ID3v2UrlFrameData(false)
    var hashCode3 = urlFrame3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    var urlFrame4: ID3v2UrlFrameData = ID3v2UrlFrameData(false, Option<EncodedText>.Some(EncodedText(Int8(0),
    TEST_DESCRIPTION)),Option<String>.Some(TEST_URL))
    var hashCode4 = urlFrame4.hashCode()
    println("hashCode4 ==> ${hashCode4}")
    if (hashCode1 != hashCode3 || hashCode2 != hashCode4) {
        return 1
    }
    if (hashCode1 == hashCode2 || hashCode3 == hashCode4){
        return 1
    }
    0
}