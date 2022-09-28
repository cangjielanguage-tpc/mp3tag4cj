// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*


main() {
    var buf: Array<Int8> = [-1, -30, 19, 0]
    var mpeg = MpegFrame(buf)
    var res = mpeg.getLengthInBytes()
    println(res)
    if (res != 105){
        return 1
    }
    var buf2: Array<Int8> = [-1, -30, -125, -88]
    var mpeg2 = MpegFrame(buf2)
    var res2 = mpeg2.getLengthInBytes()
    println(res2)
    if (res2 != 836){
        return 1
    }
    var buf3: Array<Int8> = [-1, -10, 67, 0]
    var mpeg3 = MpegFrame(buf3)
    var res3 = mpeg3.getLengthInBytes()
    if (res3 != 143){
        return 1
    }
    return 0
}


