// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

main() {
    var buffer: Array<Byte> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var buffer1: Array<Byte> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var buffer2: Array<Byte> = [0, 1, 2, 3, 4]
    var buffer3: Array<Byte> = [0, 0, 2, 3, 4]
    var desBuffer: Array<Byte> = Array<Byte>(buffer.size, {i=>0})
    BufferTools.copyIntoByteBuffer(buffer, 0, buffer.size, desBuffer, 0)
    if (desBuffer != buffer1){
        return 1
    }
    var desBuffer1: Array<Byte> = Array<Byte>(5, {i=>0})
    BufferTools.copyIntoByteBuffer(buffer, 0, 5, desBuffer1, 0)
    if (desBuffer1 != buffer2){
        return 1
    }
    var desBuffer3: Array<Byte> = Array<Byte>(5, {i=>0})
    BufferTools.copyIntoByteBuffer(buffer, 2, 3, desBuffer3, 2)
    if (desBuffer3 != buffer3){
        return 1
    }
    0
}


