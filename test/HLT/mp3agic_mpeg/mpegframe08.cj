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
public class Mp3agic_Mpegframe_008 {
    @TestCase
    func mpegFrame_008(): Unit {
        var expBuffer: Array<Int32> = [0xFF, 0xE2, 0x83, 0xAD] //强调方式
        var res: Array<Int8> = transInt8(expBuffer)
        var mpegFrame: MpegFrame = MpegFrame(res)
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
            var expBuffer1: Array<Int32> = [0xFF, 0xE2, 0x83, 0xAE]
            var res1: Array<Int8> = transInt8(expBuffer1)
            var mpegFrame1: MpegFrame = MpegFrame(res1)
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
        var expBuffer2: Array<Int32> = [0xFF, 0xE2, 0x83, 0xAF]
        var res2: Array<Int8> = transInt8(expBuffer2)
        var mpegFrame2: MpegFrame = MpegFrame(res2)
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

@overflowWrapping
func transInt8(expBuffer: Array<Int32>): Array<Int8> {
    var src: Array<Int32> = expBuffer
    var res: Array<Int8> = Array<Int8>(src.size, {i => 0})
    for (index in 0..src.size) {
        res[index] = Int8(src[index])
    }
    return res
}
