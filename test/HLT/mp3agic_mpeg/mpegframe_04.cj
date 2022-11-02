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
public class Mp3agic_Mpegframe04 { //声道
    @TestCase
    func mpegFrame04(): Unit {
        var mpegFrame: MpegFrame = MpegFrame(-1, -30, -77, 64)
        @Assert(mpegFrame.getVersion(),"2.5")
        @Assert(mpegFrame.getLayer(),"III")
        @Assert(mpegFrame.getBitrate(),112)
        @Assert(mpegFrame.getSampleRate(),11025)
        @Assert(mpegFrame.getChannelMode(),"Joint stereo")
        @Assert(mpegFrame.getModeExtension(),"None")
        @Assert(mpegFrame.isCopyright(),false)
        @Assert(mpegFrame.isOriginal(),false)
        @Assert(mpegFrame.getEmphasis(),"None")

        var mpegFrame1: MpegFrame = MpegFrame(-1, -30, -61, -128)
        @Assert(mpegFrame1.getVersion(),"2.5")
        @Assert(mpegFrame1.getLayer(),"III")
        @Assert(mpegFrame1.getBitrate(),128)
        @Assert(mpegFrame1.getSampleRate(),11025)
        @Assert(mpegFrame1.getChannelMode(),"Dual mono")
        @Assert(mpegFrame1.getModeExtension(),"n/a")
        @Assert(mpegFrame1.isCopyright(),false)
        @Assert(mpegFrame1.isOriginal(),false)
        @Assert(mpegFrame1.getEmphasis(),"None")

        var mpegFrame2: MpegFrame = MpegFrame(-1, -30, -29, -64)
        @Assert(mpegFrame2.getVersion(),"2.5")
        @Assert(mpegFrame2.getLayer(),"III")
        @Assert(mpegFrame2.getBitrate(),160)
        @Assert(mpegFrame2.getSampleRate(),11025)
        @Assert(mpegFrame2.getChannelMode(),"Mono")
        @Assert(mpegFrame2.getModeExtension(),"n/a")
        @Assert(mpegFrame2.isCopyright(),false)
        @Assert(mpegFrame2.isOriginal(),false)
        @Assert(mpegFrame2.getEmphasis(),"None")
    }
}
