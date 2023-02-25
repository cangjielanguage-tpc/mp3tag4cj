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

@Test
public class Mp3agic_Setid3v2 {
    public static var mp3File: Mp3File = Mp3File("saveqinggewang.mp3")
    public static var id3v2: ID3v24Tag = ID3v24Tag()

    //var newId3v24 = ID3v24Tag()
    public override func beforeEach(): Unit {}
    public override func afterEach(): Unit {}

    @Bench[2000]
    @TestCase
    func testSetid3v2T300(): Unit {
        mp3File.setId3v2Tag(Option<ID3v2>.Some(id3v2))
    }
    /*
       @Bench[100]
       @TestCase
       func testSetid3v2T100(): Unit {
    
           mp3File.setId3v2Tag(Option<ID3v2>.Some(id3v2))
    
       }
    
    
       @Bench[10]
       @TestCase
       func testSetid3v2T10(): Unit {
    
           mp3File.setId3v2Tag(Option<ID3v2>.Some(id3v2))
    
       }
     */
}
