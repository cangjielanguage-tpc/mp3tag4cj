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
public class Mp3agic_Setid3v1 {
    public static var mp3File: Mp3File = Mp3File("saveqinggewang.mp3")
    public static var id3v1: ID3v1Tag = ID3v1Tag()
    public override func beforeEach(): Unit {}
    public override func afterEach(): Unit {}

    @Bench[300]
    @TestCase
    func testSetid3v1T300(): Unit {
        mp3File.setId3v1Tag(Option<ID3v1>.Some(id3v1))
    }
    /*
    
       @Bench[100]
       @TestCase
       func testSetid3v1T100(): Unit {
    
           mp3File.setId3v1Tag(Option<ID3v1>.Some(id3v1))
    
       }
    
    
       @Bench[10]
       @TestCase
       func testSetid3v1T10(): Unit {
    
           mp3File.setId3v1Tag(Option<ID3v1>.Some(id3v1))
    
       }
     */
}
