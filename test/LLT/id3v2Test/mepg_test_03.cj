// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
//FF FE 18 6F
main() {
    var mpegFrame = MpegFrame(trans8(0xFF), trans8(0xFE), trans8(0x18), trans8(0x6F))
    println("比特率 ==> ${mpegFrame.getBitrate()}")
    println("版本 ==> ${mpegFrame.getVersion()}")
    println("层 ==> ${mpegFrame.getLayer()}")
    println("采样率 ==> ${mpegFrame.getSampleRate()}")
    println("声道模式 ==> ${mpegFrame.getChannelMode()}")
    println("扩展模式 ==> ${mpegFrame.getModeExtension()}")
    println("版权 ==> ${mpegFrame.isCopyright()}")
    println("原版 ==> ${mpegFrame.isOriginal()}")
    println("强调方式 ==> ${mpegFrame.getEmphasis()}")
    if (mpegFrame.getBitrate() != 32){
        return 1
    }
    if (mpegFrame.getVersion() != "1.0"){
        return 1
    }
    if (mpegFrame.getLayer() != "I"){
        return 1
    }
    if (mpegFrame.getSampleRate() != 32000){
        return 1
    }
    if (mpegFrame.getChannelMode() != "Joint stereo"){
        return 1
    }
    if (mpegFrame.getModeExtension() != "Bands 12-31"){
        return 1
    }
    if (mpegFrame.isCopyright() != true){
        return 1
    }
    if (mpegFrame.isOriginal() != true){
        return 1
    }
    if (mpegFrame.getEmphasis() != "CCITT J.17"){
        return 1
    }
    0
}

@overflowWrapping
func trans8(val: Int32): Int8 {
    return Int8(val)
}
