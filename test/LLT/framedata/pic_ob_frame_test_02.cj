// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var expBytes: Array<Int8> = [1, 105, 109, 97, 103, 101, 47, 112, 110, 103, 0, 1, -1, -2, -77, 3, -75, 3, -71, 3,
    -84, 3, 0, 0, 1, 2, 3, 4, 5]
    var bytes: Array<Int8> = transBytes()
    var frameData: ID3v2ObseletePictureFrameData = ID3v2ObseletePictureFrameData(false, bytes)
    var mimeType = frameData.getMimeType()
    var picType = frameData.getPictureType()
    var Des = frameData.getDescription().getOrThrow().toString()
    var imgData = frameData.getImageData()
    println("mimeType ==> ${mimeType}")
    println("picType ==> ${picType}")
    println("Des ==> ${Des}")
    println("imgData ==> ${imgData}")
    println("bytes ==> ${frameData.toBytes()}")
    if (mimeType != "image/png") {
        return 1
    }
    if (picType != 1) {
        return 1
    }

    //希腊语 你好
    if (Des != "γειά") {
        return 1
    }
    if (imgData != [1, 2, 3, 4, 5]) {
        return 1
    }
    if (frameData.toBytes() != expBytes) {
        return 1
    }
    0
}

@overflowWrapping
func transBytes(): Array<Int8> {
    return [
        0x01,
        Int8(UInt32('P')),
        Int8(UInt32('N')),
        Int8(UInt32('G')),
        0x01,
        Int8(0xff),
        Int8(0xfe),
        Int8(0xb3),
        0x03,
        Int8(0xb5),
        0x03,
        Int8(0xb9),
        0x03,
        Int8(0xac),
        0x03,
        0,
        0,
        1,
        2,
        3,
        4,
        5
    ]
}
