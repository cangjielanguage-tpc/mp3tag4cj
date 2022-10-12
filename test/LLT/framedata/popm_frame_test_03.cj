// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var bytes: Array<Int8> = transArray01()
    var iD3v2PopmFrameData: ID3v2PopmFrameData = ID3v2PopmFrameData(false, bytes)
    var rating: Int32 = iD3v2PopmFrameData.getRating()
    println(rating)
    if (rating != 5){
        return 1
    }

    var bytes1: Array<Int8> = transArray02()
    var iD3v2PopmFrameData1: ID3v2PopmFrameData = ID3v2PopmFrameData(false, bytes1)
    var rating1: Int32 = iD3v2PopmFrameData1.getRating()
    println(rating1)
    if (rating1 != -1){
        return 1
    }


    0
}

@overflowWrapping
public func transArray01(): Array<Int8> {
    var expectedBytes = [Int8(UInt32('A')), Int8(UInt32('d')), Int8(UInt32('d')), Int8(UInt32('r')), Int8(UInt32('e')),
                         Int8(UInt32('s')), Int8(UInt32('s')), Int8(0), Int8(0xFF)]
    return expectedBytes
}

@overflowWrapping
public func transArray02(): Array<Int8> {
    var expectedBytes = [Int8(UInt32('A')), Int8(UInt32('d')), Int8(UInt32('d')), Int8(UInt32('r')), Int8(UInt32('e')),
                         Int8(UInt32('s')), Int8(UInt32('s')), Int8(0), Int8(0x33)]
    return expectedBytes
}

