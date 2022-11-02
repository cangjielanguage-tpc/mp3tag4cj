// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v24tagswithalbumimage.mp3
// data_file:./v1tag.mp3 
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_ID3v2_01 {
    @TestCase
    func mp3agic_Id3v2_001(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")

        //var mp3File:Mp3File=Mp3File("../v24tagswithalbumimage.mp3")       
        var id3V2Tag = mp3File.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag.getComment(),"COMMENT123456789012345678901")
        @Assert(id3V2Tag.getItunesComment().toString(),"None")
        @Assert(id3V2Tag.getLyrics(),"LYRICS1234567890123456789012345")
    }

    @TestCase
    func mp3agic_Id3v2_002(): Unit { //设置comm,ItunesComment,Lyrics为空格                                                                                                      
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setComment(Option<String>.Some(" "))
        id3V2Tag.setItunesComment(Option<String>.Some(" "))
        id3V2Tag.setLyrics(Option<String>.Some(" "))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag01.getComment()," ")
        @Assert(id3V2Tag01.getItunesComment()," ")
        @Assert(id3V2Tag01.getLyrics()," ")
    }

    @TestCase
    func mp3agic_Id3v2_003(): Unit { //设置comm为空                                                                                                         
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setComment(Option<String>.Some(""))
        id3V2Tag.setLyrics(Option<String>.Some(""))
        id3V2Tag.setItunesComment(Option<String>.Some(""))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag01.getComment(),"COMMENT123456789012345678901")
        @Assert(id3V2Tag01.getItunesComment().toString(),"None")
        @Assert(id3V2Tag01.getLyrics(),"LYRICS1234567890123456789012345")
    }

    @TestCase
    func mp3agic_Id3v2_004(): Unit { //设置comm为中文
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
            var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
            id3V2Tag.setComment(Option<String>.Some("你好仓颉"))
            id3V2Tag.setLyrics(Option<String>.Some("你好仓颉"))
            id3V2Tag.setItunesComment(Option<String>.Some("你好仓颉"))
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: description and comment must have same text encoding")
        }
    }

    @TestCase
    func mp3agic_Id3v2_005(): Unit { //设置comm为英文                                                                                                       
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setComment(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setLyrics(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setItunesComment(Option<String>.Some("nihaocangjie"))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag01.getComment(),"nihaocangjie")
        @Assert(id3V2Tag01.getItunesComment(),"nihaocangjie")
        @Assert(id3V2Tag01.getLyrics(),"nihaocangjie")
    }

    @TestCase
    func mp3agic_Id3v2_006(): Unit {
        var data: String = """
                7410852965329634517474185296363741852963637415263637410852074108520852085274108529653296345174741852963
                6374185296363741526363741085207410852085208527410852965329634517474185296363741852963637415263637410852
                0741085208520852741085296532963451747418529636374185296363741526363741085207410852085208527410852965329
                6345174741852963637418529636374152636374108520741085208520852741085296532963451747418529636374185296363"""
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setComment(Option<String>.Some("data"))
        id3V2Tag.setLyrics(Option<String>.Some("data"))
        id3V2Tag.setItunesComment(Option<String>.Some("data"))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag01.getComment(),"data")
        @Assert(id3V2Tag01.getItunesComment(),"data")
        @Assert(id3V2Tag01.getLyrics(),"data")
    }

    @TestCase
    func mp3agic_Id3v2_007(): Unit { //设置comm为字符
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
            var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
            id3V2Tag.setComment(Option<String>.Some("“*&……￥#"))
            id3V2Tag.setLyrics(Option<String>.Some("“*&……￥#"))
            id3V2Tag.setItunesComment(Option<String>.Some("“*&……￥#"))
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: description and comment must have same text encoding")
        }
    }

    @TestCase
    func mp3agic_Id3v2_008(): Unit { //设置comm为字符
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
            var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
            id3V2Tag.setComment(Option<String>.Some("你好仓颉,nihao1cangjie11232"))
            id3V2Tag.setLyrics(Option<String>.Some("你好仓颉,nihao1cangjie11232"))
            id3V2Tag.setItunesComment(Option<String>.Some("你好仓颉,nihao1cangjie11232"))
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: description and comment must have same text encoding")
        }
    }
}
