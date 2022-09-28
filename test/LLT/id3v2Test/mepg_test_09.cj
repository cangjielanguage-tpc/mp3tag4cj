// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
//V2, v2.5, l2, l3
main() {
    var mpegFrame1 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x13), trans8(0xCF))
    println("比特率 ==> ${mpegFrame1.getBitrate()}")
    if (mpegFrame1.getBitrate() != 8){
        return 1
    }
    var mpegFrame2 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x23), trans8(0xCF))
    println("比特率 ==> ${mpegFrame2.getBitrate()}")
    if (mpegFrame2.getBitrate() != 16){
        return 1
    }
    var mpegFrame3 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x33), trans8(0xCF))
    println("比特率 ==> ${mpegFrame3.getBitrate()}")
    if (mpegFrame3.getBitrate() != 24){
        return 1
    }
    var mpegFrame4 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x43), trans8(0xCF))
    println("比特率 ==> ${mpegFrame4.getBitrate()}")
    if (mpegFrame4.getBitrate() != 32){
        return 1
    }
    var mpegFrame5 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x53), trans8(0xCF))
    println("比特率 ==> ${mpegFrame5.getBitrate()}")
    if (mpegFrame5.getBitrate() != 40){
        return 1
    }
    var mpegFrame6 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x63), trans8(0xCF))
    println("比特率 ==> ${mpegFrame6.getBitrate()}")
    if (mpegFrame6.getBitrate() != 48){
        return 1
    }
    var mpegFrame7 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x73), trans8(0xCF))
    println("比特率 ==> ${mpegFrame7.getBitrate()}")
    if (mpegFrame7.getBitrate() != 56){
        return 1
    }
    var mpegFrame8 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x83), trans8(0xCF))
    println("比特率 ==> ${mpegFrame8.getBitrate()}")
    if (mpegFrame8.getBitrate() != 64){
        return 1
    }
    var mpegFrame9 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0x93), trans8(0xCF))
    println("比特率 ==> ${mpegFrame9.getBitrate()}")
    if (mpegFrame9.getBitrate() != 80){
        return 1
    }
    var mpegFrame10 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0xA3), trans8(0xCF))
    println("比特率 ==> ${mpegFrame10.getBitrate()}")
    if (mpegFrame10.getBitrate() != 96){
        return 1
    }
    var mpegFrame11 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0xB3), trans8(0xCF))
    println("比特率 ==> ${mpegFrame11.getBitrate()}")
    if (mpegFrame11.getBitrate() != 112){
        return 1
    }
    var mpegFrame12 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0xC3), trans8(0xCF))
    println("比特率 ==> ${mpegFrame12.getBitrate()}")
    if (mpegFrame12.getBitrate() != 128){
        return 1
    }
    var mpegFrame13 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0xD3), trans8(0xCF))
    println("比特率 ==> ${mpegFrame13.getBitrate()}")
    if (mpegFrame13.getBitrate() != 144){
        return 1
    }
    var mpegFrame14 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0xE3), trans8(0xCF))
    println("比特率 ==> ${mpegFrame14.getBitrate()}")
    if (mpegFrame14.getBitrate() != 160){
        return 1
    }
    try {
         var mpegFrame15 = MpegFrame(trans8(0xFF), trans8(0xF4), trans8(0xF3), trans8(0xCF))
    }catch(e: Exception){
        if (e.toString() != "Exception: Invalid bitrate in frame header"){
            return 1
        }
    }
    0
}

@overflowWrapping
func trans8(val: Int32): Int8 {
    return Int8(val)
}
