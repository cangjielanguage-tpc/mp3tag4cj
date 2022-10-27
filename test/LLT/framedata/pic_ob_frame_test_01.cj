// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var expBytes: Array<Int8> = [0, 105, 109, 97, 103, 101, 47, 112, 110, 103, 0, 1, 68, 69, 83, 67, 82, 73, 80, 84, 73,
    79, 78, 0, 1, 2, 3, 4, 5]
    var bytes: Array<Int8> = [
        0x00,
        Int8(UInt32('P')),
        Int8(UInt32('N')),
        Int8(UInt32('G')),
        0x01,
        Int8(UInt32('D')),
        Int8(UInt32('E')),
        Int8(UInt32('S')),
        Int8(UInt32('C')),
        Int8(UInt32('R')),
        Int8(UInt32('I')),
        Int8(UInt32('P')),
        Int8(UInt32('T')),
        Int8(UInt32('I')),
        Int8(UInt32('O')),
        Int8(UInt32('N')),
        0x00,
        1,
        2,
        3,
        4,
        5
    ]
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
    if (Des != "DESCRIPTION") {
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
