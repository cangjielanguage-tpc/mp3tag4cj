// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v24tagswithalbumimage.mp3
// data_file:./v1tag.mp3
// data_file:./saveqinggewang.mp3
// data_file:./saveshuixingji.mp3
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import time.*
from std import math.*
from std import unittest.testmacro.*
from std import random.*
from okio import okio.*
from okio import nio.ByteBuffer

@Test
public class Mp3agic_Creattag {
    //v24tagswithalbumimage
    public static var buffer: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("v24tagswithalbumimage.mp3"))

    public override func beforeEach(): Unit {}
    public override func afterEach(): Unit {}

    @Bench[1000]
    @TestCase
    func testCreattagT300(): Unit {
        ID3v2TagFactory.createTag(buffer)
    }
    /*
       @Bench[100]
       @TestCase
       func testCreattagT100(): Unit {
    
           ID3v2TagFactory.createTag(buffer)
    
       }
    
       @Bench[10]
       @TestCase
       func testCreattagT10(): Unit {
    
           ID3v2TagFactory.createTag(buffer)
    
       }
     */
}
