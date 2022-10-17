// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(false, Option<String>.None, Option<EncodedText>.None,
        Option<EncodedText>.None)
    var bytes: Array<Int8> = frameData.toBytes()
    var language: Option<String> = frameData.getLanguage()
    var comment: Option<EncodedText> = frameData.getComment()
    var description: Option<EncodedText> = frameData.getDescription()
    if (bytes != [0, 101, 110, 103, 0]) {
        return 1
    }
    if (language != Option<String>.None) {
        return 1
    }
    if (comment != Option<EncodedText>.None) {
        return 1
    }
    if (description != Option<EncodedText>.None) {
        return 1
    }
    0
}
