// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var res1: String = BufferTools.padStringRight("1234", 3, ' ')
    if (res1 != "1234") {
        println("res1 ==>" + res1)
        return 1
    }
    var res2: String = BufferTools.padStringRight("123", 3, ' ')
    if (res2 != "123") {
        println("res2 ==>" + res2)
        return 1
    }
    var res3: String = BufferTools.padStringRight("12", 3, ' ')
    if (res3 != "12 ") {
        println("res3 ==>" + res3)
        return 1
    }
    var res4: String = BufferTools.padStringRight("1", 3, ' ')
    if (res4 != "1  ") {
        println("res4 ==>" + res4)
        return 1
    }
    var res5: String = BufferTools.padStringRight("", 3, ' ')
    if (res5 != "   ") {
        println("res5 ==>" + res5)
        return 1
    }
    var ac: Array<Char> = ['\u{03B3}']
    var acExp: Array<Char> = ['\u{03B3}', ' ', ' ']
    var res6: String = BufferTools.padStringRight(String(ac), 3, ' ')
    if (res6 != String(acExp)) {
        println("res6 ==>" + res6)
        return 1
    }
    if (res6.size() != 3) {
        println("res6 ==> ${res6.size()}")
        return 1
    }
    0
}


