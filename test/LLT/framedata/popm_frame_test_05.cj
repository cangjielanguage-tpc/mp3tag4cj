// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var iD3v2PopmFrameData: ID3v2PopmFrameData = ID3v2PopmFrameData(false, 5)
    var expectedBytes: Array<Int8> = transArray01()
    var result: Array<Int8> = iD3v2PopmFrameData.packFrameData()
    if (result.size != 31) {
        return 1
    }
    var i: Int64 = 0
    for (expectedByte in expectedBytes) {
        if (expectedByte != result[i]){
            return 1
        }
        i++
    }
    0
}

@overflowWrapping
public func transArray01(): Array<Int8> {
    var expectedBytes = [Int8(UInt32('W')), Int8(UInt32('i')), Int8(UInt32('n')), Int8(UInt32('d')), Int8(UInt32('o')),
                         Int8(UInt32('w')), Int8(UInt32('s')), Int8(UInt32(' ')), Int8(UInt32('M')), Int8(UInt32('e')),
                         Int8(UInt32('d')), Int8(UInt32('i')), Int8(UInt32('a')), Int8(UInt32(' ')), Int8(UInt32('P')),
                         Int8(UInt32('l')), Int8(UInt32('a')), Int8(UInt32('y')), Int8(UInt32('e')), Int8(UInt32('r')),
                         Int8(UInt32(' ')), Int8(UInt32('9')), Int8(UInt32(' ')), Int8(UInt32('S')), Int8(UInt32('e')),
                         Int8(UInt32('r')), Int8(UInt32('i')), Int8(UInt32('e')), Int8(UInt32('s')), Int8(0),Int8(0xFF)]
    return expectedBytes
}