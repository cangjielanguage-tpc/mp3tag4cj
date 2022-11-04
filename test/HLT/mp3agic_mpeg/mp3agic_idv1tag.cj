// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_ID3V1Tag {
    @TestCase
    func id3v1Tag(): Unit {
        var expt1: Array<Int8> = [
            84,65,71,84,73,84,76,69,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,65,82,84,73,
            83,84,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,65,76,66,85,77,49,50,51,52,53,54,
            55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,50,48,48,49,67,79,77,77,69,78,84,49,50,51,52,53,54,55,
            56,57,48,49,50,51,52,53,54,55,56,57,48,49,0,1,13]
        var mp3File: Mp3File = Mp3File("v1tag.mp3")
        var ID3V1 = mp3File.getId3v1Tag().getOrThrow()
        @Assert(ID3V1.toBytes(),expt1)
    }
}
