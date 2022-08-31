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

main() {
    var res1: Int32 = BufferTools.unpackSynchsafeInteger( Int8(0), Int8(0), Int8(0x09), Int8(0x41))
    if (res1 != 1217) {
        println("res1 ==> ${res1}")
        return 1
    }
    var res2: Int32 = BufferTools.unpackSynchsafeInteger(Int8(0), Int8(0), Int8(0x09), Int8(0x4B))
    if (res2 != 1227) {
        println("res2 ==> ${res2}")
        return 1
    }
    var res3: Int32 = BufferTools.unpackSynchsafeInteger(Int8(0), Int8(0), Int8(0x07), Int8(0x6A))
    if (res3 != 1002) {
        println("res3 ==> ${res3}")
        return 1
    }
    var res4: Int32 = BufferTools.unpackSynchsafeInteger(Int8(0), Int8(0), Int8(2), Int8(1))
    if (res4 != 0x0101) {
        println("res4 ==> ${res4}")
        return 1
    }
    var res5: Int32 = BufferTools.unpackSynchsafeInteger(Int8(8), Int8(4), Int8(2), Int8(1))
    if (res5 != 0x01010101) {
        println("res5 ==> ${res5}")
        return 1
    }
    0
}


