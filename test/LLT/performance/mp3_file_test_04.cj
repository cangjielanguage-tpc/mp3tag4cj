// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import time.*
from std import fs.*
from std import collection.*

main() {
    //var buffer: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../../../test/LLT/performance/testfile/v24tagswithalbumimage.mp3"))
    var buffer: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../../../test/LLT/performance/testfile/saveqinggewang.mp3"))
    var start: Int64
    var end: Int64
    var times = 1
    var list: ArrayList<Int64> = ArrayList<Int64>()
    for (i in 0..times) {
        println("------${i}------")
        start = Time.now().nanosecond()
        ID3v2TagFactory.createTag(buffer)
        end = Time.now().nanosecond() - start
        list.append(end)
    }
    var res : Int64 = 0
    for (i in list){
        res += i
    }
    println("createTag ==> ${res/times}")
}


