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
public class Mp3agic_Mpegframe08 { //强调方式
    @TestCase
    func mpegFrame08(): Unit {
        var mpegFrame: MpegFrame = MpegFrame(-1, -30, -125, -83)
        @Assert(mpegFrame.getVersion(),"2.5")
        @Assert(mpegFrame.getLayer(),"III")
        @Assert(mpegFrame.getBitrate(),64)
        @Assert(mpegFrame.getSampleRate(),11025)
        @Assert(mpegFrame.getChannelMode(),"Dual mono")
        @Assert(mpegFrame.getModeExtension(),"n/a")
        @Assert(mpegFrame.isCopyright(),true)
        @Assert(mpegFrame.isOriginal(),true)
        @Assert(mpegFrame.getEmphasis(),"50/15 ms")

        try {
            var mpegFrame1: MpegFrame = MpegFrame(-1, -30, -125, -82)
            @Assert(mpegFrame1.getVersion(),"2.0")
            @Assert(mpegFrame1.getLayer(),"I")
            @Assert(mpegFrame1.getBitrate(),64)
            @Assert(mpegFrame1.getSampleRate(),22050)
            @Assert(mpegFrame1.getChannelMode(),"Stereo")
            @Assert(mpegFrame1.getModeExtension(),"n/a")
            @Assert(mpegFrame1.isCopyright(),false)
            @Assert(mpegFrame1.isOriginal(),false)
            @Assert(mpegFrame1.getEmphasis(),"None")
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Invalid emphasis in frame header")
        }
        var mpegFrame2: MpegFrame = MpegFrame(-1, -30, -125, -81)
        @Assert(mpegFrame2.getVersion(),"2.5")
        @Assert(mpegFrame2.getLayer(),"III")
        @Assert(mpegFrame2.getBitrate(),64)
        @Assert(mpegFrame2.getSampleRate(),11025)
        @Assert(mpegFrame2.getChannelMode(),"Dual mono")
        @Assert(mpegFrame2.getModeExtension(),"n/a")
        @Assert(mpegFrame2.isCopyright(),true)
        @Assert(mpegFrame2.isOriginal(),true)
        @Assert(mpegFrame2.getEmphasis(),"CCITT J.17")
    }
}
