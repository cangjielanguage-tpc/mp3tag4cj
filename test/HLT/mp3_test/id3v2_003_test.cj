// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/charset/build/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:剑网3-当战.mp3
// data_file:notanmp3.mp3
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

// ID3v2Frame类验证:换一个MP3文件
@Test
public class ID3V2TestC {
    var basePath: String = getcwd()

    // 组合测试:正常读取一个MP3文件,比对标签的具体数据
    @TestCase
    func id3v2_test_05(): Unit {
        var buffer: Array<Int8> = loadFile("./剑网3-当战.mp3")
        var tagOption: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
        match (tagOption) {
            case Some(x) =>
                var id3v2Frame: HashMap<String, ID3v2FrameSet> = checkTag(x)
                @Assert(id3v2Frame.size, 8)
                for ((k, v) in id3v2Frame) {
                    println("")
                    println("id3v2Frame start =======>")
                    println("id3v2FrameMap key =======> ${k}")
                    println("id3v2FrameMap val =======> ${v.toString()}")
                    for (f in v.getFrames()) {
                        println("id3v2Frame getId val =======> ${f.getId()}")
                        println("id3v2Frame getDataLength val =======> ${f.getDataLength()}")
                        println("id3v2Frame getLength val =======> ${f.getLength()}")
                        println("id3v2Frame getData val =======> ${f.getData()}")
                        println("id3v2Frame hasDataLengthIndicator val =======> ${f.hasDataLengthIndicator()}")
                        println("id3v2Frame hasCompression val =======> ${f.hasCompression()}")
                        println("id3v2Frame hasEncryption val =======> ${f.hasEncryption()}")
                        println("id3v2Frame hasGroup val =======> ${f.hasGroup()}")
                        println("id3v2Frame hasPreserveFile val =======> ${f.hasPreserveFile()}")
                        println("id3v2Frame hasPreserveTag val =======> ${f.hasPreserveTag()}")
                        println("id3v2Frame hasUnsynchronisation val =======> ${f.hasUnsynchronisation()}")
                        println("id3v2Frame isReadOnly val =======> ${f.isReadOnly()}")
                    }
                    println("id3v2Frame end =======>")
                    println("")
                }
            case None => @Assert(false)
        }
    }

    func checkTag(id3v23: AbstractID3v2Tag): HashMap<String, ID3v2FrameSet> {
        var id3v2Frame: HashMap<String, ID3v2FrameSet> = HashMap<String, ID3v2FrameSet>()
        match (id3v23 as ID3v23Tag) {
            case Some(x) =>
                println("id3v23 getDataLength ==> ${x.getDataLength()}")
                println("id3v23 getLength ==> ${x.getLength()}")
                println("id3v23 hasUnsynchronisation ==> ${x.hasUnsynchronisation()}")

                if (Int64(x.getDataLength()) != 484631) { // 去掉标签头的10位的长度
                    return id3v2Frame
                }
                if (Int64(x.getLength()) != 484641) { // 完整标签的长度
                    return id3v2Frame
                }
                id3v2Frame = x.getFrameSets()
                println("id3v2FrameMap.size =======> ${id3v2Frame.size}")
            case None => return id3v2Frame
        }
        return id3v2Frame
    }

    func loadFile(filename: String): Array<Int8> {
        return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
    }
}
