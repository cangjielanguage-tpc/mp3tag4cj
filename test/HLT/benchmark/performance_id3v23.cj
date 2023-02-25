// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v1tag.mp3
// data_file:./saveqinggewang.mp3
// data_file:./saveshuixingji.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import os.posix.*
from std import time.*
from std import math.*
from std import unittest.testmacro.*
from std import random.*
from okio import okio.*
from okio import nio.ByteBuffer

@Test
public class Mp3agic_Id3v23 {
    public static var bytes: Array<Int8> = [0x49, 0x44, 0x33, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]

    public override func beforeEach(): Unit {
        //mp3File=Mp3File("v1tag.mp3", 300, true)
    }
    public override func afterEach(): Unit {}

    @Bench[1000]
    @TestCase
    func testId3v23T300(): Unit {
        ID3v23Tag(bytes)
    }
    /*
       @Bench[100]
       @TestCase
       func testId3v23T100(): Unit {
    
           ID3v23Tag(bytes)
    
       }
       @Bench[10]
       @TestCase
       func testId3v23T10(): Unit {
    
           ID3v23Tag(bytes)
    
       }
     */
}
