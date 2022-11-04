// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_ID3v1_005 {
    @TestCase
    func mp3agic_ID3v1_005(): Unit {
        var mp3File0111: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Album大于字节长度
        var ID3V1011 = mp3File0111.getId3v1Tag().getOrThrow()
        ID3V1011.setAlbum(Option<String>.Some("ALBUM12345678901234567890123459999999999"))
        mp3File0111.save("Albumv1tag.mp3")
        var mp3File012: Mp3File = Mp3File("Albumv1tag.mp3", 300, true)
        var ID3V1012 = mp3File012.getId3v1Tag().getOrThrow()
        @Assert(ID3V1012.getAlbum(),"ALBUM1234567890123456789012345")

        var mp3File013: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Album小于字节长度
        var ID3V1013 = mp3File013.getId3v1Tag().getOrThrow()
        ID3V1013.setAlbum(Option<String>.Some("ALBUM123456789"))
        mp3File013.save("Album1v1tag.mp3")
        var mp3File014: Mp3File = Mp3File("Album1v1tag.mp3", 300, true)
        var ID3V1014 = mp3File014.getId3v1Tag().getOrThrow()
        @Assert(ID3V1014.getAlbum(),"ALBUM123456789")

        var mp3File015: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Album字节长度为空
        var ID3V1015 = mp3File015.getId3v1Tag().getOrThrow()
        ID3V1015.setAlbum(Option<String>.Some(""))
        mp3File015.save("Album2v1tag.mp3")
        var mp3File0160: Mp3File = Mp3File("Album2v1tag.mp3", 300, true)
        var ID3V10160 = mp3File0160.getId3v1Tag().getOrThrow()
        @Assert(ID3V10160.getAlbum(),"")

        var a = """
TITLE
123456789012345678901234599999999"""
        println(a)
        var mp3Files: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Album为多行字符串
        var ID3V1s = mp3Files.getId3v1Tag().getOrThrow()
        ID3V1s.setAlbum(Option<String>.Some(a))
        mp3Files.save("Album3tag.mp3")
        var mp3Filed: Mp3File = Mp3File("Album3tag.mp3", 300, true)
        var ID3V1d = mp3Filed.getId3v1Tag().getOrThrow()
        var aa = """
TITLE
123456789012345678901234"""
        @Assert(ID3V1d.getAlbum(),aa)

        var b: String = ##"TITLE
123456789012345678901234
            "##
        var mp3Filef: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Album为多行原始字符串
        var ID3V1f = mp3Filef.getId3v1Tag().getOrThrow()
        ID3V1f.setAlbum(Option<String>.Some(b))
        mp3Filef.save("Album4v1tag.mp3")
        var mp3Fileg: Mp3File = Mp3File("Album4v1tag.mp3", 300, true)
        var ID3V1g = mp3Fileg.getId3v1Tag().getOrThrow()
        var bb: String = ##"TITLE
123456789012345678901234"##
        println(bb.size)
        @Assert(ID3V1g.getAlbum(),bb)
    }
}
