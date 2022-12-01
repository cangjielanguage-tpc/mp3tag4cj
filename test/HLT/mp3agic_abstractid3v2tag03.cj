// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
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
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        @Assert(chapterTOC[0].isRoot(),true)
        @Assert(chapterTOC[0].getId(),"toc1")
        @Assert(chapterTOC[0].getChildren().toString(),"Some([ch1, ch2, ch3])")
        @Assert(chapterTOC[0].isOrdered(),true)
        @Assert(chapterTOC[0].getLength(),19)
        @Assert(chapterTOC[0].toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(toc1), children=Some([ch1, ch2, ch3]), subframes=[]]")

    }

    @TestCase
    func mp3agic_AlbumImage02(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            @Assert(chapterTOC[0].isRoot(),true)
            @Assert(chapterTOC[0].getId(),"toc1")
            @Assert(chapterTOC[0].getChildren().toString(),"Some([ch1, ch2, ch3])")
            @Assert(chapterTOC[0].isOrdered(),true)
            @Assert(chapterTOC[0].getLength(),19)
            @Assert(chapterTOC[0].toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(toc1), children=Some([ch1, ch2, ch3]), subframes=[]]")
        } catch (e: Exception) {
            @Assert(e.toString(),"NoneValueException")
        }
    }

    @TestCase
    func mp3agic_AlbumImage03(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7"])
        chapterTOC[0].setRoot(false)
        chapterTOC[0].setOrdered(false)
        chapterTOC[0].setId("toc2")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),false)
        @Assert(chapterTOCsave[0].isOrdered(),false)
        @Assert(chapterTOCsave[0].getId(),"toc2")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7])")
        @Assert(chapterTOCsave[0].getLength().toString(),"19")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=false, isOrdered=false, id=Some(toc2), children=Some([ch5, ch6, ch7]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage04(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(false)
        chapterTOC[0].setOrdered(false)
        chapterTOC[0].setId("toc2")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),false)
        @Assert(chapterTOCsave[0].isOrdered(),false)
        @Assert(chapterTOCsave[0].getId(),"toc2")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"43")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=false, isOrdered=false, id=Some(toc2), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage05(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(false)
        chapterTOC[0].setOrdered(false)
        chapterTOC[0].setId("12346456789421131")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),false)
        @Assert(chapterTOCsave[0].isOrdered(),false)
        @Assert(chapterTOCsave[0].getId(),"12346456789421131")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"56")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=false, isOrdered=false, id=Some(12346456789421131), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage06(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(false)
        chapterTOC[0].setOrdered(false)
        chapterTOC[0].setId("12346456789421131")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),false)
        @Assert(chapterTOCsave[0].isOrdered(),false)
        @Assert(chapterTOCsave[0].getId(),"12346456789421131")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"56")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=false, isOrdered=false, id=Some(12346456789421131), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage07(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(true)
        chapterTOC[0].setOrdered(true)
        chapterTOC[0].setId("12346456789421131")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),true)
        @Assert(chapterTOCsave[0].isOrdered(),true)
        @Assert(chapterTOCsave[0].getId(),"12346456789421131")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"56")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(12346456789421131), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage08(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(true)
        chapterTOC[0].setOrdered(true)
        chapterTOC[0].setId("cangjie123%^&")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),true)
        @Assert(chapterTOCsave[0].isOrdered(),true)
        @Assert(chapterTOCsave[0].getId(),"cangjie123%^&")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"52")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(cangjie123%^&), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage09(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(true)
        chapterTOC[0].setOrdered(true)
        chapterTOC[0].setId("")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),true)
        @Assert(chapterTOCsave[0].isOrdered(),true)
        @Assert(chapterTOCsave[0].getId(),"")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"39")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage10(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(true)
        chapterTOC[0].setOrdered(true)
        chapterTOC[0].setId("12.25")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),true)
        @Assert(chapterTOCsave[0].isOrdered(),true)
        @Assert(chapterTOCsave[0].getId(),"12.25")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"44")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(12.25), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage11(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch6", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(true)
        chapterTOC[0].setOrdered(true)
        chapterTOC[0].setId("12.25qwe")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),true)
        @Assert(chapterTOCsave[0].isOrdered(),true)
        @Assert(chapterTOCsave[0].getId(),"12.25qwe")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"47")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(12.25qwe), children=Some([ch5, ch6, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage12(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "123456", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
        chapterTOC[0].setRoot(true)
        chapterTOC[0].setOrdered(true)
        chapterTOC[0].setId("12.25qwe")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),true)
        @Assert(chapterTOCsave[0].isOrdered(),true)
        @Assert(chapterTOCsave[0].getId(),"12.25qwe")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, 123456, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
        @Assert(chapterTOCsave[0].getLength().toString(),"50")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(12.25qwe), children=Some([ch5, 123456, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage13(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            println(chapterTOC[0].isRoot())
            println(chapterTOC[0].getId())
            println(chapterTOC[0].getChildren().toString())
            println(chapterTOC[0].isOrdered())
            println(chapterTOC[0].getLength())
            println(chapterTOC[0].toString())
            var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "*%……", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
            chapterTOC[0].setRoot(true)
            chapterTOC[0].setOrdered(true)
            chapterTOC[0].setId("12.25qwe")
            chapterTOC[0].setChildren(Childrensave)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            @Assert(chapterTOCsave[0].isRoot(),true)
            @Assert(chapterTOCsave[0].isOrdered(),true)
            @Assert(chapterTOCsave[0].getId(),"12.25qwe")
            @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, 123456, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
            @Assert(chapterTOCsave[0].getLength().toString(),"50")
            @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(12.25qwe), children=Some([ch5, 123456, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception")
        }
    }

    @TestCase
    func mp3agic_AlbumImage14(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            println(chapterTOC[0].isRoot())
            println(chapterTOC[0].getId())
            println(chapterTOC[0].getChildren().toString())
            println(chapterTOC[0].isOrdered())
            println(chapterTOC[0].getLength())
            println(chapterTOC[0].toString())
            var Childrensave: Option<Array<String>> = Option<Array<String>>.Some(["ch5", "ch7", "ch8", "ch9", "ch1", "ch2", "ch3", "ch4"])
            chapterTOC[0].setRoot(true)
            chapterTOC[0].setOrdered(true)
            chapterTOC[0].setId("仓颉")
            chapterTOC[0].setChildren(Childrensave)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            @Assert(chapterTOCsave[0].isRoot(),true)
            @Assert(chapterTOCsave[0].isOrdered(),true)
            @Assert(chapterTOCsave[0].getId(),"12.25qwe")
            @Assert(chapterTOCsave[0].getChildren().toString(),"Some([ch5, 123456, ch7, ch8, ch9, ch1, ch2, ch3, ch4])")
            @Assert(chapterTOCsave[0].getLength().toString(),"50")
            @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(12.25qwe), children=Some([ch5, 123456, ch7, ch8, ch9, ch1, ch2, ch3, ch4]), subframes=[]]")
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception")
        }
    }

    @TestCase
    func mp3agic_AlbumImage15(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        println(chapterTOC[0].isRoot())
        println(chapterTOC[0].getId())
        println(chapterTOC[0].getChildren().toString())
        println(chapterTOC[0].isOrdered())
        println(chapterTOC[0].getLength())
        println(chapterTOC[0].toString())
        var Childrensave: Option<Array<String>> = Option<Array<String>>.Some([])
        chapterTOC[0].setRoot(true)
        chapterTOC[0].setOrdered(true)
        chapterTOC[0].setId("12.25qwe")
        chapterTOC[0].setChildren(Childrensave)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        @Assert(chapterTOCsave[0].isRoot(),true)
        @Assert(chapterTOCsave[0].isOrdered(),true)
        @Assert(chapterTOCsave[0].getId(),"12.25qwe")
        @Assert(chapterTOCsave[0].getChildren().toString(),"Some([])")
        @Assert(chapterTOCsave[0].getLength().toString(),"11")
        @Assert(chapterTOCsave[0].toString().toString(),"ID3v2ChapterTOCFrameData [isRoot=true, isOrdered=true, id=Some(12.25qwe), children=Some([]), subframes=[]]")
    }

    @TestCase
    func mp3agic_AlbumImage016(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("TIT3", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,80, 81])
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TIT3")
        @Assert(subframessave[0].getLength(),28)
        @Assert(subframessave[0].getDataLength(),18)
        @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
    }

    @TestCase
    func mp3agic_AlbumImage17(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
            var id3v2Frame1: ID3v2Frame = ID3v2Frame("仓颉", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77,78, 79, 80, 81])
            var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
            subframes.append(id3v2Frame1);
            subframes.append(id3v2Frame2);
            id3v2Frame.setSubframes(subframes)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"TIT3")
            @Assert(subframessave[0].getLength(),28)
            @Assert(subframessave[0].getDataLength(),18)
            @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage18(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
            var id3v2Frame1: ID3v2Frame = ID3v2Frame("", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,80, 81])
            var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
            subframes.append(id3v2Frame1);
            subframes.append(id3v2Frame2);
            id3v2Frame.setSubframes(subframes)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"TIT3")
            @Assert(subframessave[0].getLength(),28)
            @Assert(subframessave[0].getDataLength(),18)
            @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage19(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
            var id3v2Frame1: ID3v2Frame = ID3v2Frame("123", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78,79, 80, 81])
            var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
            subframes.append(id3v2Frame1);
            subframes.append(id3v2Frame2);
            id3v2Frame.setSubframes(subframes)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"TIT3")
            @Assert(subframessave[0].getLength(),28)
            @Assert(subframessave[0].getDataLength(),18)
            @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage20(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("1233456789", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77,78, 79, 80, 81])
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"1233")
        @Assert(subframessave[0].getLength(),28)
        @Assert(subframessave[0].getDataLength(),18)
        @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
    }

    @TestCase
    func mp3agic_AlbumImage21(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("QWE456789", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77,78, 79, 80, 81])
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"QWE4")
        @Assert(subframessave[0].getLength(),28)
        @Assert(subframessave[0].getDataLength(),18)
        @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
    }

    @TestCase
    func mp3agic_AlbumImage22(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
            var id3v2Frame1: ID3v2Frame = ID3v2Frame("qWE456789", [0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76,77, 78, 79, 80, 81])
            var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
            subframes.append(id3v2Frame1);
            subframes.append(id3v2Frame2);
            id3v2Frame.setSubframes(subframes)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"QWE4")
            @Assert(subframessave[0].getLength(),28)
            @Assert(subframessave[0].getDataLength(),18)
            @Assert(subframessave[0].getData().toString(),"[0, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage23(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subframes: ArrayList<ID3v2Frame> = ArrayList<ID3v2Frame>();
        var id3v2Frame1: ID3v2Frame = ID3v2Frame("WE456789", [])
        var id3v2Frame2: ID3v2Frame = ID3v2Frame("TIT2", [0, 53, 32, 115, 101, 99, 111, 110, 100, 115])
        subframes.append(id3v2Frame1);
        subframes.append(id3v2Frame2);
        id3v2Frame.setSubframes(subframes)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"WE45")
        @Assert(subframessave[0].getLength(),10)
        @Assert(subframessave[0].getDataLength(),0)
        @Assert(subframessave[0].getData().toString(),"[]")
    }

    @TestCase
    func mp3agic_AlbumImage24(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("cangjie"))
        id3v2Frame.addSubframe("TRCK", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TRCK")
        @Assert(subframessave[0].getLength(),18)
        @Assert(subframessave[0].getDataLength(),8)
        @Assert(subframessave[0].getData().toString(),"[0, 99, 97, 110, 103, 106, 105, 101]")
    }

    @TestCase
    func mp3agic_AlbumImage25(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("仓颉"))
        id3v2Frame.addSubframe("TRCK", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TRCK")
        @Assert(subframessave[0].getLength(),17)
        @Assert(subframessave[0].getDataLength(),7)
        @Assert(subframessave[0].getData().toString(),"[2, -2, -1, 78, -45, -104, -119]")
    }

    @TestCase
    func mp3agic_AlbumImage26(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText(3, "仓颉13456789"))
        id3v2Frame.addSubframe("TRCK", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TRCK")
        @Assert(subframessave[0].getLength(),25)
        @Assert(subframessave[0].getDataLength(),15)
        @Assert(subframessave[0].getData().toString(),"[3, -28, -69, -109, -23, -94, -119, 49, 51, 52, 53, 54, 55, 56, 57]")
    }

    @TestCase
    func mp3agic_AlbumImage27(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText(""))
        id3v2Frame.addSubframe("TRCK", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TRCK")
        @Assert(subframessave[0].getLength(),11)
        @Assert(subframessave[0].getDataLength(),1)
        @Assert(subframessave[0].getData().toString(),"[0]")
    }

    @TestCase
    func mp3agic_AlbumImage28(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
        id3v2Frame.addSubframe("TRCK", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"TRCK")
        @Assert(subframessave[0].getLength(),16)
        @Assert(subframessave[0].getDataLength(),6)
        @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
    }

    @TestCase
    func mp3agic_AlbumImage29(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
            id3v2Frame.addSubframe("qwew", subFrameData1)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"TRCK")
            @Assert(subframessave[0].getLength(),16)
            @Assert(subframessave[0].getDataLength(),6)
            @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage30(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
        id3v2Frame.addSubframe("QWER", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"QWER")
        @Assert(subframessave[0].getLength(),16)
        @Assert(subframessave[0].getDataLength(),6)
        @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
    }

    @TestCase
    func mp3agic_AlbumImage31(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
            id3v2Frame.addSubframe("QWERQWEQWEQWEQWEQWEQWE", subFrameData1)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"QWERQW")
            @Assert(subframessave[0].getLength(),16)
            @Assert(subframessave[0].getDataLength(),6)
            @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage32(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
            id3v2Frame.addSubframe("仓颉", subFrameData1)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"EQWEQWE")
            @Assert(subframessave[0].getLength(),16)
            @Assert(subframessave[0].getDataLength(),6)
            @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage33(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
            var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
            println(id3v2Frame.isRoot())
            println(id3v2Frame.getId())
            println(id3v2Frame.getChildren().toString())
            println(id3v2Frame.isOrdered())
            println(id3v2Frame.getLength())
            println(id3v2Frame.toString())
            var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
            id3v2Frame.addSubframe("……*&%", subFrameData1)
            id3V22Tag.setChapterTOC(chapterTOC)
            mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
            var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
            var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
            var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
            @Assert(subframessave[0].getId(),"EQWEQWE")
            @Assert(subframessave[0].getLength(),16)
            @Assert(subframessave[0].getDataLength(),6)
            @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: index: 0, size: 0")
        }
    }

    @TestCase
    func mp3agic_AlbumImage34(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
        id3v2Frame.addSubframe("1234", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"1234")
        @Assert(subframessave[0].getLength(),16)
        @Assert(subframessave[0].getDataLength(),6)
        @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
    }

    @TestCase
    func mp3agic_AlbumImage35(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
        var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
        println(id3v2Frame.isRoot())
        println(id3v2Frame.getId())
        println(id3v2Frame.getChildren().toString())
        println(id3v2Frame.isOrdered())
        println(id3v2Frame.getLength())
        println(id3v2Frame.toString())
        var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
        id3v2Frame.addSubframe("1234", subFrameData1)
        id3V22Tag.setChapterTOC(chapterTOC)
        mp3File.save("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var mp3Filesave: Mp3File = Mp3File("../../HLT/save_update_ch1_v23tagwithchapters.mp3")
        var id3v2TagSave: ID3v2 = mp3Filesave.getId3v2Tag().getOrThrow()
        var chapterTOCsave: ArrayList<ID3v2ChapterTOCFrameData> = id3v2TagSave.getChapterTOC().getOrThrow()
        var subframessave: ArrayList<ID3v2Frame> = chapterTOCsave[0].getSubframes().getOrThrow()
        @Assert(subframessave[0].getId(),"1234")
        @Assert(subframessave[0].getLength(),16)
        @Assert(subframessave[0].getDataLength(),6)
        @Assert(subframessave[0].getData().toString(),"[0, 36, 35, 64, 64, 36]")
    }
}
