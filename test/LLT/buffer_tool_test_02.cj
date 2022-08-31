// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var res1: String = BufferTools.trimStringRight("")
    if (res1 != "") {
        println("res1 ==>" + res1)
        return 1
    }
    var res2: String = BufferTools.trimStringRight(" ")
    if (res2 != "") {
        println("res2 ==>" + res2)
        return 1
    }
    var res3: String = BufferTools.trimStringRight("TEST")
    if (res3 != "TEST") {
        println("res3 ==>" + res3)
        return 1
    }
    var res4: String = BufferTools.trimStringRight("TEST   ")
    if (res4 != "TEST") {
        println("res4 ==>" + res4)
        return 1
    }
    var res5: String = BufferTools.trimStringRight("   TEST")
    if (res5 != "   TEST") {
        println("res5 ==>" + res5)
        return 1
    }
    var res6: String = BufferTools.trimStringRight("   TEST   ")
    if (res6 != "   TEST") {
        println("res6 ==>" + res6)
        return 1
    }
    var res7: String = BufferTools.trimStringRight("TEST\t\r\n")
    if (res7 != "TEST") {
        println("res7 ==>" + res7)
        return 1
    }
    var ac: Array<Char> = [' ', '\u{03B3}', ' ', ' ']
    var acExp: Array<Char> = [' ', '\u{03B3}']
    var res8: String = BufferTools.trimStringRight(String(ac))
    if (res8 != String(acExp)) {
        println("res8 ==>" + res8)
        return 1
    }
    0
}


