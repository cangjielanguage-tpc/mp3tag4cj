// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import collection.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/bugfix/testfiles/v23tagwithchapters.mp3")
    var id3v2Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
    var chapters: ArrayList<ID3v2ChapterFrameData> = id3v2Tag.getChapters().getOrThrow()
    var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]

    var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>()
    var id3v2Frame1: ID3v2Frame = ID3v2Frame("仓颉", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81])
    var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT4", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
    subframes.append(id3v2Frame1)
    subframes.append(id3v2Frame2)

    id3v2ChapterFrameData.setSubframes(subframes)
    id3v2Tag.setChapters(chapters)
    mp3File.save("../../../../test/LLT/bugfix/testfiles/update_one_v23tagwithchapters.mp3")
    var mp3FileSave: Mp3File = Mp3File("../../../../test/LLT/bugfix/testfiles/update_one_v23tagwithchapters.mp3")
    var id3v2Tag1: ID3v2 = mp3FileSave.getId3v2Tag().getOrThrow()
    var chapters1: ArrayList<ID3v2ChapterFrameData> = id3v2Tag1.getChapters().getOrThrow()
    var except1 = "chapters getId ==> Some(ch1)chapters getLength ==> 68chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 0chapters getEndTime ==> 5000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch1), startTime=0, endTime=5000, startOffset=-1, endOffset=-1, subframes=仓颉[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]TIT4[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> 仓颉subframes getLength ==> 28subframes getDataLength ==> 18subframes getData ==> [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]subframes getId ==> TIT4subframes getLength ==> 20subframes getDataLength ==> 10subframes getData ==> [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]chapters getId ==> Some(ch2)chapters getLength ==> 40chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 5000chapters getEndTime ==> 10000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch2), startTime=5000, endTime=10000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 20subframes getDataLength ==> 10subframes getData ==> [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]chapters getId ==> Some(ch3)chapters getLength ==> 41chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 10000chapters getEndTime ==> 15000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch3), startTime=10000, endTime=15000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 21subframes getDataLength ==> 11subframes getData ==> [0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]"
    var except2 = "chapters getId ==> Some(ch2)chapters getLength ==> 40chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 5000chapters getEndTime ==> 10000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch2), startTime=5000, endTime=10000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 20subframes getDataLength ==> 10subframes getData ==> [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]chapters getId ==> Some(ch3)chapters getLength ==> 41chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 10000chapters getEndTime ==> 15000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch3), startTime=10000, endTime=15000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 21subframes getDataLength ==> 11subframes getData ==> [0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]"
    if (showChapters(chapters) != except1) {
        return 1
    }
    if (showChapters(chapters1) != except2) {
        return 1
    }
    0
}

func showChapters(chapters: ArrayList<ID3v2ChapterFrameData>): String {
    var sb: StringBuilder = StringBuilder()
    for (x in chapters) {
        sb.append("chapters getId ==> ${x.getId()}")
        sb.append("chapters getLength ==> ${x.getLength()}")
        sb.append("chapters getStartOffset ==> ${x.getStartOffset()}")
        sb.append("chapters getEndOffset ==> ${x.getEndOffset()}")
        sb.append("chapters getStartTime ==> ${x.getStartTime()}")
        sb.append("chapters getEndTime ==> ${x.getEndTime()}")
        sb.append("chapters toString ==> ${x.toString()}")
        var subframes: ArrayList<ID3v2Frame> = x.getSubframes().getOrThrow()
        for (y in subframes) {
            sb.append("subframes getId ==> ${y.getId()}")
            sb.append("subframes getLength ==> ${y.getLength()}")
            sb.append("subframes getDataLength ==> ${y.getDataLength()}")
            sb.append("subframes getData ==> ${y.getData()}")
        }
    }
    return sb.toString()
}