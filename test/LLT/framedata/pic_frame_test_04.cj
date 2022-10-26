// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var frameData: ID3v2PictureFrameData = ID3v2PictureFrameData(false)
    frameData.setMimeType(Option<String>.Some("Mime Type 1"))
    var mimeType = frameData.getMimeType()
    println("${mimeType}")
    if (mimeType != "Mime Type 1") {
        return 1
    }
    frameData.setPictureType(4)
    var picType = frameData.getPictureType()
    println("${picType}")
    if (picType != 4) {
        return 1
    }
    var description: EncodedText = EncodedText("my description")
    frameData.setDescription(Option<EncodedText>.Some(description))
    var des = frameData.getDescription().getOrThrow()
    println("${des.toString()}")
    if (des.toString() != "my description") {
        return 1
    }
    frameData.setImageData(Option<Array<Int8>>.Some([1, 2]));
    var imgData = frameData.getImageData()
    println("${imgData}")
    if (imgData != [1, 2]) {
        return 1
    }
    0
}
