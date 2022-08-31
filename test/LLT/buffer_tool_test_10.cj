// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

main() {
    var buffer: Array<Byte> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var buffer1: Array<Byte> = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var buffer2: Array<Byte> = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    var buffer3: Array<Byte> = [1, 2, 3, 4, 5, 6, 7, 8]
    var buffer4: Array<Byte> = [4]
    var res1: Array<Byte> = BufferTools.copyBuffer(buffer, 0, buffer.size())
    if (res1 != buffer){
        println(res1.toString())
        return 1
    }
    var res2: Array<Byte> = BufferTools.copyBuffer(buffer, 1, buffer.size() - 1)
    if (res2 != buffer1){
        println(res2.toString())
        return 1
    }
    var res3: Array<Byte> = BufferTools.copyBuffer(buffer, 0, buffer.size() - 1)
    if (res3 != buffer2){
        println(res3.toString())
        return 1
    }
    var res4: Array<Byte> = BufferTools.copyBuffer(buffer, 1, buffer.size() - 2)
    if (res4 != buffer3){
        println(res4.toString())
        return 1
    }
    var res5: Array<Byte> = BufferTools.copyBuffer(buffer, 4, 1)
    if (res5 != buffer4){
        println(res5.toString())
        return 1
    }
    0
}


