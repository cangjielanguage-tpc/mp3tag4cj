// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import collection.*

main() {
    var expectedBytes: Array<Int8> = [116, 111, 99, 49, 0, 3, 2, 99, 104, 49, 0, 99, 104, 50, 0, 84, 73, 84, 50, 0, 0,
    0, 12, 0, 0, 0, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101]
    var frameData1: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false, expectedBytes)
    var isRoot: Bool = frameData1.isRoot()
    var ordered: Bool = frameData1.isOrdered()
    var id: Option<String> = frameData1.getId()
    var children1: Option<Array<String>> = frameData1.getChildren()
    var length: Int32 = frameData1.getLength()
    var s: String = frameData1.toString()
    var subframes: Option<ArrayList<ID3v2Frame>> = frameData1.getSubframes()
    var bytes: Array<Int8> = frameData1.toBytes()
    println("isRoot ==> ${isRoot}")
    println("ordered ==> ${ordered}")
    println("id ==> ${id}")
    println("children1 ==> ${children1}")
    println("length ==> ${length}")
    println("toString ==> ${s}")
    for (subframe in subframes.getOrThrow()) {
        println("getId ==> ${subframe.getId()}")
        println("getData ==> ${subframe.getData()}")
        println("getDataLength ==> ${subframe.getDataLength()}")
        if (subframe.getId() != "TIT2") {
            return 1
        }
        if (subframe.getData() != [0, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101]) {
            return 1
        }
        if (subframe.getDataLength() != 12) {
            return 1
        }
    }
    println("toBytes ==> ${bytes}")
    if (isRoot != true) {
        return 1
    }
    if (ordered != true) {
        return 1
    }
    if (id != "toc1") {
        return 1
    }
    if (children1 != ["ch1", "ch2"]) {
        return 1
    }
    if (length != 37) {
        return 1
    }
    if (s !=
        "ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(toc1), children=Some([ch1, ch2]), subframes=TIT2[0, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101]]") {
        return 1
    }
    if (bytes != [116, 111, 99, 49, 0, 3, 2, 99, 104, 49, 0, 99, 104, 50, 0, 84, 73, 84, 50, 0, 0, 0, 12, 0, 0, 0, 72,
    101, 108, 108, 111, 32, 116, 104, 101, 114, 101]) {
        return 1
    }
    0
}
