// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_ID3v1_008 {
    @TestCase
    func mp3agic_ID3v1_008(): Unit {
        var mp3File028: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Genre大于字节长度
        var ID3V1028 = mp3File028.getId3v1Tag().getOrThrow()
        ID3V1028.setGenre(Option<Int64>.Some(147))
        mp3File028.save("../../mp3agic_idv1/Genrev1tag.mp3")
        var mp3File029: Mp3File = Mp3File("../../mp3agic_idv1/Genrev1tag.mp3", 300, true)
        var ID3V1029 = mp3File029.getId3v1Tag().getOrThrow()
        @Assert(ID3V1029.getGenre(),147)

        var mp3File030: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Genre最小风格编号
        var ID3V1030 = mp3File030.getId3v1Tag().getOrThrow()
        ID3V1030.setGenre(Option<Int64>.Some(0))
        mp3File030.save("../../mp3agic_idv1/Genre1v1tag.mp3")
        var mp3File031: Mp3File = Mp3File("../../mp3agic_idv1/Genre1v1tag.mp3", 300, true)
        var ID3V1031 = mp3File031.getId3v1Tag().getOrThrow()
        @Assert(ID3V1031.getGenre(),0)

        var mp3File032: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Genre字节最大风格编号
        var ID3V1032 = mp3File032.getId3v1Tag().getOrThrow()
        ID3V1032.setGenre(Option<Int64>.Some(147))
        mp3File032.save("../../mp3agic_idv1/Genre2v1tag.mp3")
        var mp3File033: Mp3File = Mp3File("../../mp3agic_idv1/Genre2v1tag.mp3", 300, true)
        var ID3V1033 = mp3File033.getId3v1Tag().getOrThrow()
        @Assert(ID3V1033.getGenre(),147)

        var mp3File034: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Genre字节大于最大风格编号
        var ID3V1034 = mp3File034.getId3v1Tag().getOrThrow()
        ID3V1034.setGenre(Option<Int64>.Some(991))
        mp3File034.save("../../mp3agic_idv1/Genre3v1tag.mp3")
        var mp3File035: Mp3File = Mp3File("../../mp3agic_idv1/Genre3v1tag.mp3", 300, true)
        var ID3V1035 = mp3File035.getId3v1Tag().getOrThrow()
        @Assert(ID3V1035.getGenre(),223)

        var mp3File036: Mp3File = Mp3File("../../mp3agic_idv1/v1tag.mp3", 300, true) //设置Genre字节小于最小风格编号
        var ID3V1036 = mp3File036.getId3v1Tag().getOrThrow()
        ID3V1036.setGenre(Option<Int64>.Some(-256))
        mp3File036.save("../../mp3agic_idv1/Genre4v1tag.mp3")
        var mp3File037: Mp3File = Mp3File("../../mp3agic_idv1/Genre4v1tag.mp3", 300, true)
        var ID3V1037 = mp3File037.getId3v1Tag().getOrThrow()
        @Assert(ID3V1037.getGenre(),0)
    }
}
