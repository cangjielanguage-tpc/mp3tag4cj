// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var TEST_LANGUAGE: String = "eng"
    try {
        var frameData: ID3v2CommentFrameData = ID3v2CommentFrameData(
            false,
            Option<String>.Some(TEST_LANGUAGE),
            Option<EncodedText>.Some(EncodedText(EncodedText.TEXT_ENCODING_UTF_16, "description")),
            Option<EncodedText>.Some(EncodedText(EncodedText.TEXT_ENCODING_UTF_8, "comment"))
        )
    } catch (e: Exception) {
        if (e.toString() != "Exception: description and comment must have same text encoding") {
            return 1
        }
    }
    0
}
