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
public class Mp3agic_ID3v1_006 {
    @TestCase
    func mp3agic_ID3v1_006(): Unit {
        var mp3File016: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置year大于字节长度
        var ID3V1016 = mp3File016.getId3v1Tag().getOrThrow()
        ID3V1016.setYear(Option<String>.Some("20222"))
        mp3File016.save("Yearv1tag.mp3")
        var mp3File017: Mp3File = Mp3File("Yearv1tag.mp3", 300, true)
        var ID3V1017 = mp3File017.getId3v1Tag().getOrThrow()
        @Assert(ID3V1017.getYear().toString(),"Some(2022)")

        var mp3File018: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置year小于字节长度
        var ID3V1018 = mp3File018.getId3v1Tag().getOrThrow()
        ID3V1018.setYear(Option<String>.Some("202"))
        mp3File018.save("Year1v1tag.mp3")
        var mp3File019: Mp3File = Mp3File("Year1v1tag.mp3", 300, true)
        var ID3V1019 = mp3File019.getId3v1Tag().getOrThrow()
        @Assert(ID3V1019.getYear().toString(),"Some(202)")

        var mp3File020: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置year字节为空
        var ID3V1020 = mp3File020.getId3v1Tag().getOrThrow()
        ID3V1020.setYear(Option<String>.Some(""))
        mp3File020.save("Year2v1tag.mp3")
        var mp3File021: Mp3File = Mp3File("Year2v1tag.mp3", 300, true)
        var ID3V1021 = mp3File021.getId3v1Tag().getOrThrow()
        @Assert(ID3V1021.getYear().toString(),"Some()")

        var a = """
TITLE
123456789012345678901234599999999"""
        println(a)
        var mp3Files: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Year为多行字符串
        var ID3V1s = mp3Files.getId3v1Tag().getOrThrow()
        ID3V1s.setYear(Option<String>.Some(a))
        mp3Files.save("Year3v1tag.mp3")
        var mp3Filed: Mp3File = Mp3File("Year3v1tag.mp3", 300, true)
        var ID3V1d = mp3Filed.getId3v1Tag().getOrThrow()
        var aa = """
TITL"""
        @Assert(ID3V1d.getYear(),aa)

        var b: String = ##"TITLE
123456789012345678901234
            "##
        var mp3Filef: Mp3File = Mp3File("v1tag.mp3", 300, true) //设置Year为多行原始字符串
        var ID3V1f = mp3Filef.getId3v1Tag().getOrThrow()
        ID3V1f.setYear(Option<String>.Some(b))
        mp3Filef.save("Year4v1tag.mp3")
        var mp3Fileg: Mp3File = Mp3File("Year4v1tag.mp3", 300, true)
        var ID3V1g = mp3Fileg.getId3v1Tag().getOrThrow()
        var bb: String = ##"TITL"##
        println(bb.size)
        @Assert(ID3V1g.getYear(),bb)
    }
}
