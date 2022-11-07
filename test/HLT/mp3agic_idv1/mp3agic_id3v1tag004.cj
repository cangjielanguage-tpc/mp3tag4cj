// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_ID3v1_004 {
    @TestCase
    func mp3agic_ID3v1_004(): Unit {
        var mp3File05: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Artist大于字节长度
        var ID3V105 = mp3File05.getId3v1Tag().getOrThrow()
        ID3V105.setArtist(Option<String>.Some("ARTIST12345678901234567890123499999"))
        mp3File05.save("Artistv1tag.mp3")
        var mp3File06: Mp3File = Mp3File("Artistv1tag.mp3", 300, true)
        var ID3V106 = mp3File06.getId3v1Tag().getOrThrow()
        @Assert(ID3V106.getArtist(),"ARTIST123456789012345678901234")

        var mp3File07: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Artist小于字节长度
        var ID3V107 = mp3File07.getId3v1Tag().getOrThrow()
        ID3V107.setArtist(Option<String>.Some("ARTIST1234"))
        mp3File07.save("Artist1v1tag.mp3")
        var mp3File08: Mp3File = Mp3File("Artist1v1tag.mp3", 300, true)
        var ID3V108 = mp3File08.getId3v1Tag().getOrThrow()
        @Assert(ID3V108.getArtist(),"ARTIST1234")

        var mp3File09: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Artist字节长度为空
        var ID3V109 = mp3File09.getId3v1Tag().getOrThrow()
        ID3V109.setArtist(Option<String>.Some(""))
        mp3File09.save("Artist2v1tag.mp3")
        var mp3File010: Mp3File = Mp3File("Artist2v1tag.mp3", 300, true)
        var ID3V1010 = mp3File010.getId3v1Tag().getOrThrow()
        @Assert(ID3V1010.getArtist(),"")

        var a = """
TITLE
123456789012345678901234599999999"""
        println(a)
        var mp3Files: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Artist为多行字符串
        var ID3V1s = mp3Files.getId3v1Tag().getOrThrow()
        ID3V1s.setArtist(Option<String>.Some(a))
        mp3Files.save("Artist3v1tag.mp3")
        var mp3Filed: Mp3File = Mp3File("Artist3v1tag.mp3", 300, true)
        var ID3V1d = mp3Filed.getId3v1Tag().getOrThrow()
        var aa = """
TITLE
123456789012345678901234"""
        @Assert(ID3V1d.getArtist(),aa)

        var b: String = ##"TITLE
123456789012345678901234
            "##
        var mp3Filef: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Artist为多行原始字符串
        var ID3V1f = mp3Filef.getId3v1Tag().getOrThrow()
        ID3V1f.setArtist(Option<String>.Some(b))
        mp3Filef.save("Artist4v1tag.mp3")
        var mp3Fileg: Mp3File = Mp3File("Artist4v1tag.mp3", 300, true)
        var ID3V1g = mp3Fileg.getId3v1Tag().getOrThrow()
        var bb: String = ##"TITLE
123456789012345678901234"##
        println(bb.size)
        @Assert(ID3V1g.getArtist(),bb)
    }
}
