// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./dummyframes.mp3:./notags.mp3:./notanmp3.mp3
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_Getbitrate {
    @TestCase
    func getBitrate(): Unit {
        var mp3file: Mp3File = Mp3File("dummyframes.mp3") //获取有xing-header并有标签偏移量                  

        //for ( (key, val) in mp3file.getBitrates()){                        
        //println("key ==> ${key}")
        //println("var ==> ${val.getValue()}") 
        //}
        @Assert(mp3file.hasXingFrame(),true)
        @Assert(mp3file.getXingBitrate(),128)
        @Assert(mp3file.getLengthInSeconds(),0)
        @Assert(mp3file.getLengthInMilliseconds(),156)
        @Assert(mp3file.isVbr(),true)
        @Assert(mp3file.getStartOffset(),1516)
        @Assert(mp3file.getXingOffset(),1099)
        @Assert(mp3file.getEndOffset(),3967)
        @Assert(mp3file.getFrameCount(),6)
        @Assert(mp3file.getBitrate(),125)

        var mp3file1: Mp3File = Mp3File("notags.mp3") //获取有xing-header没有标签偏移量

        //for ( (key1, val1) in mp3file1.getBitrates()){                         
        //println("key ==> ${key1}")
        //println("var ==> ${val1.getValue()}")
        //}
        @Assert(mp3file1.hasXingFrame(),true)
        @Assert(mp3file1.getXingBitrate(),128)
        @Assert(mp3file1.getLengthInSeconds(),0)
        @Assert(mp3file1.getLengthInMilliseconds(),156)
        @Assert(mp3file1.isVbr(),true)
        @Assert(mp3file1.getStartOffset(),417)
        @Assert(mp3file1.getXingOffset(),0)
        @Assert(mp3file1.getEndOffset(),2868)
        @Assert(mp3file1.getFrameCount(),6)
        @Assert(mp3file1.getBitrate(),125)

        try {
            var mp3file2: Mp3File = Mp3File("notanmp3.mp3") //没有xing-header没有音频标签          

            //for ( (key2, val2) in mp3file2.getBitrates()){                         
            //println("key ==> ${key2}")
            //println("var ==> ${val2.getValue()}")
            //}
            @Assert(mp3file2.hasXingFrame(),true)
            @Assert(mp3file2.getXingBitrate(),128)
            @Assert(mp3file2.getLengthInSeconds(),0)
            @Assert(mp3file2.getLengthInMilliseconds(),156)
            @Assert(mp3file2.isVbr(),true)
            @Assert(mp3file2.getStartOffset(),417)
            @Assert(mp3file2.getXingOffset(),0)
            @Assert(mp3file2.getEndOffset(),2868)
            @Assert(mp3file2.getFrameCount(),6)
            @Assert(mp3file2.getBitrate(),125)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: No mpegs frames found")
        }
    }
}
