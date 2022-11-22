// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import time.*
from std import fs.*
from std import collection.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/performance/testfile/v1tag.mp3")
    var ID3V1 = mp3File.getId3v1Tag().getOrThrow()
    //var mp3File: Mp3File = Mp3File("../../../../test/LLT/performance/testfile/saveqinggewang.mp3")
    //var ID3V2 = mp3File.getId3v2Tag().getOrThrow()

    var start: Int64
    var end: Int64
    var times = 1
    var list: ArrayList<Int64> = ArrayList<Int64>()
    for (i in 0..times) {
        println("------${i}------")
        start = Time.now().unixNano()
        println("start ==> ${Time.now().unixNano()}")
        ID3V1.toBytes()
        //ID3V2.toBytes()
        println("end ==> ${Time.now().unixNano()}")
        end = Time.now().unixNano() - start
        list.append(end)
    }
    var res : Int64 = 0
    for (i in list){
        res += i
    }
    println("toBytes ==> ${res/times}")
    0
}
