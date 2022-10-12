// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var bytes: Array<Int8> = [Int8(UInt32('A')), Int8(UInt32('d')), Int8(UInt32('d')), Int8(UInt32('r')), Int8(UInt32('e')),
    Int8(UInt32('s')), Int8(UInt32('s')), Int8(0), Int8(0x00)]
    var iD3v2PopmFrameData: ID3v2PopmFrameData = ID3v2PopmFrameData(false, bytes)
    var address: Option<String> = iD3v2PopmFrameData.getAddress()
    if (address != "Address"){
        return 1
    }
    0
}




