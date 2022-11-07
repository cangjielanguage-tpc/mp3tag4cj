// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_Filename_004 {
    @TestCase
    func mp3agic_Filename_004(): Unit {
        var mp3File010: Mp3File = Mp3File("v1tag.mp3", 300, false) //移除ID3V1标签    
        var ID3V10 = mp3File010.getId3v1Tag().getOrThrow()
        mp3File010.removeId3v1Tag()
        var biaoqian10 = mp3File010.hasId3v1Tag()
        @Assert(biaoqian10,false)

        var mp3File011: Mp3File = Mp3File("v1tag.mp3", 300, false) //设置全部ID3V1标签
        var ID3V111 = mp3File011.getId3v1Tag().getOrThrow()
        var id3v1: ID3v1Tag = ID3v1Tag()
        id3v1.setTrack(Option<String>.Some(""))
        id3v1.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v1.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v1.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v1.setYear(Option<String>.Some("19940821"))
        id3v1.setGenre(Option<Int64>.Some(20))
        id3v1.setComment(Option<String>.Some("NEWCOMMENT123456"))
        mp3File011.setId3v1Tag(Option<ID3v1>.Some(id3v1))
        var ID3V112 = mp3File011.getId3v1Tag().getOrThrow()
        @Assert(ID3V112.getYear(),"19940821")
        @Assert(ID3V112.getArtist(),"NEWARTIST12345678901234567890")

        var mp3File012: Mp3File = Mp3File("v1tag.mp3", 300, false) //设置部分ID3V1标签
        var ID3V13 = mp3File012.getId3v1Tag().getOrThrow()
        var id3v101: ID3v1Tag = ID3v1Tag()
        id3v101.setTrack(Option<String>.Some(""))
        id3v101.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v101.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v101.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v101.setGenre(Option<Int64>.Some(20))
        id3v101.setComment(Option<String>.Some("NEWCOMMENT123456"))
        mp3File012.setId3v1Tag(Option<ID3v1>.Some(id3v101))
        var ID3V14 = mp3File012.getId3v1Tag().getOrThrow()
        @Assert(ID3V14.getYear().toString(),"None")
        @Assert(ID3V14.getArtist(),"NEWARTIST12345678901234567890")
    }
}
