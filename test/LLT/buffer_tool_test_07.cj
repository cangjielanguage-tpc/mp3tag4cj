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
    //0xFFFB9044 Int32 -290748
    var res1: Array<Int8> =  BufferTools.packInteger(-290748)
    if (res1[0] != BYTE_FF) {
        println("res1 ==> ${res1}")
        return 1
    }
    if (res1[1] != BYTE_FB) {
        println("res1 ==> ${res1}")
        return 1
    }
    if (res1[2] != BYTE_90) {
        println("res1 ==> ${res1}")
        return 1
    }
    if (res1[3] != BYTE_44) {
        println("res1 ==> ${res1}")
        return 1
    }
    println("res1 ==> ${res1}")
    0
}


