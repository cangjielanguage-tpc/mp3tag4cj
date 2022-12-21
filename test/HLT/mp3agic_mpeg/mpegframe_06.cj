// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_Mpegframe06 { //版权
    @TestCase
    func mpegFrame06(): Unit {
        var mpegFrame: MpegFrame = MpegFrame(-1, -30, -125, -88)
        @Assert(mpegFrame.getVersion(),"2.5")
        @Assert(mpegFrame.getLayer(),"III")
        @Assert(mpegFrame.getBitrate(),64)
        @Assert(mpegFrame.getSampleRate(),11025)
        @Assert(mpegFrame.getChannelMode(),"Dual mono")
        @Assert(mpegFrame.getModeExtension(),"n/a")
        @Assert(mpegFrame.isCopyright(),true)
        @Assert(mpegFrame.isOriginal(),false)
        @Assert(mpegFrame.getEmphasis(),"None")
    }
}
