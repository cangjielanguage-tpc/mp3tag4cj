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
public class mp3agic_FileInfo_004 {
    @TestCase
    func mp3agic_FileInfo_004(): Unit {
        var file25 = FileInfo("v1tag.mp3") //不修改保存正确新路径
        var file26 = Mp3File(file25, 300, true)
        var ID3V7 = file26.getId3v1Tag().getOrThrow()
        file26.save("newv1tag.mp3")
        var file27 = Mp3File(file25, 300, true)
        var ID3V8 = file27.getId3v1Tag().getOrThrow()
        @Assert(file27.hasId3v1Tag().toString(),"true")

        try {
            var file28 = FileInfo("v1tag.mp3") //不修改保存错误路径
            var file29 = Mp3File(file28, 300, true)
            var ID3V9 = file29.getId3v1Tag().getOrThrow()
            file29.save("jwb123./newv1213tag.mp3")
            var file41 = Mp3File(file28, 300, true)
            var ID3V30 = file41.getId3v1Tag().getOrThrow()
            @Assert(file41.hasId3v1Tag().toString(),"true")
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The path `jwb123.` does not exist.")
        }
        var file30 = FileInfo("v1tag.mp3") //设置部分标签内容保存到正确路径
        var file31 = Mp3File(file30, 300, true)
        var id3v11: ID3v1Tag = ID3v1Tag()
        id3v11.setTrack(Option<String>.Some(""))
        id3v11.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v11.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v11.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v11.setGenre(Option<Int64>.Some(20))
        id3v11.setComment(Option<String>.Some("NEWCOMMENT123456"))
        file31.setId3v1Tag(Option<ID3v1>.Some(id3v11))
        file31.save("../../newv1tag.mp3")
        var file32 = Mp3File(file30, 300, true)
        var ID3V10 = file31.getId3v1Tag().getOrThrow()
        @Assert(ID3V10.getArtist().toString(),"Some(NEWARTIST12345678901234567890)")

        try {
            var file33 = FileInfo("v1tag.mp3") //设置部分标签内容保存到错误正确路径
            var file34 = Mp3File(file33, 300, true)
            var id3v12: ID3v1Tag = ID3v1Tag()
            id3v12.setTrack(Option<String>.Some(""))
            id3v12.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
            id3v12.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
            id3v12.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
            id3v12.setGenre(Option<Int64>.Some(20))
            id3v12.setComment(Option<String>.Some("NEWCOMMENT123456"))
            file34.setId3v1Tag(Option<ID3v1>.Some(id3v12))
            file34.save(".home/newv1tag.mp3")
            var file88 = Mp3File(file33, 300, true)
            var ID3V99 = file88.getId3v1Tag().getOrThrow()
            @Assert(file88.hasId3v1Tag().toString(),"true")
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The path `.home` does not exist.")
        }
        try {
            var file34 = FileInfo("v1tag.mp3") //设置部分标签内容保存到相同路径
            var file35 = Mp3File(file34, 300, true)
            var id3v13: ID3v1Tag = ID3v1Tag()
            id3v13.setTrack(Option<String>.Some(""))
            id3v13.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
            id3v13.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
            id3v13.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
            id3v13.setGenre(Option<Int64>.Some(20))
            id3v13.setComment(Option<String>.Some("NEWCOMMENT123456"))
            file35.setId3v1Tag(Option<ID3v1>.Some(id3v13))
            file35.save("v1tag.mp3")
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: Save filename same as source filename")
        }
        var file36 = FileInfo("v1tag.mp3") //设置部分标签内容保存到mp4后缀
        var file37 = Mp3File(file36, 300, true)
        var id3v14: ID3v1Tag = ID3v1Tag()
        id3v14.setTrack(Option<String>.Some(""))
        id3v14.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v14.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v14.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v14.setGenre(Option<Int64>.Some(20))
        id3v14.setComment(Option<String>.Some("NEWCOMMENT123456"))
        file37.setId3v1Tag(Option<ID3v1>.Some(id3v14))
        file37.save("v1tag.mp4")
        var file38 = Mp3File(file36, 300, true)
        var ID3V13 = file37.getId3v1Tag().getOrThrow()
        @Assert(ID3V13.getArtist().toString(),"Some(NEWARTIST12345678901234567890)")
    }
}
