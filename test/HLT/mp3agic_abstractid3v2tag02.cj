// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v1andv23tagswithalbumimage.mp3
// data_file:./qinggewang.mp3
// data_file:./v1tag.mp3
// data_file:./id3v1.jpeg 
// data_file:./16pic_25.png
// data_file:./id3v11.gif  
// data_file:./v23tagwithchapters.mp3 
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import math.*

@Test
public class Mp3agic_AlbumImage {
    @TestCase
    func mp3agic_AlbumImage01(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        @Assert(chapters[0].getId(),"ch1")
        @Assert(chapters[0].getLength().toString(),"36")
        @Assert(chapters[0].getStartOffset().toString(),"-1")
        @Assert(chapters[0].getEndOffset().toString(),"-1")
        @Assert(chapters[0].getStartTime().toString(),"0")
        @Assert(chapters[0].getEndTime().toString(),"5000")
        @Assert(chapters[0].toString(),"ID3v2ChapterFrameData [id=Some(ch1), startTime=0, endTime=5000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 115, 116, 97, 114, 116]]")
        var subframes: ArrayList<ID3v2Frame> = chapters[0].getSubframes().getOrThrow()
        for (y in subframes) {
            @Assert(y.getId(),"TIT2")
            @Assert(y.getLength().toString(),"16")
            @Assert(y.getDataLength().toString(),"6")
            @Assert(y.getData().toString(),"[0, 115, 116, 97, 114, 116]")
        }
        @Assert(chapters[1].getId(),"ch2")
        @Assert(chapters[1].getLength().toString(),"40")
        @Assert(chapters[1].getStartOffset().toString(),"-1")
        @Assert(chapters[1].getEndOffset().toString(),"-1")
        @Assert(chapters[1].getStartTime().toString(),"5000")
        @Assert(chapters[1].getEndTime().toString(),"10000")
        @Assert(chapters[1].toString(),"ID3v2ChapterFrameData [id=Some(ch2), startTime=5000, endTime=10000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]]")
        var subframes1: ArrayList<ID3v2Frame> = chapters[1].getSubframes().getOrThrow()
        for (y in subframes1) {
            @Assert(y.getId(),"TIT2")
            @Assert(y.getLength().toString(),"20")
            @Assert(y.getDataLength().toString(),"10")
            @Assert(y.getData().toString(),"[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]")
        }
        @Assert(chapters[2].getId(),"ch3")
        @Assert(chapters[2].getLength().toString(),"41")
        @Assert(chapters[2].getStartOffset().toString(),"-1")
        @Assert(chapters[2].getEndOffset().toString(),"-1")
        @Assert(chapters[2].getStartTime().toString(),"10000")
        @Assert(chapters[2].getEndTime().toString(),"15000")
        @Assert(chapters[2].toString(),"ID3v2ChapterFrameData [id=Some(ch3), startTime=10000, endTime=15000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]]")
        var subframes2: ArrayList<ID3v2Frame> = chapters[2].getSubframes().getOrThrow()
        for (y in subframes2) {
            @Assert(y.getId(),"TIT2")
            @Assert(y.getLength().toString(),"21")
            @Assert(y.getDataLength().toString(),"11")
            @Assert(y.getData().toString(),"[0, 49, 48, 32, 115, 101, 99, 111, 110, 100, 115]")
        }
    }

    @TestCase
    func mp3agic_AlbumImage02(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
            @Assert(chapters[0].getId(),"ch1")
            @Assert(chapters[0].getLength().toString(),"36")
        } catch (e: Exception) {
            @Assert(e.toString(),"NoneValueException")
        }
    }

    @TestCase
    func mp3agic_AlbumImage03(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
        id3v2ChapterFrameData.setId("ch5")
        id3v2ChapterFrameData.setStartOffset(10)
        id3v2ChapterFrameData.setEndOffset(15)
        id3v2ChapterFrameData.setStartTime(1314)
        id3v2ChapterFrameData.setEndTime(4000)

        //var id3v2Frame: ID3v2Frame = id3v2ChapterFrameData.getSubframes().getOrThrow()[0]
        //id3v2Frame.id = "ABCD"
        //id3v2Frame.setData([48, 49, 50])
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var id3v2ChapterFrameData1: ID3v2ChapterFrameData = chapters[0]
        @Assert(id3v2ChapterFrameData1.getId(),"ch5")
        @Assert(id3v2ChapterFrameData1.getStartOffset().toString(),"10")
        @Assert(id3v2ChapterFrameData1.getEndOffset().toString(),"15")
        @Assert(id3v2ChapterFrameData1.getStartTime().toString(),"1314")
        @Assert(id3v2ChapterFrameData1.getEndTime().toString(),"4000")
    }

    @TestCase
    func mp3agic_AlbumImage04(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
        println(id3v2ChapterFrameData.getId())
        println(id3v2ChapterFrameData.getLength())
        println(id3v2ChapterFrameData.getStartOffset())
        println(id3v2ChapterFrameData.getEndOffset())
        println(id3v2ChapterFrameData.getStartTime())
        println(id3v2ChapterFrameData.getEndTime())
        id3v2ChapterFrameData.setId("仓颉")
        id3v2ChapterFrameData.setStartOffset(10)
        id3v2ChapterFrameData.setEndOffset(15)
        id3v2ChapterFrameData.setStartTime(1314)
        id3v2ChapterFrameData.setEndTime(4000)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var id3v2ChapterFrameData1: ID3v2ChapterFrameData = chapters[0]
        @Assert(id3v2ChapterFrameData1.getId(),"仓颉")
        @Assert(id3v2ChapterFrameData1.getStartOffset().toString(),"10")
        @Assert(id3v2ChapterFrameData1.getEndOffset().toString(),"15")
        @Assert(id3v2ChapterFrameData1.getStartTime().toString(),"1314")
        @Assert(id3v2ChapterFrameData1.getEndTime().toString(),"4000")
    }

    @TestCase
    func mp3agic_AlbumImage05(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
            var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
            println(id3v2ChapterFrameData.getId())
            println(id3v2ChapterFrameData.getLength())
            println(id3v2ChapterFrameData.getStartOffset())
            println(id3v2ChapterFrameData.getEndOffset())
            println(id3v2ChapterFrameData.getStartTime())
            println(id3v2ChapterFrameData.getEndTime())
            id3v2ChapterFrameData.setId("仓颉")
            id3v2ChapterFrameData.setStartOffset(2147483647)
            id3v2ChapterFrameData.setEndOffset(-2147483647)
            id3v2ChapterFrameData.setStartTime(-2147483647)
            id3v2ChapterFrameData.setEndTime(2147483647)
            id3V22Tag.setChapters(chapters)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
            var id3v2ChapterFrameData1: ID3v2ChapterFrameData = chapters[0]
            @Assert(id3v2ChapterFrameData1.getId(),"仓颉")
            @Assert(id3v2ChapterFrameData1.getStartOffset().toString(),"2147483647")
            @Assert(id3v2ChapterFrameData1.getEndOffset().toString(),"-2147483647")
            @Assert(id3v2ChapterFrameData1.getStartTime().toString(),"-2147483647")
            @Assert(id3v2ChapterFrameData1.getEndTime().toString(),"2147483647")
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: Array is negative")
        }
    }

    @TestCase
    func mp3agic_AlbumImage06(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
        println(id3v2ChapterFrameData.getId())
        println(id3v2ChapterFrameData.getLength())
        println(id3v2ChapterFrameData.getStartOffset())
        println(id3v2ChapterFrameData.getEndOffset())
        println(id3v2ChapterFrameData.getStartTime())
        println(id3v2ChapterFrameData.getEndTime())
        id3v2ChapterFrameData.setId("仓颉cangjie$%^")
        id3v2ChapterFrameData.setStartOffset(-2147483647)
        id3v2ChapterFrameData.setEndOffset(2147483647)
        id3v2ChapterFrameData.setStartTime(2147483647)
        id3v2ChapterFrameData.setEndTime(-2147483647)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var id3v2ChapterFrameData1: ID3v2ChapterFrameData = chapters[0]
        @Assert(id3v2ChapterFrameData1.getId(),"仓颉cangjie$%^")
        @Assert(id3v2ChapterFrameData1.getStartOffset().toString(),"-2147483647")
        @Assert(id3v2ChapterFrameData1.getEndOffset().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getStartTime().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getEndTime().toString(),"-2147483647")
    }

    @TestCase
    func mp3agic_AlbumImage07(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
        println(id3v2ChapterFrameData.getId())
        println(id3v2ChapterFrameData.getLength())
        println(id3v2ChapterFrameData.getStartOffset())
        println(id3v2ChapterFrameData.getEndOffset())
        println(id3v2ChapterFrameData.getStartTime())
        println(id3v2ChapterFrameData.getEndTime())
        id3v2ChapterFrameData.setId("")
        id3v2ChapterFrameData.setStartOffset(2147483647)
        id3v2ChapterFrameData.setEndOffset(2147483647)
        id3v2ChapterFrameData.setStartTime(2147483647)
        id3v2ChapterFrameData.setEndTime(-2147483647)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var id3v2ChapterFrameData1: ID3v2ChapterFrameData = chapters[0]
        @Assert(id3v2ChapterFrameData1.getId(),"")
        @Assert(id3v2ChapterFrameData1.getStartOffset().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getEndOffset().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getStartTime().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getEndTime().toString(),"-2147483647")
    }

    @TestCase
    func mp3agic_AlbumImage30(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
        println(id3v2ChapterFrameData.getId())
        println(id3v2ChapterFrameData.getLength())
        println(id3v2ChapterFrameData.getStartOffset())
        println(id3v2ChapterFrameData.getEndOffset())
        println(id3v2ChapterFrameData.getStartTime())
        println(id3v2ChapterFrameData.getEndTime())
        @Assert(id3v2ChapterFrameData.toString(),"ID3v2ChapterFrameData [id=Some(ch1), startTime=0, endTime=5000, startOffset=-1, endOffset=-1, subframes=TIT2[0, 115, 116, 97, 114, 116]]")
        id3v2ChapterFrameData.setId("")
        id3v2ChapterFrameData.setStartOffset(2147483647)
        id3v2ChapterFrameData.setEndOffset(2147483647)
        id3v2ChapterFrameData.setStartTime(2147483647)
        id3v2ChapterFrameData.setEndTime(-2147483647)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var id3v2ChapterFrameData1: ID3v2ChapterFrameData = chapters[0]
        @Assert(id3v2ChapterFrameData1.getId(),"")
        @Assert(id3v2ChapterFrameData1.getStartOffset().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getEndOffset().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getStartTime().toString(),"2147483647")
        @Assert(id3v2ChapterFrameData1.getEndTime().toString(),"-2147483647")
        @Assert(id3v2ChapterFrameData1.toString(),"ID3v2ChapterFrameData [id=Some(), startTime=2147483647, endTime=-2147483647, startOffset=2147483647, endOffset=2147483647, subframes=TIT2[0, 115, 116, 97, 114, 116]]")
    }

    @TestCase
    func mp3agic_AlbumImage08(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("TRCK", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,80, 81]);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TRCK")
        @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
    }

    @TestCase
    func mp3agic_AlbumImage9(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,81]);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT2")
        @Assert(subframessave[0].getData().toString(),"[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]")
    }

    @TestCase
    func mp3agic_AlbumImage10(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT2")
        @Assert(subframessave[0].getData().toString(),"[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]")
    }

    @TestCase
    func mp3agic_AlbumImage11(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("TIT2", []);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT2")
        @Assert(subframessave[0].getData().toString(),"[]")
    }

    @TestCase
    func mp3agic_AlbumImage12(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("TIT3", []);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", []);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[1].getId(),"TIT2")
        @Assert(subframessave[1].getData().toString(),"[]")
    }

    @TestCase
    func mp3agic_AlbumImage13(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("仓颉", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78,79, 80, 81]);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT2")
        @Assert(subframessave[0].getData().toString(),"[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]")
    }

    @TestCase
    func mp3agic_AlbumImage14(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("112345", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78,79, 80, 81]);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"1123")
        @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
    }

    @TestCase
    func mp3agic_AlbumImage15(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("12", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,80, 81]);
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115]);
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters1.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters1.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT2")
        @Assert(subframessave[0].getData().toString(),"[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]")
    }

    @TestCase
    func mp3agic_AlbumImage16(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("Hello there"))
        id3v2Frame.addSubframe("TIT6", subFrameData1)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters1.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters1.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[1].getId(),"TIT6")
        @Assert(subframessave[0].getData().toString(),"[0, 115, 116, 97, 114, 116]")
    }

    @TestCase
    func mp3agic_AlbumImage17(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("Hello there"))
        id3v2Frame.addSubframe("仓颉", subFrameData1)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters1.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters1.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT2")
        @Assert(subframessave[0].getData().toString(),"[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]")
    }

    @TestCase
    func mp3agic_AlbumImage18(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("Hello there"))
        id3v2Frame.addSubframe("", subFrameData1)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters1.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters1.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT2")
        @Assert(subframessave[0].getData().toString(),"[0, 53, 32, 115, 101, 99, 111, 110, 100, 115]")
    }

    @TestCase
    func mp3agic_AlbumImage19(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText(""))
        id3v2Frame.addSubframe("TIT6", subFrameData1)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters1.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters1.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[1].getId(),"TIT6")
        @Assert(subframessave[1].getData().toString(),"[0]")
    }

    @TestCase
    func mp3agic_AlbumImage20(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
        var id3v2Frame: ID3v2ChapterFrameData = chapters[0]
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("仓颉"))
        id3v2Frame.addSubframe("TIT6", subFrameData1)
        id3V22Tag.setChapters(chapters)
        mp3File.save("../../HLT/save_update_v23tagwithchapters1.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_v23tagwithchapters1.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterssave: ArrayList<ID3v2ChapterFrameData> = id3v2TagSave.getChapters().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterssave[0].getSubframes().getOrThrow()
        @Assert(subframessave[1].getId(),"TIT6")
        @Assert(subframessave[1].getData().toString(),"[2, -2, -1, 78, -45, -104, -119]")
    }
}
