// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var buffer0: Array<Int8> = [-1, 0, 0, 77, -1, 0, 0, 121, 32, 85, 82, 76]
    var buffer1: Array<Int8> = [-1, 0, 77, -1, 0, 121, 32, 85, 82, 76]
    var frameData: AbstractID3v2FrameData = ID3v2WWWFrameData(true, buffer0)
    var bytes0: Array<Int8> = frameData.packFrameData()
    var bytes1: Array<Int8> = frameData.toBytes()
    if (buffer0 != bytes1) {
        return 1
    }
    if (buffer1 != bytes0) {
        return 1
    }
    var frameData1: AbstractID3v2FrameData = ID3v2WWWFrameData(false, buffer0)
    var bytes3: Array<Int8> = frameData1.packFrameData()
    var bytes4: Array<Int8> = frameData1.toBytes()
    if (bytes3 != bytes4) {
        return 1
    }
    if (bytes4 != buffer0) {
        return 1
    }
    0
}
