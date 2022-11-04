// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./dummyframes.mp3:./dummyframe.mp3:./dummyframee.mp3
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_Getcustomtag {
    @TestCase
    func getCustomtag(): Unit {
        var mp3file: Mp3File = Mp3File("dummyframes.mp3") //设置CustomTag
        var expp: Array<Int8> = [84,65,71,84,73,84,76,69,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,65,82,84,
        73,83,84,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,65,76,66,85,77,49,50,51,52,53,54,55,56,57,48,49,50,
        51,52,53,54,55,56,57,48,49,50,51,52,53,50,48,48,49,67,79,77,77,69,78,84,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,0,1,13]
        mp3file.setCustomTag(Option<Array<Int8>>.Some(expp))
        mp3file.save("dummyframe.mp3")
        var mp3file1: Mp3File = Mp3File("dummyframe.mp3")
        @Assert(mp3file1.getCustomTag (),expp)

        var mp3file2: Mp3File = Mp3File("dummyframe.mp3") //设置边界值CustomTag
        var exppt: Array<Int8> = [-127,65,71,84,73,84,76,69,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,-127,82,84,73,127]
        mp3file2.setCustomTag(Option<Array<Int8>>.Some(exppt))
        mp3file2.save("dummyframee.mp3")
        var mp3file3: Mp3File = Mp3File("dummyframee.mp3")
        @Assert(mp3file3.getCustomTag (),exppt)

        var mp3file4: Mp3File = Mp3File("dummyframee.mp3") //设置单个最大值CustomTag
        var expptt: Array<Int8> = [-128]
        mp3file4.setCustomTag(Option<Array<Int8>>.Some(expptt))
        mp3file4.save("dummyframeee.mp3")
        var mp3file5: Mp3File = Mp3File("dummyframeee.mp3")
        @Assert(mp3file5.getCustomTag (),expptt)

        var mp3file6: Mp3File = Mp3File("dummyframee.mp3") //设置空CustomTag
        var exppttt: Array<Int8> = []
        mp3file6.setCustomTag(Option<Array<Int8>>.Some(exppttt))
        mp3file6.save("dummyframeeee.mp3")
        var mp3file7: Mp3File = Mp3File("dummyframeeee.mp3")
        @Assert(mp3file7.getCustomTag ().toString(),"None")
    }
}
