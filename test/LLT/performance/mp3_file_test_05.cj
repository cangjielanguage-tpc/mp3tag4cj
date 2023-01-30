// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import time.*
from std import fs.*
from std import collection.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/performance/testfile/v1tag.mp3")
    var id3v2: ID3v24Tag = ID3v24Tag()
    var start: Int64
    var end: Int64
    var list: ArrayList<Int64> = ArrayList<Int64>()
    var times = 1
    for (i in 0..times) {
        start = Time.now().nanosecond()
        mp3File.setId3v2Tag(Option<ID3v2>.Some(id3v2))
        end = Time.now().nanosecond() - start
        list.append(end)
    }
    var res : Int64 = 0
    for (i in list){
        res += i
    }
    println("setId3v2Tag ==> ${res/times}")
}


