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
public class Mp3agic_Filename_005 {
    @TestCase
    func mp3agic_Filename_005(): Unit {
        var mp3File013: Mp3File = Mp3File("v1tag.mp3", 300, true) //保存正确的路径格式名
        var ID3V15 = mp3File013.getId3v1Tag().getOrThrow()
        var id3v102: ID3v1Tag = ID3v1Tag()
        id3v102.setTrack(Option<String>.Some(""))
        id3v102.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v102.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v102.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v102.setGenre(Option<Int64>.Some(20))
        id3v102.setComment(Option<String>.Some("NEWCOMMENT123456"))
        mp3File013.setId3v1Tag(Option<ID3v1>.Some(id3v102))
        mp3File013.save("savev1tag.mp3")
        var ID3V16 = mp3File013.getId3v1Tag().getOrThrow()
        @Assert(ID3V16.getArtist(),"NEWARTIST12345678901234567890")

        try {
            var mp3File014: Mp3File = Mp3File("v1tag.mp3", 300, true) //保存错误的路径
            var ID3V17 = mp3File014.getId3v1Tag().getOrThrow()
            var id3v103: ID3v1Tag = ID3v1Tag()
            id3v103.setTrack(Option<String>.Some(""))
            id3v103.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
            id3v103.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
            id3v103.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
            id3v103.setGenre(Option<Int64>.Some(20))
            id3v103.setComment(Option<String>.Some("NEWCOMMENT123456"))
            mp3File014.setId3v1Tag(Option<ID3v1>.Some(id3v103))
            mp3File014.save("123./v1tagss.mp3")
            var ID3V99 = mp3File014.getId3v1Tag().getOrThrow()
            @Assert(ID3V99.getArtist(),"NEWARTIST12345678901234567890")
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: Failed to open the file!")
        }
        var mp3File015: Mp3File = Mp3File("v1tag.mp3", 300, true) //保存错误的格式
        var ID3V18 = mp3File015.getId3v1Tag().getOrThrow()
        var id3v104: ID3v1Tag = ID3v1Tag()
        id3v104.setTrack(Option<String>.Some(""))
        id3v104.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v104.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v104.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v104.setGenre(Option<Int64>.Some(20))
        id3v104.setComment(Option<String>.Some("NEWCOMMENT123456"))
        mp3File015.setId3v1Tag(Option<ID3v1>.Some(id3v104))
        mp3File015.save("v1tag.mp4")
        var mp3File016: Mp3File = Mp3File("v1tag.mp4", 300, true)
        var ID3V19 = mp3File016.getId3v1Tag().getOrThrow()
        @Assert(ID3V19.getArtist(),"NEWARTIST12345678901234567890")

        try {
            var mp3File016: Mp3File = Mp3File("v1tag.mp3", 300, true) //保存空路径
            var ID3V19 = mp3File016.getId3v1Tag().getOrThrow()
            var id3v105: ID3v1Tag = ID3v1Tag()
            id3v105.setTrack(Option<String>.Some(""))
            id3v105.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
            id3v105.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
            id3v105.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
            id3v105.setGenre(Option<Int64>.Some(20))
            id3v105.setComment(Option<String>.Some("NEWCOMMENT123456"))
            mp3File016.setId3v1Tag(Option<ID3v1>.Some(id3v105))
            mp3File016.save("")
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The file path cannot be empty.")
        }
    }
}
