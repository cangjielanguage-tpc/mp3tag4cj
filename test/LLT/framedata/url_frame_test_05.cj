// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var frameData: ID3v2UrlFrameData = ID3v2UrlFrameData(false)
    frameData.setUrl("My URL!@#$%^&*( 測試测试")
    var url: String = frameData.getUrl().getOrThrow()
    if(url != "My URL!@#$%^&*( 測試测试") {
        return 1
    }
    var frameData1: ID3v2UrlFrameData = ID3v2UrlFrameData(true)
    frameData1.setUrl("My URL!@#$%^&*( 測試测试")
    var url1: String = frameData1.getUrl().getOrThrow()
    if(url1 != "My URL!@#$%^&*( 測試测试") {
        return 1
    }
    0
}




