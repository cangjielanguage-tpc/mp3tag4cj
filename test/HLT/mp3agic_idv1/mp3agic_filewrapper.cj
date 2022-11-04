// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import os.posix.*

//public init (filename: String)
//public open func getFilename (): String
//public open func getLength (): Int64
@Test
public class Mp3agic_FileWrapper {
    @TestCase
    func mp3agicFileWrapper(): Unit {
        var path: String = getcwd()
        println(path)
        let fileWrapper: FileWrapper = FileWrapper("v1tag.mp3") //正确的构造
        @Assert(fileWrapper.getLength(),2997)

        try {
            let fileWrapper: FileWrapper = FileWrapper("v1ta.mp3") //错误的路径构造
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
        try {
            let fileWrapper: FileWrapper = FileWrapper("") //空路径构造
        } catch (e: Exception) {
            @Assert(e.toString(),"FSException: The `path` is invalid!")
        }
    }
}
