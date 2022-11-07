// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import os.posix.*
from std import fs.*

//public init (file: FileInfo)
//public open func getFilename (): String
//public open func getLength (): Int64
@Test
public class Mp3agic_FileInfo {
    @TestCase
    func mp3agic_FileInfo(): Unit {
        var file = FileInfo("v1tag.mp3")    //fileinfo正确路径构造                       
        let fileWrapper1: FileWrapper = FileWrapper(file)
        @Assert(fileWrapper1.getLength(),2997)

        try { //fileinfo错误路径构造             
            var file = FileInfo("v1ta.mp3")
            let fileWrapper: FileWrapper = FileWrapper(file)
            @Assert(fileWrapper.getLength(),2997)
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
        try { //fileinfo空路径构造
            var file = FileInfo("")
            let fileWrapper3: FileWrapper = FileWrapper(file)
            @Assert(fileWrapper3.getLength(),2997)
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
    }
}
