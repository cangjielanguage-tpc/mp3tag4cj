// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(false)
    frameData.setLanguage("my language")
    var lang = frameData.getLanguage()
    println("${lang}")
    if (lang != "my language") {
        return 1
    }
    var comment: EncodedText = EncodedText("my comment")
    frameData.setComment(comment)
    var commentStr = frameData.getComment()
    println("${commentStr.getOrThrow().toString()}")
    if (commentStr.getOrThrow().toString() != "my comment") {
        return 1
    }
    var description: EncodedText = EncodedText("my description")
    frameData.setDescription(description)
    var descriptionStr = frameData.getDescription()
    println("${descriptionStr.getOrThrow().toString()}")
    if (descriptionStr.getOrThrow().toString() != "my description") {
        return 1
    }
    0
}
