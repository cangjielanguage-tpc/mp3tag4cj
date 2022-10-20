// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var testFrame1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("123"))
    var hashCode1 = testFrame1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var testFrame2: ID3v2TextFrameData = ID3v2TextFrameData(false)
    var hashCode2 = testFrame2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var testFrame3: ID3v2TextFrameData = ID3v2TextFrameData(false)
    var hashCode3 = testFrame3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    var testFrame4: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("123"))
    var hashCode4 = testFrame4.hashCode()
    println("hashCode4 ==> ${hashCode4}")
    if (hashCode1 != hashCode4) {
        return 1
    }
    if (hashCode2 != hashCode3) {
        return 1
    }
    if (hashCode1 == hashCode2){
        return 1
    }
    0
}
