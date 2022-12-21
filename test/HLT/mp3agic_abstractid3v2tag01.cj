// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v1andv23tagswithalbumimage.mp3
// data_file:./qinggewang.mp3
// data_file:./v1tag.mp3
// data_file:./id3v1.jpeg 
// data_file:./16pic_25.png
// data_file:./id3v11.gif  
// data_file:./shuixingji.mp3 
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import math.*

@Test
public class Mp3agic_AlbumImage {

    @TestCase
    func mp3agic_AlbumImage(): Unit {
    var expt2: Array<Int8> = [-119, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, -56, 0, 0, 0, -56, 8, 3, 0, 0, 0, -102, -122, 94, -84, 0, 0, 0,
                        4, 103, 65, 77, 65, 0, 0, -100, 64, 32, 13, -28, -53, 0, 0, 3, 0, 80, 76, 84, 69, -1, -1, -1, -1, -1, -52, -1, -1, -103, -1, -1, 102, -1,
                       -1, 51, -1, -1, 0, -1, -52, -1, -1, -52, -52, -1, -52, -103, -1, -52, 102, -1, -52, 51, -1, -52, 0, -1, -103, -1, -1, -103, -52, -1, -103,
                       -103, -1, -103, 102, -1, -103, 51, -1, -103, 0, -1, 102, -1, -1, 102, -52, -1, 102, -103, -1, 102, 102, -1, 102, 51, -1, 102, 0, -1, 51, 
                       -1, -1, 51, -52, -1, 51, -103, -1, 51, 102, -1, 51, 51, -1, 51, 0, -1, 0, -1, -1, 0, -52, -1, 0, -103, -1, 0, 102, -1, 0, 51, -1, 0, 0, 
                       -52, -1, -1, -52, -1, -52, -52, -1, -103, -52, -1, 102, -52, -1, 51, -52, -1, 0, -52, -52, -1, -52, -52, -52, -52, -52, -103, -52, -52,
                        102, -52, -52, 51, -52, -52, 0, -52, -103, -1, -52, -103, -52, -52, -103, -103, -52, -103, 102, -52, -103, 51, -52, -103, 0, -52, 102, 
                       -1, -52, 102, -52, -52, 102, -103, -52, 102, 102, -52, 102, 51, -52, 102, 0, -52, 51, -1, -52, 51, -52, -52, 51, -103, -52, 51, 102, -52,
                       51, 51, -52, 51, 0, -52, 0, -1, -52, 0, -52, -52, 0, -103, -52, 0, 102, -52, 0, 51, -52, 0, 0, -103, -1, -1, -103, -1, -52, -103, -1, -103,
                       -103, -1, 102, -103, -1, 51, -103, -1, 0, -103, -52, -1, -103, -52, -52, -103, -52, -103, -103, -52, 102, -103, -52, 51, -103, -52, 0, -103, 
                       -103, -1, -103, -103, -52, -103, -103, -103, -103, -103, 102, -103, -103, 51, -103, -103, 0, -103, 102, -1, -103, 102, -52, -103, 102, -103, 
                       -103, 102, 102, -103, 102, 51, -103, 102, 0, -103, 51, -1, -103, 51, -52, -103, 51, -103, -103, 51, 102, -103, 51, 51, -103, 51, 0, -103, 0,
                       -1, -103, 0, -52, -103, 0, -103, -103, 0, 102, -103, 0, 51, -103, 0, 0, 102, -1, -1, 102, -1, -52, 102, -1, -103, 102, -1, 102, 102, -1, 51,
                       102, -1, 0, 102, -52, -1, 102, -52, -52, 102, -52, -103, 102, -52, 102, 102, -52, 51, 102, -52, 0, 102, -103, -1, 102, -103, -52, 102, -103,
                       -103, 102, -103, 102, 102, -103, 51, 102, -103, 0, 102, 102, -1, 102, 102, -52, 102, 102, -103, 102, 102, 102, 102, 102, 51, 102, 102, 0, 102, 
                       51, -1, 102, 51, -52, 102, 51, -103, 102, 51, 102, 102, 51, 51, 102, 51, 0, 102, 0, -1, 102, 0, -52, 102, 0, -103, 102, 0, 102, 102, 0, 51, 102,
                       0, 0, 51, -1, -1, 51, -1, -52, 51, -1, -103, 51, -1, 102, 51, -1, 51, 51, -1, 0, 51, -52, -1, 51, -52, -52, 51, -52, -103, 51, -52, 102, 51, -52, 
                       51, 51, -52, 0, 51, -103, -1, 51, -103, -52, 51, -103, -103, 51, -103, 102, 51, -103, 51, 51, -103, 0, 51, 102, -1, 51, 102, -52, 51, 102, -103, 
                       51, 102, 102, 51, 102, 51, 51, 102, 0, 51, 51, -1, 51, 51, -52, 51, 51, -103, 51, 51, 102, 51, 51, 51, 51, 51, 0, 51, 0, -1, 51, 0, -52, 51, 0,
                       -103, 51, 0, 102, 51, 0, 51, 51, 0, 0, 0, -1, -1, 0, -1, -52, 0, -1, -103, 0, -1, 102, 0, -1, 51, 0, -1, 0, 0, -52, -1, 0, -52, -52, 0, -52, -103,
                       0, -52, 102, 0, -52, 51, 0, -52, 0, 0, -103, -1, 0, -103, -52, 0, -103, -103, 0, -103, 102, 0, -103, 51, 0, -103, 0, 0, 102, -1, 0, 102, -52, 0, 
                       102, -103, 0, 102, 102, 0, 102, 51, 0, 102, 0, 0, 51, -1, 0, 51, -52, 0, 51, -103, 0, 51, 102, 0, 51, 51, 0, 51, 0, 0, 0, -1, 0, 0, -52, 0, 0, 
                       -103, 0, 0, 102, 0, 0, 51, -18, 0, 0, -35, 0, 0, -69, 0, 0, -86, 0, 0, -120, 0, 0, 119, 0, 0, 85, 0, 0, 68, 0, 0, 34, 0, 0, 17, 0, 0, 0, -18, 0,
                       0, -35, 0, 0, -69, 0, 0, -86, 0, 0, -120, 0, 0, 119, 0, 0, 85, 0, 0, 68, 0, 0, 34, 0, 0, 17, 0, 0, 0, -18, 0, 0, -35, 0, 0, -69, 0, 0, -86, 0,
                       0, -120, 0, 0, 119, 0, 0, 85, 0, 0, 68, 0, 0, 34, 0, 0, 17, -18, -18, -18, -35, -35, -35, -69, -69, -69, -86, -86, -86, -120, -120, -120, 119, 
                       119, 119, 85, 85, 85, 68, 68, 68, 34, 34, 34, 17, 17, 17, 0, 0, 0, -5, 8, -126, -103, 0, 0, 0, 9, 112, 72, 89, 115, 0, 0, 11, 18, 0, 0, 11, 18, 
                       1, -46, -35, 126, -4, 0, 0, 0, 33, 116, 69, 88, 116, 83, 111, 102, 116, 119, 97, 114, 101, 0, 81, 117, 105, 99, 107, 84, 105, 109, 101, 32, 55, 
                       46, 49, 46,51, 32, 40, 87, 105, 110, 51, 50, 41, 0, -103, -7, 61, -11, 0, 0, 0, 7, 116, 73, 77, 69, 7, -42, 11, 11, 0, 52, 42, -56, -13, -39, -93,
                       0, 0, 3, -77, 73, 68,65, 84, 120, -100, -19, -35, -39, 113, -29, 64, 12, 4, 80, -27, -78, -7, 7, -96, 52, -100, 16, -74, 76, 107, -67, 18, 57, 3, 
                       -30, 6, -119, 65, -1, 106, -54, -18, 87, 62, 36, 91, 36, -16, 120, -102, 7, -50, 99, -1, 73, -97, 15, -45, -113, 70, 48, 120, 105, -20, 32, 44, 
                       -124, 61, -58, 8, 34, 82, -104, 90, 44, 32, 10, -123, -99, 69, 13, 81, 43, -116, 44, 58, -120, -111, -62, -62, -94, -127, -104, 50, -76, 20, 57, 
                       -60, -100, -95, -93, 72, 33, 46, 12, 13, 69, 6, 113, 99, -56, 41, 18, -120, 43, 67, 74, -31, 67, -36, 25, 50, 10, 23, 18, -62, -112, 80, -104, -112, 
                       48, 7, 91, -62, -126, 4, 50, -40, 20, 14, 36, -40, -63, -109, -48, 33, -31, 12, 30, -123, 12, 73, 113, 48, 36, 84, 72, -110, -125, 46, -95, 65, -46, 
                       24, 116, 10, 9, -110, -22, 32, 74, 40, -112, 100, 7, 77, 66, -128, 100, 51, -128, 36, 57, -121, 100, 35, -74, -24, 33, -39, -126, -33, 40, 33, -39, 
                       -11, -33, -94, -126, 100, -105, -1, -120, 2, -14, -91, -53, -97, 125, -108, 31, 79, 12, 1, 59, -126, 9, 7, -3, -102, 32, 16, -112, 65, 80, -124, 10, 
                       -125, 126, 119, -51, 33, 32, -128, -112, 16, 98, 12, -6, 115, 98, 9, 97, 49, 4, 20, 25, 4, -104, 16, -74, -126, 111, 65, 127, 117, -51, 32, -64, -125,
                        8, 25, 60, 10, -6, 75, 120, 2, 1, 22, 68, -63, -32, 80, -48, -89, -109, 49, 4, 56, 16, 37, -125, 78, 65, -97, 24, -121, 16, 96, 64, 12, 24, 84, 10, 
                        -6, 20, -81, -124, 24, 49, 104, 20, 54, 4, -56, 16, 67, 7, 65, -126, -66, -22, 26, 64, -128, 10, 49, 101, 16, 40, -24, -21, -57, 35, 4, -88, 16, 115,
                       -57, -103, 4, 125, 37, 44, -122, 56, 48, -50, 40, 60, 8, -48, 32, 78, 14, 84, 2, -104, 100, 15, 1, 26, -60, -51, -127, 73, 0, -109, -56, 32, -114, 14, 
                       68, -62, -127, 0, 9, -30, -22, -104, 75, 0, -109, 60, 16, -57, 4, -30, -52, -104, 83, 0, -109, -16, 33, 1, -114, -119, -124, 14, 1, 2, 36, -60, 49, -106,
                       -20, -21, -87, 32, 65, -114, -95, -124, 12, -39, 31, -68, 58, 4, 20, -112, 48, -57, 72, 66, -123, 28, -50, 29, 33, -127, -114, -127, -28, 88, 80, 10, 9,
                       117, 28, 37, 68, -56, -15, -40, 30, 18, -20, 56, 72, 6, 13, 69, -112, 112, -57, 94, 66, -125, 12, 78, -35, 0, 2, 2, 72, -126, 99, 39, 33, 65, 70, -121,
                       32, -35, -15, 41, 25, 118, -84, 10, 25, -98, -127, 124, -57, -121, 100, 92, -110, 7, 73, 115, -68, 75, 86, -126, -116, -113, -64, 21, 28, 111, -110, 73,
                       -53, 21, 33, -87, -114, -1, -110, 115, -56, -28, -60, 77, 32, 64, -122, 36, 59, 126, 37, -21, 64, 102, 7, -32, 34, -114, 127, -110, 105, -49, -59, 32, 
                       -39, -120, 45, 36, -56, -12, -15, -37, 64, 96, 41, 72, 54, -31, -107, -107, 32, -13, -121, -31, 58, -114, 77, -126, 52, 109, 72, 124, 26, -14, 3, -55, 
                       -82, -1, -106, 51, 8, -14, -24, -115, 32, -48, -112, -8, -88, 32, -39, -27, 63, -46, -112, -122, 56, 101, 13, 8, -84, 1, -55, -82, -66, 75, 67, 26, -30, 
                       -108, -122, 52, -60, 41, 13, 105, -120, 83, 26, -46, 16, -89, 52, -92, 33, 78, 105, 72, -99, -65, 16, 27, -30, -110, 53, -2, -117, -46, -112, -124, -12, 
                        127, -29, 27, -30, -109, 51, 72, -103, -9, 16, 23, 121, 87, -73, 33, -26, 89, 8, 82, -26, -22, -96, 85, 32, -41, -112, -84, 117, 41, 96, -103, -85, 76, 87,
                        -71, -18, -9, 70, -112, 50, -41, -58, 47, 3, -55, -106, 124, -111, 33, 101, -18, -24, 89, -26, 30, -85, -5, 64, -54, -36, -121, -72, 14, -28, 54, -9, -22,
                        -106, -71, 123, -70, 14, -92, -52, -124, -127, 58, 51, 31, -54, 76, -31, -88, 51, 23, -91, -52, -92, -102, 58, -77, -125, -54, 76, 115, -86, 51, 95, -85, 
                        -52, -60, -77, 58, 51, -24, -54, 76, 5, -84, 51, -89, -79, -52, -28, -52, 58, -77, 76, -21, 76, -105, 45, 51, -17, -73, -50, 4, -26, 58, 51, -79, -53, 76,
                        41, -81, 51, 55, -66, -50, 36, -1, 58, -69, 21, -54, 108, -69, -88, -77, 127, -92, -50, 70, -104, 58, 59, 122, -22, 108, 77, -86, -77, -57, -86, -52, 102,
                        -79, 58, -69, -34, -22, 108, -33, -85, -77, 15, -15, 82, 18, -68, -24, 50, 59, 67, -81, 66, 57, 109, -71, -46, 94, -35, 11, 72, 8, 29, -41, -38, 61, 93,
                        103, 27, 120, 38, -123, -40, -113, 12, -55, -110, 80, -21, -47, 33, 57, 18, 114, 59, 6, 36, -127, -62, -24, -58, -126, 68, 75, 56, -43, 120, -112, 80, 
                        10, -81, 24, 23, 18, 39, 97, -10, 98, 67, -126, 40, -20, 86, 2, 72, 0, 69, -48, 73, 4, 113, -90, -120, 26, 9, 33, -114, 20, 97, 31, 49, -60, -119, 34, 110, -93, 
                        -128, 56, 80, 20, 93, 84, 16, 99, -118, -86, -119, 18, 98, 103, -47, -42, -48, 67, 44, 44, 6, 29, 76, 32, 79, -107, -59, -90, -128, 21, -28, 41, -76, -104, 125,
                        118, 67, -56, 119, -110, 16, -33, -79, -123, 108, 9, 55, 108, 113, -128, -68, 18, 37, 120, -27, 47, -40, 73, -25, 66, 101, -23, 27, -98, 0, 0, 0, 0, 73, 69, 78, 
                        68, -82, 66, 96, -126]
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V2Tag = mp3File.getId3v2Tag().getOrThrow()
        println(id3V2Tag.getAlbumImage())
        @Assert(id3V2Tag.getAlbumImage(),expt2)
        println(id3V2Tag.getAlbumImageMimeType())
        @Assert(id3V2Tag.getAlbumImageMimeType().toString(),"Some(image/png)")
  
    }

    @TestCase
    func mp3agic_AlbumImage01(): Unit {
        try{
        var mp3File: Mp3File = Mp3File("../../HLT/v1tag.mp3")       
        var id3V2Tag = mp3File.getId3v2Tag().getOrThrow()
        println(id3V2Tag.getAlbumImage())
        println(id3V2Tag.getAlbumImageMimeType())
    } catch (e: Exception) {
    @Assert(e.toString(),"NoneValueException")
    }
    }





    @TestCase
    func mp3agic_AlbumImage02(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v1.jpeg"))
        //var expimgDataSrc = loadFile("../../HLT/id3v1.jpeg")
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //var id3v2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as  AbstractID3v2Tag).getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "testMimeType123")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"testMimeType123")
    }


    @TestCase
    func mp3agic_AlbumImage03(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/16pic_25.png"))
        //var expimgDataSrc = loadFile("../../HLT/id3v1.jpeg")
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //var id3v2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as  AbstractID3v2Tag).getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "testMimeType123")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"testMimeType123")
    }


    @TestCase
    func mp3agic_AlbumImage04(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v11.gif"))
        //var expimgDataSrc = loadFile("../../HLT/id3v1.jpeg")
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //var id3v2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as  AbstractID3v2Tag).getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "testMimeType123")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"testMimeType123")

    }




    @TestCase
    func mp3agic_AlbumImage05(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v11.gif"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "tiff")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"tiff")
    }



    @TestCase
    func mp3agic_AlbumImage06(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v11.gif"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc,"jpeg")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"jpeg")
    }


    @TestCase
    func mp3agic_AlbumImage07(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v11.gif"))           //有中文设置不进去
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "jpeg,仓颉")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        //@Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"jpeg,仓颉")
    }



    @TestCase
    func mp3agic_AlbumImage08(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v11.gif"))                  //有中文设置不进去
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "jpeg123,仓颉")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"jpeg123,仓颉")
    }


    @TestCase
    func mp3agic_AlbumImage09(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v11.gif"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "jpeg123&*%仓颉")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"jpeg123&*%仓颉")
    }


    @TestCase
    func mp3agic_AlbumImage10(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v1.jpeg"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        //println(id3V2Tag1.getAlbumImage())
        //println(id3V2Tag1.getAlbumImageMimeType())
        //println(expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImage(),id3V22Tag.getAlbumImage())
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"image/png")
    }


    @TestCase
    func mp3agic_AlbumImage11(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v1.jpeg"))            //当设置为中文时，java可以设置进去仓颉设置不进去
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        //println(id3V2Tag1.getAlbumImage())
        //println(id3V2Tag1.getAlbumImageMimeType())
        //println(expimgDataSrc)
        //@Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        println(id3V2Tag1.getAlbumImageMimeType())
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"仓颉")
    }


    @TestCase
    func mp3agic_AlbumImage12(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/v1tag.mp3"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var s=id3V22Tag.getAlbumImage()
        id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"仓颉")
    }



    @TestCase
    func mp3agic_AlbumImage13(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/v1tag.mp3"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var s=id3V22Tag.getAlbumImage()
        id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"仓颉")
    }


    @TestCase
    func mp3agic_AlbumImage14(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v1.jpeg"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var s=id3V22Tag.getAlbumImage()
        id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉/png/tiff")
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"仓颉/png/tiff")
    }



    @TestCase
    func mp3agic_AlbumImage15(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/v1tag.mp3"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉/png/tiff")
        id3V22Tag.setAlbumImage(expimgDataSrc, "TuPianLeiXing:jpeg",100, "xxxaaaaaaaaaaaaaaaa中文ccc");
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"TuPianLeiXing:jpeg")
    }


    @TestCase
    func mp3agic_AlbumImage16(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/v1tag.mp3"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉/png/tiff")
        id3V22Tag.setAlbumImage(expimgDataSrc, "TuPianLeiXing:jpeg",-128, "xxxaaaaaaaaaaaaaaaa中文ccc");
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"TuPianLeiXing:jpeg")
    }


    @TestCase
    func mp3agic_AlbumImage17(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/v1tag.mp3"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉/png/tiff")
        id3V22Tag.setAlbumImage(expimgDataSrc, "TuPianLeiXing:jpeg",127, "xxxaaaaaaaaaaaaaaaa中文ccc");
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"TuPianLeiXing:jpeg")
    }

    @TestCase
    func mp3agic_AlbumImage18(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/v1tag.mp3"))
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉/png/tiff")
        id3V22Tag.setAlbumImage(expimgDataSrc, "TuPianLeiXing:jpeg",127, "xxxaaaaaaaaaa&*……中文ccc");
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"TuPianLeiXing:jpeg")
    }


    @TestCase
    func mp3agic_AlbumImage19(): Unit {
        
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v1.jpeg"))                 
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉/png/tiff")
        id3V22Tag.setAlbumImage(expimgDataSrc, "PianLeiXing:jpeg",127, "");
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        //println(id3V2Tag1.getAlbumImage())
        @Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"PianLeiXing:jpeg")
    }


    @TestCase
    func mp3agic_AlbumImage20(): Unit {
        var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/id3v1.jpeg"))                     
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        var a=id3V22Tag.getAlbumImage()
        id3V22Tag.setAlbumImage(expimgDataSrc, "",127, "xxxaaaaaaaaaa&*……中文ccc");
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        @Assert(id3V2Tag1.getAlbumImage(),a)
        //@Assert(id3V2Tag1.getAlbumImage(),expimgDataSrc)
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"image/png")

    }

    @TestCase
    func mp3agic_AlbumImage21(): Unit {
        //var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../HLT/v1tag.mp3"))
        var expimgDataSrc: Array<Int8> = []
        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        //id3V22Tag.setAlbumImage(expimgDataSrc, "仓颉/png/tiff")
        id3V22Tag.setAlbumImage(expimgDataSrc, "TuPianLeiXing:jpeg",127, "xxxaaaaaaaaaa&*……中文ccc");
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        //println(id3V2Tag1.getAlbumImage())
        //println(id3V2Tag1.getAlbumImageMimeType())
        @Assert(id3V2Tag1.getAlbumImageMimeType(),"image/png")
    }


    @TestCase
    func mp3agic_AlbumImage22(): Unit {

        var mp3File: Mp3File = Mp3File("../../HLT/v1andv23tagswithalbumimage.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.clearAlbumImage()
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        println(id3V2Tag1.getAlbumImage())
        println(id3V2Tag1.getAlbumImageMimeType())
    }


    @TestCase
    func mp3agic_AlbumImage23(): Unit {
        try{
        var mp3File: Mp3File = Mp3File("../../HLT/v23tagwithchapters.mp3")       
        var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        id3V22Tag.clearAlbumImage()
        mp3File.save("../../HLT/save_pic_v1andv23tagswithalbumimage.mp3")
        var mp3FileSave: Mp3File = Mp3File("../../HLT/save_pic_v23tagwithchapters.mp3")
        var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
        println(id3V2Tag1.getAlbumImage())
        println(id3V2Tag1.getAlbumImageMimeType())
        } catch (e: Exception) {
        @Assert(e.toString(),"FSException: The path `../../HLT/save_pic_v23tagwithchapters.mp3` does not exist")
        }
    }

}