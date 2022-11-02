// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_ID3v1_007 {
    @TestCase
    func mp3agic_ID3v1_007(): Unit {
        var mp3File022: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Comment大于字节长度
        var ID3V1022 = mp3File022.getId3v1Tag().getOrThrow()
        ID3V1022.setComment(Option<String>.Some("COMMENT12345678901234567890199999999"))
        mp3File022.save("../../mp3agic_idv1/Commentv1tag.mp3")
        var mp3File023: Mp3File = Mp3File("../../mp3agic_idv1/Commentv1tag.mp3", 300, true)
        var ID3V1023 = mp3File023.getId3v1Tag().getOrThrow()
        @Assert(ID3V1023.getComment(),"COMMENT123456789012345678901")

        var mp3File024: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Comment小于字节长度
        var ID3V1024 = mp3File024.getId3v1Tag().getOrThrow()
        ID3V1024.setComment(Option<String>.Some("COMMENT123456789"))
        mp3File024.save("../../mp3agic_idv1/Comment1v1tag.mp3")
        var mp3File025: Mp3File = Mp3File("../../mp3agic_idv1/Comment1v1tag.mp3", 300, true)
        var ID3V1025 = mp3File025.getId3v1Tag().getOrThrow()
        @Assert(ID3V1025.getComment(),"COMMENT123456789")

        var mp3File026: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Comment字节为空
        var ID3V1026 = mp3File026.getId3v1Tag().getOrThrow()
        ID3V1026.setComment(Option<String>.Some(""))
        mp3File026.save("../../mp3agic_idv1/Comment2v1tag.mp3")
        var mp3File027: Mp3File = Mp3File("../../mp3agic_idv1/Comment2v1tag.mp3", 300, true)
        var ID3V1027 = mp3File027.getId3v1Tag().getOrThrow()
        @Assert(ID3V1027.getComment().toString(),"Some()")

        var a = """
TITLE
123456789012345678901234599999999"""
        println(a)
        var mp3Files: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Comment为多行字符串
        var ID3V1s = mp3Files.getId3v1Tag().getOrThrow()
        ID3V1s.setComment(Option<String>.Some(a))
        mp3Files.save("../../mp3agic_idv1/Comment3v1tag.mp3")
        var mp3Filed: Mp3File = Mp3File("../../mp3agic_idv1/Comment3v1tag.mp3", 300, true)
        var ID3V1d = mp3Filed.getId3v1Tag().getOrThrow()
        var aa = """
TITLE
1234567890123456789012"""
        @Assert(ID3V1d.getComment(),aa)

        var b: String = ##"TITLE
123456789012345678901234
            "##
        var mp3Filef: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Comment为多行原始字符串
        var ID3V1f = mp3Filef.getId3v1Tag().getOrThrow()
        ID3V1f.setComment(Option<String>.Some(b))
        mp3Filef.save("../../mp3agic_idv1/Comment4v1tag.mp3")
        var mp3Fileg: Mp3File = Mp3File("../../mp3agic_idv1/Comment4v1tag.mp3", 300, true)
        var ID3V1g = mp3Fileg.getId3v1Tag().getOrThrow()
        var bb: String = ##"TITLE
1234567890123456789012"##
        println(bb.size)
        @Assert(ID3V1g.getComment(),bb)
    }
}
