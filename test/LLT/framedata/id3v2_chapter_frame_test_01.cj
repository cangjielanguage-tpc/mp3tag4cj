// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*
from std import collection.*

var expBuffer: Array<Int8>= [73, 68, 51, 3, 0, 0, 0, 0, 2, 119, 67, 72, 65, 80, 0, 0, 0, 33, 0, 0, 99, 104, 53, 0, 0, 0, 5,
34, 0, 0,15, -96, 0, 0, 0, 10, 0, 0, 0, 15, 65, 66, 67, 68, 0, 0, 0, 3, 0, 0, 48, 49, 50, 67, 72, 65, 80, 0, 0, 0, 40, 0, 0, 99,
104, 50, 0, 0, 0, 19, -120, 0, 0, 39, 16, -1, -1, -1, -1, -1, -1, -1, -1, 84, 73, 84, 50, 0, 0, 0, 10, 0, 0, 0, 53, 32,
115, 101, 99, 111, 110, 100, 115, 67, 72, 65, 80, 0, 0, 0, 41, 0, 0, 99, 104, 51, 0, 0, 0, 39, 16, 0, 0, 58, -104, -1,
-1, -1, -1, -1, -1, -1, -1, 84, 73, 84, 50, 0, 0, 0, 11, 0, 0, 0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115, 67, 84,
79, 67, 0, 0, 0, 19, 0, 0, 116, 111, 99, 49, 0, 3, 3, 99, 104, 49, 0, 99, 104, 50, 0, 99, 104, 51, 0, 84, 67, 79, 78, 0,
0, 0, 8, 0, 0, 0, 80, 111, 100, 99, 97, 115, 116, 84, 69, 78, 67, 0, 0, 0, 27, 0, 0, 1, -1, -2, 97, 0, 117, 0, 112, 0,
104, 0, 111, 0, 110, 0, 105, 0, 99, 0, 46, 0, 99, 0, 111, 0, 109, 0, 84, 73, 84, 50, 0, 0, 0, 43, 0, 0, 1, -1, -2, 73,
0, 68, 0, 51, 0, 32, 0, 99, 0, 104, 0, 97, 0, 112, 0, 116, 0, 101, 0, 114, 0, 115, 0, 32, 0, 101, 0, 120, 0, 97, 0, 109,
0, 112, 0, 108, 0, 101, 0, 84, 88, 88, 88, 0, 0, 0, 69, 0, 0, 1, -1, -2, 84, 0, 97, 0, 103, 0, 103, 0, 105, 0, 110, 0,
103, 0, 32, 0, 116, 0, 105, 0, 109, 0, 101, 0, 0, 0, -1, -2, 50, 0, 48, 0, 49, 0, 50, 0, 45, 0, 49, 0, 49, 0, 45, 0, 49,
0, 54, 0, 84, 0, 49, 0, 50, 0, 58, 0, 48, 0, 53, 0, 58, 0, 50, 0, 55, 0, 84, 89, 69, 82, 0, 0, 0, 5, 0, 0, 0, 50, 48, 49, 50]

var exp1: String = 
    "chapters getId ==> Some(ch1)chapters getLength ==> 36chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 0chapters getEndTime ==> 5000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch1), startTime=0, endTime=5000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 115, 116, 97, 114, 116]]subframes getId ==> TIT2subframes getLength ==> 16subframes getDataLength ==> 6subframes getData ==> [0, 115, 116, 97, 114, 116]chapters getId ==> Some(ch2)chapters getLength ==> 40chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 5000chapters getEndTime ==> 10000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch2), startTime=5000, endTime=10000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 20subframes getDataLength ==> 10subframes getData ==> [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]chapters getId ==> Some(ch3)chapters getLength ==> 41chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 10000chapters getEndTime ==> 15000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch3), startTime=10000, endTime=15000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 21subframes getDataLength ==> 11subframes getData ==> [0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]"
var exp2: String = 
    "chapters getId ==> Some(ch5)chapters getLength ==> 33chapters getStartOffset ==> 10chapters getEndOffset ==> 15chapters getStartTime ==> 1314chapters getEndTime ==> 4000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch5), startTime=1314, endTime=4000, startOffset=10, endOffset=15, subframes=ABCD[48, 49, 50]]subframes getId ==> ABCDsubframes getLength ==> 13subframes getDataLength ==> 3subframes getData ==> [48, 49, 50]chapters getId ==> Some(ch2)chapters getLength ==> 40chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 5000chapters getEndTime ==> 10000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch2), startTime=5000, endTime=10000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 20subframes getDataLength ==> 10subframes getData ==> [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]chapters getId ==> Some(ch3)chapters getLength ==> 41chapters getStartOffset ==> -1chapters getEndOffset ==> -1chapters getStartTime ==> 10000chapters getEndTime ==> 15000chapters toString ==> ID3v2ChapterFrameData [id=Some(ch3), startTime=10000, endTime=15000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]]subframes getId ==> TIT2subframes getLength ==> 21subframes getDataLength ==> 11subframes getData ==> [0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]"

main() {
    var expimgData = loadFile("../../../../test/LLT/framedata/testfiles/image.png")
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/v23tagwithchapters.mp3")
    var id3v2Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
    var chapters: ArrayList<ID3v2ChapterFrameData> = id3v2Tag.getChapters().getOrThrow()
    var res1 = showChapters(chapters)
    if (res1 != exp1) {
        return 1
    }
    var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
    id3v2ChapterFrameData.setId("ch5")
    id3v2ChapterFrameData.setStartOffset(10)
    id3v2ChapterFrameData.setEndOffset(15)
    id3v2ChapterFrameData.setStartTime(1314)
    id3v2ChapterFrameData.setEndTime(4000)
    var id3v2Frame: ID3v2Frame = id3v2ChapterFrameData.getSubframes().getOrThrow()[0]
    id3v2Frame.id = "ABCD"
    id3v2Frame.setData([48, 49, 50])
    id3v2Tag.setChapters(chapters)
    mp3File.save("../../../../test/LLT/framedata/testfiles/save_update_ch1_v23tagwithchapters.mp3")
    var mp3Save = Mp3File("../../../../test/LLT/framedata/testfiles/save_update_ch1_v23tagwithchapters.mp3")
    var id3v2TagSave: ID3v2 = mp3Save.getId3v2Tag().getOrThrow()
    var chaptersSave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
    var res2 = showChapters(chaptersSave)
    if (res2 != exp2) {
        return 1
    }
    if (id3v2TagSave.toBytes() != expBuffer) {
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

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}
