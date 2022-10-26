// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var BYTE_FF: Int8 = -0x01
    var BYTE_FB: Int8 = -0x05
    var data: Array<Int8> = [0, 109, 105, 109, 101, 47, 116, 121, 112, 101, 0, 3, 68, 69, 83, 67, 82, 73, 80, 84, 73, 79,
    78, 0, 1, 2, 3, -1, 0, -5, -1, 0, -5, -1, 0, 0, 4, 5]
    var frameData: ID3v2PictureFrameData = ID3v2PictureFrameData(true)
    frameData.initFunc(data)
    var bytes: Array<Int8> = frameData.getImageData().getOrThrow()
    var expBuffer: Array<Int8> = [1, 2, 3, -1, -5, -1, -5, -1, 0, 4, 5]
    if (bytes != expBuffer) {
        return 1
    }
    var bytes2: Array<Int8> = frameData.toBytes()
    if (data != bytes2){
        return 1
    }
    0
}
