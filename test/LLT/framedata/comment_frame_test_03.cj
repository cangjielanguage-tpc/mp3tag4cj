// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var bytess: Array<Int8> = [0, 0, 0, 0, 0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]
    var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(false, bytess)
    var language: Option<String> = frameData.getLanguage()
    if (language != "\u{0}\u{0}\u{0}") {
        return 1
    }
    var comment: Option<EncodedText> = frameData.getComment()
    var commentStr: Option<String> = comment.getOrThrow().toString()
    var commentBytes: Array<Int8> = comment.getOrThrow().toBytes()
    if (commentStr != "ABCDEFGHIJKLMNOPQ") {
        return 1
    }
    if (commentBytes != [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]) {
        return 1
    }
    0
}
