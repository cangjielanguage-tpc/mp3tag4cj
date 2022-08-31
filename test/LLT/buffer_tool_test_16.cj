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
    var buffer: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T, 0, BYTE_G, BYTE_A]
    var res = BufferTools.indexOfTerminator(buffer, 0, 1)
    println(res)
    if (res != 4){
        return 1
    }

    var buffer2: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T, 0, BYTE_G, BYTE_A, 0, BYTE_G, BYTE_A]
    var res2 = BufferTools.indexOfTerminator(buffer2, 0, 1)
    println(res2)
    if (res2 != 4){
        return 1
    }

    var buffer3: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T, 0, BYTE_G, BYTE_A, 0, BYTE_G, BYTE_A]
    var res3 = BufferTools.indexOfTerminator(buffer3, 5, 1)
    println(res3)
    if (res3 != 7){
        return 1
    }

    var buffer4: Array<Int8> = [0, BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T]
    var res4 = BufferTools.indexOfTerminator(buffer4)
    println(res4)
    if (res4 != 0){
        return 1
    }

    var buffer5: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T, 0]
    var res5 = BufferTools.indexOfTerminator(buffer5, 0)
    println(res5)
    if (res5 != 4){
        return 1
    }

    var buffer6: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T]
    var res6 = BufferTools.indexOfTerminator(buffer6, 0, 1)
    println(res6)
    if (res6 != -1){
        return 1
    }

    var buffer7: Array<Int8> = [BYTE_T, 0, BYTE_G, BYTE_T, 0, 0, BYTE_G, BYTE_A]
    var res7 = BufferTools.indexOfTerminator(buffer7, 0, 2)
    println(res7)
    if (res7 != 4){
        return 1
    }

    var buffer8: Array<Int8> = [BYTE_T, 0, BYTE_G, BYTE_T, BYTE_T, 0, 0, BYTE_G, BYTE_A]
    var res8 = BufferTools.indexOfTerminator(buffer8, 0, 2)
    println(res8)
    if (res8 != -1){
        return 1
    }

    var buffer9: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T, 0, 0, BYTE_G, BYTE_A, 0, 0, BYTE_G, BYTE_A]
    var res9 = BufferTools.indexOfTerminator(buffer9, 0, 2)
    println(res9)
    if (res9 != 4){
        return 1
    }

    var buffer10: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, 0, 0, BYTE_T, BYTE_G, BYTE_A, 0, 0, BYTE_G, BYTE_A]
    var res10 = BufferTools.indexOfTerminator(buffer10, 0, 2)
    println(res10)
    if (res10 != 8){
        return 1
    }

    var buffer11: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T, 0, 0, BYTE_G, BYTE_A, 0, 0, BYTE_G, BYTE_A]
    var res11 = BufferTools.indexOfTerminator(buffer11, 6, 2)
    println(res11)
    if (res11 != 8){
        return 1
    }

    var buffer12: Array<Int8> = [0, 0, BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T]
    var res12 = BufferTools.indexOfTerminator(buffer12, 0, 2)
    println(res12)
    if (res12 != 0){
        return 1
    }

    var buffer13: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T, 0, 0]
    var res13 = BufferTools.indexOfTerminator(buffer13, 0, 2)
    println(res13)
    if (res13 != 4){
        return 1
    }

    var buffer14: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T]
    var res14 = BufferTools.indexOfTerminator(buffer14, 0, 2)
    println(res14)
    if (res14 != -1){
        return 1
    }

    var buffer15: Array<Int8> = [BYTE_T, BYTE_ESZETT, BYTE_G, BYTE_T]
    var res15 = BufferTools.indexOfTerminatorForEncoding(buffer15, 0, 2)
    println(res15)
    if (res15 != -1){
        return 1
    }
    0
}
