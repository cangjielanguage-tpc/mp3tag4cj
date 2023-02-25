// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*

@Test
public class mp3agic_FileInfo_002 {
    @TestCase
    func mp3agic_FileInfo_002(): Unit {
        var file10 = FileInfo("v1tag.mp3") //以fileinfo构造长度大于40scanfile为true
        var file111 = Mp3File(file10, 300, true)
        @Assert(file111.hasId3v1Tag(),true)

        try {
            var file12 = FileInfo("v1ta.mp3") //以异常路径构造fileinfo长度大于40scanfile为true
            var file13 = Mp3File(file12, 300, true)
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The path `v1ta.mp3` does not exist")
        }
        try {
            var file13 = FileInfo("v1tag.mp3") //以正常路径构造fileinfo长度最大2997scanfile为false
            var file14 = Mp3File(file13, 2997, false)
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The path `v1ta.mp3` does not exist")
        }
        try {
            var file15 = FileInfo("v1ta.mp3") //以异常路径构造fileinfo长度为0scanfile为false
            var file16 = Mp3File(file15, 0, false)
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The path `v1ta.mp3` does not exist")
        }
        var file11 = FileInfo("v1tag.mp3") //以fileinfo构造长度大于40scanfile为true
        var file12 = Mp3File(file11, 300, true)
        var ID3V1 = file12.getId3v1Tag().getOrThrow()
        @Assert(ID3V1.getVersion() ,"1")
        @Assert(ID3V1.getTitle(),"TITLE1234567890123456789012345")
        @Assert(ID3V1.getTrack(),"1")
        @Assert(ID3V1.getArtist(),"ARTIST123456789012345678901234")
        @Assert(ID3V1.getAlbum(),"ALBUM1234567890123456789012345")
        @Assert(ID3V1.getYear() ,"2001")
        @Assert(ID3V1.getComment(),"COMMENT123456789012345678901")
        @Assert(ID3V1.getGenre().toString(),"Some(13)")
        @Assert(ID3V1.getGenreDescription(),"Pop")
    }
}
