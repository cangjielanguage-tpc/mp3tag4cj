// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

let BYTE_T: Int8 = 0x54
let BYTE_A: Int8 = 0x41
let BYTE_G: Int8 = 0x47
let BYTE_DASH: Int8 = 0x2D
let BYTE_FF: Int8 = -0x01
let BYTE_FB: Int8 = -0x05
let BYTE_90: Int8 = -0x70
let BYTE_44: Int8 = 0x44
let BYTE_E0: Int8 = -0x20
let BYTE_F0: Int8 = -0x10
let BYTE_81: Int8 = -0x7F
let BYTE_ESZETT: Int8 = -0x21

main() {
    var buffer: Array<Int8> = [BYTE_FF, BYTE_FF, BYTE_FF, BYTE_FF]
    var expectedBuffer: Array<Int8> = [BYTE_FF, 0, BYTE_FF, 0, BYTE_FF, 0, BYTE_FF, 0]
    var unsynchronised: Array<Int8> = BufferTools.unsynchroniseBuffer(buffer)
    var synchronised: Array<Int8> = BufferTools.synchroniseBuffer(unsynchronised)
    if (expectedBuffer != unsynchronised || buffer != synchronised){
        return 1
    }

    var buffer1: Array<Int8> = [BYTE_FF, BYTE_FB, 2, 3, 4, BYTE_FF, BYTE_E0, 7, 8, 9, 10, 11, 12, 13, BYTE_FF, BYTE_F0]
    var expectedBuffer1: Array<Int8> = [BYTE_FF, 0, BYTE_FB, 2, 3, 4, BYTE_FF, 0, BYTE_E0, 7, 8, 9, 10, 11, 12, 13, BYTE_FF, 0, BYTE_F0]
    var unsynchronised1: Array<Int8> = BufferTools.unsynchroniseBuffer(buffer1)
    var synchronised1: Array<Int8> = BufferTools.synchroniseBuffer(unsynchronised1)
    if (expectedBuffer1 != unsynchronised1 || buffer1 != synchronised1){
        return 1
    }

    var buffer2: Array<Int8> = [BYTE_FF, 0, 2, 3, 4, BYTE_FF, 0, 7, 8, 9, 10, 11, 12, 13, BYTE_FF, 0]
    var expectedBuffer2: Array<Int8> = [BYTE_FF, 0, 0, 2, 3, 4, BYTE_FF, 0, 0, 7, 8, 9, 10, 11, 12, 13, BYTE_FF, 0, 0]
    var unsynchronised2: Array<Int8> = BufferTools.unsynchroniseBuffer(buffer2)
    var synchronised2: Array<Int8> = BufferTools.synchroniseBuffer(unsynchronised2)
    if (expectedBuffer2 != unsynchronised2 || buffer2 != synchronised2){
        return 1
    }

    var buffer3: Array<Int8> = [BYTE_FF]
    var expectedBuffer3: Array<Int8> = [BYTE_FF, 0]
    var unsynchronised3: Array<Int8> = BufferTools.unsynchroniseBuffer(buffer3)
    var synchronised3: Array<Int8> = BufferTools.synchroniseBuffer(unsynchronised3)
    if (expectedBuffer3 != unsynchronised3 || buffer3 != synchronised3){
        return 1
    }

    var buffer4: Array<Int8> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    var unsynchronised4: Array<Int8> = BufferTools.unsynchroniseBuffer(buffer4)
    var synchronised4: Array<Int8> = BufferTools.synchroniseBuffer(unsynchronised4)
    if (unsynchronised4 != buffer4 || buffer4 != synchronised4){
        return 1
    }
    0
}


