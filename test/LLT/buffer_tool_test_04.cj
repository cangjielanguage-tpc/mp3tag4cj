// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var b: Int8 = -0x36
    var res1: Bool = BufferTools.checkBit(b, 0)
    if (res1 != false) {
        println("res1 ==> ${res1}")
        return 1
    }
    var res2: Bool = BufferTools.checkBit(b, 1)
    if (res2 != true) {
        println("res2 ==> ${res2}")
        return 1
    }
    var res3: Bool = BufferTools.checkBit(b, 2)
    if (res3 != false) {
        println("res3 ==> ${res3}")
        return 1
    }
    var res4: Bool = BufferTools.checkBit(b, 3)
    if (res4 != true) {
        println("res4 ==> ${res4}")
        return 1
    }
    var res5: Bool = BufferTools.checkBit(b, 4)
    if (res5 != false) {
        println("res5 ==> ${res5}")
        return 1
    }
    var res6: Bool = BufferTools.checkBit(b, 5)
    if (res6 != false) {
        println("res6 ==> ${res6}")
        return 1
    }
    var res7: Bool = BufferTools.checkBit(b, 6)
    if (res7 != true) {
        println("res7 ==> ${res7}")
        return 1
    }
    var res8: Bool = BufferTools.checkBit(b, 7)
    if (res8 != true) {
        println("res8 ==> ${res8}")
        return 1
    }
    0
}


