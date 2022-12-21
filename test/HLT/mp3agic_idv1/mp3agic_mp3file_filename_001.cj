// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_Filename_001 {
    @TestCase
    func mp3agic_Filename_001(): Unit {
        var mp3File: Mp3File = Mp3File("v1tag.mp3") //正确的路径   
        var ID3V1 = mp3File.getId3v1Tag().getOrThrow()
        @Assert(mp3File.hasId3v1Tag().toString(),"true")
        @Assert(ID3V1.getVersion(),"1")
        @Assert(ID3V1.getTitle(),"TITLE1234567890123456789012345")
        @Assert(ID3V1.getTrack(),"1")
        @Assert(ID3V1.getArtist(),"ARTIST123456789012345678901234")
        @Assert(ID3V1.getAlbum(),"ALBUM1234567890123456789012345")
        @Assert(ID3V1.getYear(),"2001")
        @Assert(ID3V1.getComment(),"COMMENT123456789012345678901")
        @Assert(ID3V1.getGenre().toString(),"Some(13)")
        @Assert(ID3V1.getGenreDescription(),"Pop")

        try {
            var mp3File0: Mp3File = Mp3File("v1ta.mp3") //错误格式路径
            var biaoqian = mp3File0.hasId3v1Tag()
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
        try {
            var mp3File01: Mp3File = Mp3File("") //空字符串
            var biaoqian = mp3File01.hasId3v1Tag()
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
        var mp3File02: Mp3File = Mp3File("v1tag.mp3", 3000) //正确的路径最大的文件长度     

        //var biaoqian2=mp3File02.hasId3v1Tag()
        //let ID3V1=mp3File01.getId3v1Tag()
        var ID3V102 = mp3File02.getId3v1Tag().getOrThrow()

        //var version2 = ID3V2.getVersion()                          //获得子版本
        //var title2 = ID3V2.getTitle()                              //获得标题(歌名) 1    4-33
        //var track2 = ID3V2.getTrack()                              //获得成员
        //var artist2 = ID3V2.getArtist()                            //获得作者 1         34-63
        //var album2 = ID3V2.getAlbum()                              //获得专辑 1         64-93
        //var year2 = ID3V2.getYear()                                //获得年份 1         94-97
        //var comm2 = ID3V2.getComment()                             //获得附注 1         98-127
        //var genre2 = ID3V2.getGenre()                              //获得风格             128
        //var des2 = ID3V2.getGenreDescription()                     //获得风格描述
        @Assert(mp3File02.hasId3v1Tag().toString(),"true")
        @Assert(ID3V102.getVersion()  ,"1")
        @Assert(ID3V102.getTitle() ,"TITLE1234567890123456789012345")
        @Assert(ID3V102.getTrack()   ,"1")
        @Assert(ID3V102.getArtist() ,"ARTIST123456789012345678901234")
        @Assert(ID3V102.getAlbum()  ,"ALBUM1234567890123456789012345")
        @Assert(ID3V102.getYear() ,"2001")
        @Assert(ID3V102.getComment(),"COMMENT123456789012345678901")
        @Assert(ID3V102.getGenre().toString(),"Some(13)")
        @Assert(ID3V102.getGenreDescription() ,"Pop")

        var mp3File03: Mp3File = Mp3File("v1tag.mp3", 300) //正确的路径小于文件长度大于40      
        var ID3V103 = mp3File03.getId3v1Tag().getOrThrow()
        @Assert(mp3File03.hasId3v1Tag().toString(),"true")
        @Assert(ID3V103.getVersion() ,"1")
        @Assert(ID3V103.getTitle() ,"TITLE1234567890123456789012345")
        @Assert(ID3V103.getTrack(),"1")
        @Assert(ID3V103.getArtist() ,"ARTIST123456789012345678901234")
        @Assert(ID3V103.getAlbum(),"ALBUM1234567890123456789012345")
        @Assert(ID3V103.getYear(),"2001")
        @Assert(ID3V103.getComment(),"COMMENT123456789012345678901")
        @Assert(ID3V103.getGenre().toString(),"Some(13)")
        @Assert(ID3V103.getGenreDescription(),"Pop")

        try {
            var mp3File04: Mp3File = Mp3File("v1tag.mp3", 1) //正确的路径小于文件小于40
            var biaoqian4 = mp3File04.hasId3v1Tag()
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: Buffer too small")
        }
        try {
            var mp3File05: Mp3File = Mp3File("./v1ta.mp3", 1) //错误的路径小于文件小于40
            var biaoqian5 = mp3File05.hasId3v1Tag()
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
    }
}
