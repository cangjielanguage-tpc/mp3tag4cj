// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
//FF FE 1F 7F
main() {
    try {
        var mpegFrame = MpegFrame(trans8(0xFF), trans8(0xFE), trans8(0x1F), trans8(0x7F))
    }catch(e: Exception){
        if (e.toString() != "Exception: Invalid sample rate in frame header"){
            return 1
        }
    }
    0
}

@overflowWrapping
func trans8(val: Int32): Int8 {
    return Int8(val)
}
