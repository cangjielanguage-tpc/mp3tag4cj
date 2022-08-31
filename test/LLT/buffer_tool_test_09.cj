// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

main() {
    var res1: Array<Int8> =  BufferTools.packSynchsafeInteger(1217)
    if (res1[0] != Int8(0) || res1[1] != Int8(0) || res1[2] != Int8(0x09) || res1[3] !=Int8(0x41)) {
        println("res1 ==> ${res1}")
        return 1
    }
    var res2: Array<Int8> =  BufferTools.packSynchsafeInteger(1227)
    if (res2[0] != Int8(0) || res2[1] != Int8(0) || res2[2] != Int8(0x09) || res2[3] !=Int8(0x4B)) {
        println("res2 ==> ${res2}")
        return 1
    }
    var res3: Array<Int8> =  BufferTools.packSynchsafeInteger(1002)
    if (res3[0] != Int8(0) || res3[1] != Int8(0) || res3[2] != Int8(0x07) || res3[3] !=Int8(0x6A)) {
        println("res3 ==> ${res3}")
        return 1
    }
    var res4: Array<Int8> =  BufferTools.packSynchsafeInteger(0x0101)
    if (res4[0] != Int8(0) || res4[1] != Int8(0) || res4[2] != Int8(2) || res4[3] !=Int8(1)) {
        println("res4 ==> ${res4}")
        return 1
    }
    0
}


