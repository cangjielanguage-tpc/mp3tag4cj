// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import collection.*

main() {
    var frameData: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false)
    var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>(2)
    subframes.append(ID3v2Frame("A", [Int8(UInt32('c')), Int8(UInt32('h')), Int8(UInt32('1')), 0]))
    subframes.append(ID3v2Frame("B", [1, 0, 1, 0]))
    frameData.setSubframes(Option<ArrayList<ID3v2Frame>>.Some(subframes))
    var index = 0
    for (subframe in frameData.getSubframes().getOrThrow()) {
        if (index == 0) {
            if (subframe.getId() != "A") {
                return 1
            }
            if (subframe.getData() != [99, 104, 49, 0]) {
                return 1
            }
            if (subframe.getDataLength() != 4) {
                return 1
            }
        }
        if (index == 1) {
            if (subframe.getId() != "B") {
                return 1
            }
            if (subframe.getData() != [1, 0, 1, 0]) {
                return 1
            }
            if (subframe.getDataLength() != 4) {
                return 1
            }
        }
        index++
    }
    0
}
