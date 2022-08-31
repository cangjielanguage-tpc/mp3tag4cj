// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

let  BYTE_FF: Int8 = -0x01
let  BYTE_FB: Int8 = -0x05
let  BYTE_90: Int8 = -0x70
let  BYTE_44: Int8 = 0x44
let  BYTE_81: Int8 = -0x7F

main() {
    var res1: Int32 = BufferTools.unpackInteger(BYTE_FF, BYTE_FB, BYTE_90, BYTE_44)
    if (res1 != -290748) {
        println("res1 ==> ${res1}")
        return 1
    }
    var res2: Int32 = BufferTools.unpackInteger(Int8(0), Int8(0), Int8(0), BYTE_81)
    if (res2 != 129) {
        println("res2 ==> ${res2}")
        return 1
    }
    var res3: Int32 = BufferTools.unpackInteger(Int8(0), Int8(0), Int8(1), Int8(1))
    if (res3 != 257) {
        println("res3 ==> ${res3}")
        return 1
    }
    0
}


