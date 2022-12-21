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
public class Mp3agic_Mpegframe01 { //各种类型版本
    @TestCase
    func mpegFrame01(): Unit {
        var mpegFrame: MpegFrame = MpegFrame(-1, -30, 19, 0)
        @Assert(mpegFrame.getBitrate(),8)
        @Assert(mpegFrame.getVersion(),"2.5")
        @Assert(mpegFrame.getLayer(),"III")
        @Assert(mpegFrame.getSampleRate(),11025)
        @Assert(mpegFrame.getChannelMode(),"Stereo")
        @Assert(mpegFrame.getModeExtension(),"n/a")
        @Assert(mpegFrame.isCopyright(),false)
        @Assert(mpegFrame.isOriginal(),false)
        @Assert(mpegFrame.getEmphasis(),"None")

        var mpegFrame1: MpegFrame = MpegFrame(-1, -13, 19, 0)
        @Assert(mpegFrame1.getVersion(),"2.0")
        @Assert(mpegFrame1.getLayer(),"III")
        @Assert(mpegFrame1.getBitrate(),8)
        @Assert(mpegFrame1.getSampleRate(),22050)
        @Assert(mpegFrame1.getChannelMode(),"Stereo")
        @Assert(mpegFrame1.getModeExtension(),"n/a")
        @Assert(mpegFrame1.isCopyright(),false)
        @Assert(mpegFrame1.isOriginal(),false)
        @Assert(mpegFrame1.getEmphasis(),"None")

        var mpegFrame2: MpegFrame = MpegFrame(-1, -6, 35, 0)
        @Assert(mpegFrame2.getVersion(),"1.0")
        @Assert(mpegFrame2.getLayer(),"III")
        @Assert(mpegFrame2.getBitrate(),40)
        @Assert(mpegFrame2.getSampleRate(),44100)
        @Assert(mpegFrame2.getChannelMode(),"Stereo")
        @Assert(mpegFrame2.getModeExtension(),"n/a")
        @Assert(mpegFrame2.isCopyright(),false)
        @Assert(mpegFrame2.isOriginal(),false)
        @Assert(mpegFrame2.getEmphasis(),"None")
    }
}
