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
public class Mp3agic_Filename_003 {
    @TestCase
    func mp3agic_Filename_003(): Unit {
        var mp3File08: Mp3File = Mp3File("v1tag.mp3", 300, false) //正确的路径大于40长度不进行文件扫描      
        var ID3V108 = mp3File08.getId3v1Tag().getOrThrow()
        @Assert(mp3File08.hasId3v1Tag().toString(),"true")
        @Assert(ID3V108.getVersion(),"1")
        @Assert(ID3V108.getTitle(),"TITLE1234567890123456789012345")
        @Assert(ID3V108.getTrack(),"1")
        @Assert(ID3V108.getArtist(),"ARTIST123456789012345678901234")
        @Assert(ID3V108.getAlbum(),"ALBUM1234567890123456789012345")
        @Assert(ID3V108.getYear(),"2001")
        @Assert(ID3V108.getComment(),"COMMENT123456789012345678901")
        @Assert(ID3V108.getGenre().toString(),"Some(13)")
        @Assert(ID3V108.getGenreDescription(),"Pop")

        try {
            var mp3File09: Mp3File = Mp3File("v1tag.mp3", 31, true) //正确的路径小于40长度进行文件扫描      
            var biaoqian9 = mp3File09.hasId3v1Tag()
            var ID3V109 = mp3File09.getId3v1Tag().getOrThrow()
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: Buffer too small")
        }
        try {
            var mp3File09: Mp3File = Mp3File("v1ta.mp3", 31, true) //错误的路径小于40长度进行文件扫描      
            var biaoqian9 = mp3File09.hasId3v1Tag()
            var ID3V109 = mp3File09.getId3v1Tag().getOrThrow()
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
    }
}
