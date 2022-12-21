// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
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
        @Assert(mp3File.hasId3v2Tag(),true)
    }

    @TestCase
    func mp3agic_Id3v2_002(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")
        @Assert(mp3File.hasId3v2Tag(),false)
    }

    @TestCase
    func mp3agic_Id3v2_003(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")
        mp3File.removeId3v2Tag()
        @Assert(mp3File.hasId3v2Tag(),false)
    }

    @TestCase
    func mp3agic_Id3v2_004(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")
        mp3File.removeId3v2Tag()
        @Assert(mp3File.hasId3v2Tag(),false)
    }

    @TestCase
    func mp3agic_Id3v2_005(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")
            var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
            println(id3V2Tag.getComment())
            @Assert(id3V2Tag.getComment(),"COMMENT123456789012345678901")
            @Assert(id3V2Tag.getItunesComment().toString(),"None")
            @Assert(id3V2Tag.getLyrics(),"LYRICS1234567890123456789012345")
        } catch (e: Exception) {
            @Assert(e.toString(),"NoneValueException")
        }
    }
}
