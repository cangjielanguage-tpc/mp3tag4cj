// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*

@Test
public class mp3agic_FileInfo_003 {
    @TestCase
    func mp3agic_FileInfo_003(): Unit {
        var file13 = FileInfo("../../mp3agic_idv1/v1tag.mp3") //设置全部标签内容
        var file14 = Mp3File(file13, 300, true)
        var id3v1: ID3v1Tag = ID3v1Tag()
        id3v1.setTrack(Option<String>.Some(""))
        id3v1.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v1.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v1.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v1.setYear(Option<String>.Some("19940821"))
        id3v1.setGenre(Option<Int64>.Some(20))
        id3v1.setComment(Option<String>.Some("NEWCOMMENT123456"))
        file14.setId3v1Tag(Option<ID3v1>.Some(id3v1))
        var file15 = Mp3File(file13, 300, true)
        var ID3V103 = file14.getId3v1Tag().getOrThrow()
        @Assert(ID3V103.getTrack().toString(),"Some()")
        @Assert(ID3V103.getArtist().toString(),"Some(NEWARTIST12345678901234567890)")
        @Assert(ID3V103.getTitle().toString(),"Some(NEWTITLE12345678901234567890)")
        @Assert(ID3V103.getAlbum().toString(),"Some(NEWALBUM1234567890123456789011111111111111111111111111)")
        @Assert(ID3V103.getYear().toString(),"Some(19940821)")
        @Assert(ID3V103.getGenre().toString(),"Some(20)")
        @Assert(ID3V103.getComment().toString(),"Some(NEWCOMMENT123456)")

        var file16 = FileInfo("../../mp3agic_idv1/v1tag.mp3") //设置部分标签内容
        var file17 = Mp3File(file16, 300, true)
        var id3v10: ID3v1Tag = ID3v1Tag()
        id3v10.setTrack(Option<String>.Some(""))
        id3v10.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v10.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v10.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v10.setGenre(Option<Int64>.Some(20))
        id3v10.setComment(Option<String>.Some("NEWCOMMENT123456"))
        file17.setId3v1Tag(Option<ID3v1>.Some(id3v10))
        var file18 = Mp3File(file16, 300, true)
        var ID3V4 = file17.getId3v1Tag().getOrThrow()
        @Assert(ID3V4.getTrack().toString(),"Some()")
        @Assert(ID3V4.getArtist().toString(),"Some(NEWARTIST12345678901234567890)")
        @Assert(ID3V4.getTitle().toString(),"Some(NEWTITLE12345678901234567890)")
        @Assert(ID3V4.getAlbum().toString(),"Some(NEWALBUM1234567890123456789011111111111111111111111111)")
        @Assert(ID3V4.getGenre().toString(),"Some(20)")
        @Assert(ID3V4.getComment().toString(),"Some(NEWCOMMENT123456)")

        var file23 = FileInfo("../../mp3agic_idv1/v1tag.mp3") //移除标签
        var file24 = Mp3File(file23, 300, true)
        var ID3V6 = file24.getId3v1Tag().getOrThrow()
        file24.removeId3v1Tag()
        @Assert(file24.hasId3v1Tag().toString(),"false")
    }
}
