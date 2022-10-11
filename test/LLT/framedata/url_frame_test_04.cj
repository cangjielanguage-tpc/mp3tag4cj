// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var frameData: ID3v2UrlFrameData = ID3v2UrlFrameData(false)
    var description: EncodedText = EncodedText("my description 測試测试")
    frameData.setDescription(description)
    var data = frameData.getDescription().getOrThrow().toString().getOrThrow()
    if(data != "my description 測試测试") {
        return 1
    }
    0
}




