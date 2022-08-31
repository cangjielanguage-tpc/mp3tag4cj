// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*


main() {
    var bytes1: Array<Byte> =  [84, 65, 71, 84, 73, 84, 76, 69, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 65, 82, 84, 73, 83, 84, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51,
    52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 65, 76, 66, 85, 77, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51,
    52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 50, 48, 48, 49, 67, 79, 77, 77, 69, 78, 84, 49, 50, 51, 52, 53, 54,
    55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 0, 1, 13]

    var res = BufferTools.byteBufferToString(bytes1, 3, 30, "ISO-8859-2")
    println(res)
    if (res != "TITLE1234567890123456789012345"){
        return 1
    }
    var res2 = BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes1, 33, 30).getOrThrow()
    println(res2)
    if (res2 != "ARTIST123456789012345678901234"){
        return 1
    }

    var x: String = "TITLE1234567890123456789012345"
    var bytes2: Array<Byte> = Array<Byte>(128, {i => UInt8(UInt32('0'))})
    BufferTools.stringIntoByteBuffer(x, 0, min(x.size(), 30), bytes2, 3)
    println(bytes2.toString())
    var res3 = BufferTools.byteBufferToString(bytes2, 0, 128)
    println(res3)

    var y: String = "ARTIST123456789012345678901234"
    BufferTools.stringIntoByteBuffer(y, 0, min(y.size(), 30), bytes2, 33)
    println(bytes2.toString())
    var res4 = BufferTools.byteBufferToString(bytes2, 0, 128)
    println(res4)
    if (res4 != "000TITLE1234567890123456789012345ARTIST12345678901234567890123400000000000000000000000000000000000000000000000000000000000000000"){
        return 1
    }
    0
}


