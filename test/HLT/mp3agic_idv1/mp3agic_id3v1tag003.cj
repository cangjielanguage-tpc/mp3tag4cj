// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import os.posix.*

@Test
public class Mp3agic_ID3v1_003 {
    @TestCase
    func mp3agic_ID3v1_003(): Unit {
        var mp3File: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置title为空字符串
        var ID3V1 = mp3File.getId3v1Tag().getOrThrow()
        ID3V1.setTitle(Option<String>.Some(""))
        mp3File.save("../../mp3agic_idv1/title1v1tag.mp3")
        var mp3File01: Mp3File = Mp3File("../../mp3agic_idv1/title1v1tag.mp3", 300, true)
        var ID3V101 = mp3File01.getId3v1Tag().getOrThrow()
        @Assert(ID3V101.getTitle(),"")

        var mp3File02: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置title大于字节长度
        var ID3V102 = mp3File02.getId3v1Tag().getOrThrow()
        ID3V102.setTitle(Option<String>.Some("TITLE123456789012345678901234599999999"))
        mp3File02.save("../../mp3agic_idv1/title2v1tag.mp3")
        var mp3File03: Mp3File = Mp3File("../../mp3agic_idv1/title2v1tag.mp3", 300, true)
        var ID3V103 = mp3File03.getId3v1Tag().getOrThrow()
        @Assert(ID3V103.getTitle(),"TITLE1234567890123456789012345")

        var mp3File04: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置title小于字节长度
        var ID3V104 = mp3File04.getId3v1Tag().getOrThrow()
        ID3V104.setTitle(Option<String>.Some("TITLE1"))
        mp3File04.save("../../mp3agic_idv1/title3v1tag.mp3")
        var mp3File30: Mp3File = Mp3File("../../mp3agic_idv1/title3v1tag.mp3", 300, true)
        var ID3V130 = mp3File30.getId3v1Tag().getOrThrow()
        @Assert(ID3V130.getTitle(),"TITLE1")

        var a = """
TITLE
123456789012345678901234599999999"""
        var mp3File05: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置title为多行字符串
        var ID3V105 = mp3File05.getId3v1Tag().getOrThrow()
        ID3V105.setTitle(Option<String>.Some(a))
        mp3File05.save("../../mp3agic_idv1/title4v1tag.mp3")
        var mp3File40: Mp3File = Mp3File("../../mp3agic_idv1/title4v1tag.mp3", 300, true)
        var ID3V140 = mp3File40.getId3v1Tag().getOrThrow()
        var aa = """
TITLE
123456789012345678901234"""
        @Assert(ID3V140.getTitle(),aa)

        var b: String = ##"TITLE
123456789012345678901234
            "##
        var mp3File06: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置title为多行原始字符串
        var ID3V106 = mp3File06.getId3v1Tag().getOrThrow()
        ID3V106.setTitle(Option<String>.Some(b))
        mp3File06.save("../../mp3agic_idv1/title5v1tag.mp3")
        var mp3File41: Mp3File = Mp3File("../../mp3agic_idv1/title5v1tag.mp3", 300, true)
        var ID3V141 = mp3File41.getId3v1Tag().getOrThrow()
        var bb: String = ##"TITLE
123456789012345678901234"##
        @Assert(ID3V141.getTitle(),bb)
    }
}
