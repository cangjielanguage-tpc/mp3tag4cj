// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import collection.*

main() {
    var frameData: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false)
    frameData.setId("My ID 中文 鍾文");
    var id: Option<String> = frameData.getId()
    println("id ==> ${id}")
    if (id != "My ID 中文 鍾文") {
        return 1
    }
    frameData.setStartTime(9)
    var startTime: Int32 = frameData.getStartTime()
    println("startTime ==> ${startTime}")
    if (startTime != 9) {
        return 1
    }
    frameData.setEndTime(9)
    var endTime: Int32 = frameData.getEndTime()
    println("${endTime}")
    if (endTime != 9) {
        return 1
    }
    frameData.setStartOffset(9)
    var StartOffset: Int32 = frameData.getStartOffset()
    println("${StartOffset}")
    if (StartOffset != 9) {
        return 1
    }
    frameData.setEndOffset(9)
    var endOffset: Int32 = frameData.getEndOffset()
    println("${endOffset}")
    if (endOffset != 9) {
        return 1
    }
    0
}
