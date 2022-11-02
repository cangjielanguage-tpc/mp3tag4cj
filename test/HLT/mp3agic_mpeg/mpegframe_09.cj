// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_Mpegframe09 { //层或版本异常
    @TestCase
    func mpegFrame09(): Unit {
        try {
            var mpegFrame: MpegFrame = MpegFrame(-1, -22, -125, -84)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Invalid mpeg audio version in frame header")
        }
        try {
            var mpegFrame: MpegFrame = MpegFrame(-1, -22, -125, -84)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Invalid mpeg audio version in frame header")
        }
    }
}
