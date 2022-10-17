// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import collection.*

main() {
    var frameData: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false)
    var toString: String = frameData.toString()
    println("${toString}")
    if (toString != "ID3v2ChapterTOCFrameData [isRoot=false, isOrdered=false, id=None, children=None, subframes=[]]") {
        return 1
    }
    var frameData1: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false, true, true, "toc1", ["ch1", "ch2"])
    var toString1: String = frameData1.toString()
    println("${toString1}")
    if (toString1 !=
        "ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(toc1), children=Some([ch1, ch2]), subframes=[]]") {
        return 1
    }
    0
}
