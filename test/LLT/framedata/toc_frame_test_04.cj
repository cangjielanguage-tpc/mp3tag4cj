// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import collection.*

main() {
    var frameData: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false)
    frameData.setRoot(true)
    var root = frameData.isRoot()
    if (root != true) {
        return 1
    }

    frameData.setOrdered(true)
    var Ordered = frameData.isOrdered()
    if (Ordered != true) {
        return 1
    }

    frameData.setId("My ID")
    var id = frameData.getId()
    if (id != "My ID") {
        return 1
    }

    frameData.setChildren(["ch1", "ch2"])
    var children = frameData.getChildren()
    if (children != ["ch1", "ch2"]) {
        return 1
    }
    var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>(2)
    subframes.append(ID3v2Frame("", [99, 104, 49, 0]))
    subframes.append(ID3v2Frame("C", [1, 0, 1, 0]))
    frameData.setSubframes(subframes)
    var index = 0
    for (subframe in frameData.getSubframes().getOrThrow()) {
        if (index == 0) {
            if (subframe.getId() != "") {
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
            if (subframe.getId() != "C") {
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
