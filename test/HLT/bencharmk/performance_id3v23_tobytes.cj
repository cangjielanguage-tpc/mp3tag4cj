// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
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
public class Mp3agic_Tobytes {
    public static var mp3File: Mp3File = Mp3File("v1tag.mp3")
    public static var ID3V1 = mp3File.getId3v1Tag().getOrThrow()
    public override func beforeEach(): Unit {
        //var mp3File: Mp3File = Mp3File("qinggewang.mp3")
        //var ID3V1 = mp3File.getId3v1Tag().getOrThrow()
        //mp3File=Mp3File("v1tag.mp3", 300, true)
    }
    public override func afterEach(): Unit {}

    @Bench[3000]
    @TestCase
    func testTobytesT300(): Unit {
        ID3V1.toBytes()
    }
    /*
       @Bench[2]
       @TestCase
       func testTobytesT100(): Unit {
    
           //ID3V1.toBytes()
    
       }
    
       @Bench[10]
       @TestCase
       func testTobytesT10(): Unit {
    
           //ID3V1.toBytes()
    
       }
     */
}
