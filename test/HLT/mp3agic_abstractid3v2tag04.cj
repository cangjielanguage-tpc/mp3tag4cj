// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1andv23tagswithalbumimage.mp3
// data_file:./qinggewang.mp3
// data_file:./v1tag.mp3
// data_file:./id3v1.jpeg 
// data_file:./16pic_25.png
// data_file:./id3v11.gif  
// data_file:./v23tagwithchapters.mp3 
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import math.*

@Test
public class Mp3agic_AlbumImage {
    @TestCase
    func mp3agic_AlbumImage01(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var POPM = id3V22Tag.getWmpRating()
        @Assert(id3V22Tag.getWmpRating(),-1)
    }

    @TestCase
    func mp3agic_AlbumImage02(): Unit {
        try {
            var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")
            var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
            var POPM = id3V22Tag.getWmpRating()
            @Assert(id3V22Tag.getWmpRating(),-1)
        } catch (e: Exception) {
            @Assert(e.toString(),"NoneValueException")
        }
    }

    @TestCase
    func mp3agic_AlbumImage03(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        println(id3V22Tag.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),-1)
        id3V22Tag.setWmpRating(1)
        mp3File.save("../../HLT/save_popm_v23tagwithchapters.mp3")
        var mp3Filepopm: Mp3File = Mp3File("../../HLT/save_popm_v23tagwithchapters.mp3")
        var id3V22Tagpopm: ID3v2 = mp3Filepopm.getId3v2Tag().getOrThrow()
        println(id3V22Tagpopm.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),1)
    }

    @TestCase
    func mp3agic_AlbumImage04(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        println(id3V22Tag.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),-1)
        id3V22Tag.setWmpRating(2147483647)
        mp3File.save("../../HLT/save_popm_v23tagwithchapters.mp3")
        var mp3Filepopm: Mp3File = Mp3File("../../HLT/save_popm_v23tagwithchapters.mp3")
        var id3V22Tagpopm: ID3v2 = mp3Filepopm.getId3v2Tag().getOrThrow()
        println(id3V22Tagpopm.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),-1)
    }

    @TestCase
    func mp3agic_AlbumImage05(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        println(id3V22Tag.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),-1)
        id3V22Tag.setWmpRating(-2147483648)
        mp3File.save("../../HLT/save_popm_v23tagwithchapters.mp3")
        var mp3Filepopm: Mp3File = Mp3File("../../HLT/save_popm_v23tagwithchapters.mp3")
        var id3V22Tagpopm: ID3v2 = mp3Filepopm.getId3v2Tag().getOrThrow()
        println(id3V22Tagpopm.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),-1)
    }

    @TestCase
    func mp3agic_AlbumImage06(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        println(id3V22Tag.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),-1)
        id3V22Tag.setWmpRating(0)
        mp3File.save("../../HLT/save_popm_v23tagwithchapters.mp3")
        var mp3Filepopm: Mp3File = Mp3File("../../HLT/save_popm_v23tagwithchapters.mp3")
        var id3V22Tagpopm: ID3v2 = mp3Filepopm.getId3v2Tag().getOrThrow()
        println(id3V22Tagpopm.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),0)
    }

    @TestCase
    func mp3agic_AlbumImage07(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        println(id3V22Tag.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),-1)
        id3V22Tag.setWmpRating(5)
        mp3File.save("../../HLT/save_popm_v23tagwithchapters.mp3")
        var mp3Filepopm: Mp3File = Mp3File("../../HLT/save_popm_v23tagwithchapters.mp3")
        var id3V22Tagpopm: ID3v2 = mp3Filepopm.getId3v2Tag().getOrThrow()
        println(id3V22Tagpopm.getWmpRating())
        @Assert(id3V22Tag.getWmpRating(),5)
    }
}
