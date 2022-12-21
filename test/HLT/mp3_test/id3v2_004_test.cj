// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/charset/build/charset
// data_file:tag_error_test.mp3
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
package test

from std import unittest.*
from std import unittest.testmacro.*
from std import fs.*
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import os.posix.*

// ID3v2Frame类验证
@Test
public class ID3V2TestC {
    // 组合测试:自己随便做一个标签,验证读取报错
    @TestCase
    func id3v2_test_06(): Unit {
        var buffer: Array<Int8> = loadFile("./tag_error_test.mp3")
        var flag = false

        try {
            var tagOption: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
        } catch (e: Exception) {
            println("id3v2_test_06 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
        flag = false
    }

    func loadFile(filename: String): Array<Int8> {
        return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
    }
}
