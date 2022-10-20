// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var commentFrame1: ID3v2CommentFrameData = ID3v2CommentFrameData(false)
    var hashCode1 = commentFrame1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var commentFrame2: ID3v2CommentFrameData = ID3v2CommentFrameData(false, Option<String>.Some("eng"),
    Option<EncodedText>.Some(EncodedText(0, "DESCRIPTION")), Option<EncodedText>.Some(EncodedText(0, "ABCDEFGHIJKLMNOPQ")))
    var hashCode2 = commentFrame2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var commentFrame3: ID3v2CommentFrameData = ID3v2CommentFrameData(false)
    var hashCode3 = commentFrame3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    var commentFrame4: ID3v2CommentFrameData = ID3v2CommentFrameData(false, Option<String>.Some("eng"),
    Option<EncodedText>.Some(EncodedText(0, "DESCRIPTION")), Option<EncodedText>.Some(EncodedText(0, "ABCDEFGHIJKLMNOPQ")))
    var hashCode4 = commentFrame4.hashCode()
    println("hashCode4 ==> ${hashCode4}")

    if (hashCode1 != hashCode3 || hashCode2 != hashCode4) {
        return 1
    }
    if (hashCode1 == hashCode2 || hashCode3 == hashCode4){
        return 1
    }
    0
}