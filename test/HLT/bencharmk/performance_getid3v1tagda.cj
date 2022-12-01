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
public class Mp3agic_Getid3v1 {
    //v1tag
    public static var mp3File: Mp3File = Mp3File("saveqinggewang.mp3")
    public override func beforeEach(): Unit {
        //mp3File=Mp3File("v1tag.mp3")
    }
    public override func afterEach(): Unit {}

    @Bench[1000]
    @TestCase
    func testGetid3v1T300(): Unit {
        mp3File.getId3v1Tag()
    }
    /*
       @Bench[100]
       @TestCase
       func testGetid3v1T100(): Unit {
           mp3File.getId3v1Tag()
       }
    
    
       @Bench[10]
       @TestCase
       func testGetid3v1T10(): Unit {
           mp3File.getId3v1Tag()
       }
     */
}
