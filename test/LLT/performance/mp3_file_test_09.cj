// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import time.*
from std import fs.*
from std import collection.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/performance/testfile/v1tag.mp3")
    var start: Int64
    var end: Int64
    var times = 1
    var list: ArrayList<Int64> = ArrayList<Int64>()
    for (i in 0..times) {
        start = Time.now().unixNano()
        mp3File.save("title1v1tag.mp3")
        end = Time.now().unixNano() - start
        list.append(end)
    }
    var res : Int64 = 0
    for (i in list){
        res += i
    }
    println("save ==> ${res/times}")
}


