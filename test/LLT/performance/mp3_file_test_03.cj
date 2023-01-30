// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import time.*
from std import fs.*
from std import collection.*

main() {
    var bytes: Array<Int8> = [0x49, 0x44, 0x33, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]
    var start: Int64
    var end: Int64
    var times = 1
    var list: ArrayList<Int64> = ArrayList<Int64>()
    for (i in 0..times) {
        println("------${i}------")
        start = Time.now().nanosecond()
        ID3v23Tag(bytes)
        end = Time.now().nanosecond() - start
        list.append(end)
    }
    var res : Int64 = 0
    for (i in list){
        res += i
    }
    println("ID3v23Tag ==> ${res/times}")
    0
}


func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}
