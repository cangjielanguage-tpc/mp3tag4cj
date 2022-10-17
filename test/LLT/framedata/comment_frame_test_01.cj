// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var TEST_LANGUAGE: String = "eng"
    var TEST_DESCRIPTION: String = "DESCRIPTION"
    var TEST_VALUE: String = "ABCDEFGHIJKLMNOPQ"
    var TEST_DESCRIPTION_UNICODE: String = "\u{03B3}\u{03B5}\u{03B9}\u{03AC}"
    var TEST_VALUE_UNICODE: String = "\u{03C3}\u{03BF}\u{03C5}"
    var expectedBytes: Array<Int8> = [0, 101, 110, 103, 68, 69, 83, 67, 82, 73, 80, 84, 73, 79, 78, 0, 65, 66, 67, 68,
    69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]
    var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(false, Option<String>.Some(TEST_LANGUAGE),
        Option<EncodedText>.Some(EncodedText(0, TEST_DESCRIPTION)), Option<EncodedText>.Some(EncodedText(0, TEST_VALUE)))
    var bytes: Array<Int8> = frameData.toBytes()
    var language: Option<String> = frameData.getLanguage()
    var comment: Option<EncodedText> = frameData.getComment()
    var description: Option<EncodedText> = frameData.getDescription()
    var commentStr: Option<String> = comment.getOrThrow().toString()
    var commentBytes: Array<Int8> = comment.getOrThrow().toBytes()
    var descriptionStr: Option<String> = description.getOrThrow().toString()
    var descriptionbytes: Array<Int8> = description.getOrThrow().toBytes()
    println("bytes ==> ${bytes}")
    println("language ==> ${language}")
    println("commentStr ==> ${commentStr}")
    println("commentBytes ==> ${commentBytes}")
    println("descriptionStr ==> ${descriptionStr}")
    println("descriptionbytes ==> ${descriptionbytes}")
    if (bytes != expectedBytes) {
        return 1
    }
    if (language != "eng") {
        return 1
    }
    if (commentStr != "ABCDEFGHIJKLMNOPQ") {
        return 1
    }
    if (commentBytes != [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]) {
        return 1
    }
    if (descriptionStr != "DESCRIPTION") {
        return 1
    }
    if (descriptionbytes != [68, 69, 83, 67, 82, 73, 80, 84, 73, 79, 78]) {
        return 1
    }
    0
}
