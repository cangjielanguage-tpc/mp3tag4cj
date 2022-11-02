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
public class Mp3agic_Mpegframe_009 {
    @TestCase
    func mpegFrame_009(): Unit {
        try {
            var expBuffer: Array<Int32> = [0xFF, 0xE8, 0x83, 0xAC] //没有位率
            var res: Array<Int8> = transInt8(expBuffer)
            var mpegFrame: MpegFrame = MpegFrame(res)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Invalid mpeg audio version in frame header")
        }
        try {
            var expBuffer1: Array<Int32> = [0xFF, 0xEA, 0x83, 0xAC] //各种类型版本
            var res1: Array<Int8> = transInt8(expBuffer1)
            var mpegFrame1: MpegFrame = MpegFrame(res1)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Invalid mpeg audio version in frame header")
        }
        try {
            var expBuffer2: Array<Int32> = [0xFF, 0xEA, 0x83] //输入太短
            var res2: Array<Int8> = transInt8(expBuffer2)
            var mpegFrame2: MpegFrame = MpegFrame(res2)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Mpeg frame too short")
        }
        var expBuffer3: Array<Int32> = [0xFF, 0xE2, 0xE3, 0xC0, 0xEA, 0x83] //输入过长
        var res3: Array<Int8> = transInt8(expBuffer3)
        var mpegFrame3: MpegFrame = MpegFrame(res3)
        @Assert(mpegFrame3.getVersion(),"2.5")
        @Assert(mpegFrame3.getLayer(),"III")
        @Assert(mpegFrame3.getBitrate(),160)
        @Assert(mpegFrame3.getSampleRate(),11025)
        @Assert(mpegFrame3.getChannelMode(),"Mono")
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
