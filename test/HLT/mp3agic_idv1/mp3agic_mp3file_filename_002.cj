// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_Filename_002 {
    @TestCase
    func mp3agic_Filename_002(): Unit {
        var mp3File06: Mp3File = Mp3File("v1tag.mp3", true) //正确的路径进行文件扫描      
        var ID3V106 = mp3File06.getId3v1Tag().getOrThrow()
        @Assert(mp3File06.hasId3v1Tag().toString(),"true")
        @Assert(ID3V106.getVersion(),"1")
        @Assert(ID3V106.getTitle(),"TITLE1234567890123456789012345")
        @Assert(ID3V106.getTrack(),"1")
        @Assert(ID3V106.getArtist() ,"ARTIST123456789012345678901234")
        @Assert(ID3V106.getAlbum(),"ALBUM1234567890123456789012345")
        @Assert(ID3V106.getYear(),"2001")
        @Assert(ID3V106.getComment(),"COMMENT123456789012345678901")
        @Assert(ID3V106.getGenre().toString(),"Some(13)")
        @Assert(ID3V106.getGenreDescription(),"Pop")

        var mp3File07: Mp3File = Mp3File("v1tag.mp3", false) //正确的路径不进行文件扫描      
        var ID3V107 = mp3File07.getId3v1Tag().getOrThrow()
        @Assert(mp3File07.hasId3v1Tag().toString(),"true")
        @Assert(ID3V107.getVersion(),"1")
        @Assert(ID3V107.getTitle(),"TITLE1234567890123456789012345")
        @Assert(ID3V107.getTrack(),"1")
        @Assert(ID3V107.getArtist(),"ARTIST123456789012345678901234")
        @Assert(ID3V107.getAlbum(),"ALBUM1234567890123456789012345")
        @Assert(ID3V107.getYear(),"2001")
        @Assert(ID3V107.getComment(),"COMMENT123456789012345678901")
        @Assert(ID3V107.getGenre().toString(),"Some(13)")
        @Assert(ID3V107.getGenreDescription(),"Pop")

        try {
            var mp3File08: Mp3File = Mp3File("../../mp3agic_idv1/v1ta.mp3", true) //异常的路径进行文件扫描      
            var biaoqian8 = mp3File08.hasId3v1Tag()
            var ID3V108 = mp3File08.getId3v1Tag().getOrThrow()
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
        try {
            var mp3File08: Mp3File = Mp3File("../../mp3agic_idv1/v1ta.mp3", false) //异常的路径不进行文件扫描      
            var biaoqian8 = mp3File08.hasId3v1Tag()
            var ID3V108 = mp3File08.getId3v1Tag().getOrThrow()
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
    }
}
