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
public class Mp3agic_Mpegframe03 { //采样率
    @TestCase
    func mpegFrame03(): Unit {
        var mpegFrame: MpegFrame = MpegFrame(-1, -26, 87, 0)
        @Assert(mpegFrame.getVersion(),"2.5")
        @Assert(mpegFrame.getLayer(),"I")
        @Assert(mpegFrame.getBitrate(),80)
        @Assert(mpegFrame.getSampleRate(),12000)
        @Assert(mpegFrame.getChannelMode(),"Stereo")
        @Assert(mpegFrame.getModeExtension(),"n/a")
        @Assert(mpegFrame.isCopyright(),false)
        @Assert(mpegFrame.isOriginal(),false)
        @Assert(mpegFrame.getEmphasis(),"None")

        var mpegFrame1: MpegFrame = MpegFrame(-1, -26, 107, 0)
        @Assert(mpegFrame1.getVersion(),"2.5")
        @Assert(mpegFrame1.getLayer(),"I")
        @Assert(mpegFrame1.getBitrate(),96)
        @Assert(mpegFrame1.getSampleRate(),8000)
        @Assert(mpegFrame1.getChannelMode(),"Stereo")
        @Assert(mpegFrame1.getModeExtension(),"n/a")
        @Assert(mpegFrame1.isCopyright(),false)
        @Assert(mpegFrame1.isOriginal(),false)
        @Assert(mpegFrame1.getEmphasis(),"None")

        var mpegFrame2: MpegFrame = MpegFrame(-1, -29, 55, 0)
        @Assert(mpegFrame2.getVersion(),"2.5")
        @Assert(mpegFrame2.getLayer(),"III")
        @Assert(mpegFrame2.getBitrate(),24)
        @Assert(mpegFrame2.getSampleRate(),12000)
        @Assert(mpegFrame2.getChannelMode(),"Stereo")
        @Assert(mpegFrame2.getModeExtension(),"n/a")
        @Assert(mpegFrame2.isCopyright(),false)
        @Assert(mpegFrame2.isOriginal(),false)
        @Assert(mpegFrame2.getEmphasis(),"None")

        var mpegFrame3: MpegFrame = MpegFrame(-1, -26, 107, 0)
        @Assert(mpegFrame3.getVersion(),"2.5")
        @Assert(mpegFrame3.getLayer(),"I")
        @Assert(mpegFrame3.getBitrate(),96)
        @Assert(mpegFrame3.getSampleRate(),8000)
        @Assert(mpegFrame3.getChannelMode(),"Stereo")
        @Assert(mpegFrame3.getModeExtension(),"n/a")
        @Assert(mpegFrame3.isCopyright(),false)
        @Assert(mpegFrame3.isOriginal(),false)
        @Assert(mpegFrame3.getEmphasis(),"None")
    }
}
