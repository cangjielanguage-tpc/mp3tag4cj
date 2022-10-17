// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import collection.*

main() {
    var frameData1: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false, Option<String>.Some("ch1"), 1, 380, 3, 400)
    var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("Hello there"))
    frameData1.addSubframe("TIT2", subFrameData1)

    var startTime: Int32 = frameData1.getStartTime()
    var startOffset: Int32 = frameData1.getStartOffset()
    var endTime: Int32 = frameData1.getEndTime()
    var endOffset: Int32 = frameData1.getEndOffset()
    var id: String = frameData1.getId().getOrThrow()
    var length: Int32 = frameData1.getLength()
    var s: String = frameData1.toString()
    var subframes: Option<ArrayList<ID3v2Frame>> = frameData1.getSubframes()
    var bytes: Array<Int8> = frameData1.toBytes()
    println("startTime ==> ${startTime}")
    println("startOffset ==> ${startOffset}")
    println("endTime ==> ${endTime}")
    println("endOffset ==> ${endOffset}")
    println("id ==> ${id}")
    println("length ==> ${length}")
    println("s ==> ${s}")
    for (subframe in subframes.getOrThrow()) {
        println("subframes id ==> ${subframe.getId()}")
        println("subframes data ==> ${subframe.getData()}")
        println("subframes datalength ==> ${subframe.getDataLength()}")
    }
    println("toBytes ==> ${bytes}")
    if (startTime != 1) {
        return 1
    }
    if (startOffset != 3) {
        return 1
    }
    if (endTime != 380) {
        return 1
    }
    if (endOffset != 400) {
        return 1
    }
    if (id != "ch1") {
        return 1
    }
    if (length != 42) {
        return 1
    }
    if (s !=
        "ID3v2ChapterFrameData [id=Some(ch1), startTime=1, endTime=380, startOffset=3, endOffset=400, subframes=TIT2[0, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101]]") {
        return 1
    }
    if (bytes != [99, 104, 49, 0, 0, 0, 0, 1, 0, 0, 1, 124, 0, 0, 0, 3, 0, 0, 1, -112, 84, 73, 84, 50, 0, 0, 0, 12, 0,
    0, 0, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101]) {
        return 1
    }
    0
}
