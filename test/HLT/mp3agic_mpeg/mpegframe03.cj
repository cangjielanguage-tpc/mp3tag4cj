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
public class Mp3agic_Mpegframe_003 {
    @TestCase
    func mpegFrame_003(): Unit {
        var expBuffer: Array<Int32> = [0xFF, 0xE6, 0x57, 0x00] //各种采样率
        var res: Array<Int8> = transInt8(expBuffer)
        var mpegFrame: MpegFrame = MpegFrame(res)
        @Assert(mpegFrame.getVersion(),"2.5")
        @Assert(mpegFrame.getLayer(),"I")
        @Assert(mpegFrame.getBitrate(),80)
        @Assert(mpegFrame.getSampleRate(),12000)
        @Assert(mpegFrame.getChannelMode(),"Stereo")
        @Assert(mpegFrame.getModeExtension(),"n/a")
        @Assert(mpegFrame.isCopyright(),false)
        @Assert(mpegFrame.isOriginal(),false)
        @Assert(mpegFrame.getEmphasis(),"None")

        var expBuffer1: Array<Int32> = [0xFF, 0xE6, 0x6B, 0x00]
        var res1: Array<Int8> = transInt8(expBuffer1)
        var mpegFrame1: MpegFrame = MpegFrame(res1)
        @Assert(mpegFrame1.getVersion(),"2.5")
        @Assert(mpegFrame1.getLayer(),"I")
        @Assert(mpegFrame1.getBitrate(),96)
        @Assert(mpegFrame1.getSampleRate(),8000)
        @Assert(mpegFrame1.getChannelMode(),"Stereo")
        @Assert(mpegFrame1.getModeExtension(),"n/a")
        @Assert(mpegFrame1.isCopyright(),false)
        @Assert(mpegFrame1.isOriginal(),false)
        @Assert(mpegFrame1.getEmphasis(),"None")

        var expBuffer2: Array<Int32> = [0xFF, 0xE3, 0x37, 0x00]
        var res2: Array<Int8> = transInt8(expBuffer2)
        var mpegFrame2: MpegFrame = MpegFrame(res2)
        @Assert(mpegFrame2.getVersion(),"2.5")
        @Assert(mpegFrame2.getLayer(),"III")
        @Assert(mpegFrame2.getBitrate(),24)
        @Assert(mpegFrame2.getSampleRate(),12000)
        @Assert(mpegFrame2.getChannelMode(),"Stereo")
        @Assert(mpegFrame2.getModeExtension(),"n/a")
        @Assert(mpegFrame2.isCopyright(),false)
        @Assert(mpegFrame2.isOriginal(),false)
        @Assert(mpegFrame2.getEmphasis(),"None")

        var expBuffer3: Array<Int32> = [0xFF, 0xE6, 0x6B, 0x00]
        var res3: Array<Int8> = transInt8(expBuffer3)
        var mpegFrame3: MpegFrame = MpegFrame(res3)
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

@overflowWrapping
func transInt8(expBuffer: Array<Int32>): Array<Int8> {
    var src: Array<Int32> = expBuffer
    var res: Array<Int8> = Array<Int8>(src.size, {i => 0})
    for (index in 0..src.size) {
        res[index] = Int8(src[index])
    }
    return res
}
