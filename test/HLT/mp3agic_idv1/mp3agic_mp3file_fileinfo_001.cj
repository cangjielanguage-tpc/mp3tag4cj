// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*

@Test
public class Mp3agic_FileInfo_001 {
    @TestCase
    func mp3agic_FileInfo_001(): Unit {
        var file = FileInfo("v1tag.mp3") //以正确格式fileinfo构造
        var file1 = Mp3File(file)
        @Assert(file1.hasId3v1Tag(),true)

        try {
            var filef1 = FileInfo("v1ta.mp3") //以错误格式fileinfo构造
            var filef2 = Mp3File(filef1)
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
        try {
            var filef3 = FileInfo(" ") //以空字符串fileinfo构造
            var filef4 = Mp3File(filef3)
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
        try {
            var filef5 = FileInfo("v1tag.mp3") //以fileinfo构造小于40长度
            var filef6 = Mp3File(filef5, 30)
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: Buffer too small")
        }
        var file4 = FileInfo("v1tag.mp3") //以fileinfo构造大于40长度
        var file5 = Mp3File(file4, 41)
        @Assert(file5.hasId3v1Tag(),true)

        var file6 = FileInfo("v1tag.mp3") //以fileinfo构造长度等于文件大小
        var file7 = Mp3File(file6, 2997)
        @Assert(file7.hasId3v1Tag(),true)

        var file8 = FileInfo("v1tag.mp3") //以fileinfo构造长度大于文件大小
        var file9 = Mp3File(file8, 2997)
        @Assert(file9.hasId3v1Tag(),true)
    }
}
