// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

main() {
    var b: Int8 = -0x36
    var res1: Int8 = BufferTools.setBit(b, 7, true)
    if (res1 != -0x36) {
        println("res1 ==> ${res1}")
        return 1
    }
    var res2: Int8 = BufferTools.setBit(b, 0, true)
    if (res2 != -0x35) {
        println("res2 ==> ${res2}")
        return 1
    }
    var res3: Int8 = BufferTools.setBit(b, 4, true)
    if (res3 != -0x26) {
        println("res3 ==> ${res3}")
        return 1
    }
    var res4: Int8 = BufferTools.setBit(b, 0, false)
    if (res4 != -0x36) {
        println("res4 ==> ${res4}")
        return 1
    }
    var res5: Int8 = BufferTools.setBit(b, 7, false)
    if (res5 != 0x4A) {
        println("res5 ==> ${res5}")
        return 1
    }
    println("res5 ==> ${res5}")
    var res6: Int8 = BufferTools.setBit(b, 3, false)
    if (res6 != -0x3E) {
        println("res6 ==> ${res6}")
        return 1
    }
    0
}


