// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var expBuffer: Array<Int8> = [1, 84, 0, 73, -1, 0]
    var frameData: ID3v2TextFrameData = ID3v2TextFrameData(true, expBuffer)
    var res: String = frameData.getText().getOrThrow().toString().getOrThrow()
    if (res != "Tｉ") {
        return 1
    }
    var e1: ID3v2TextFrameData = ID3v2TextFrameData(true, expBuffer)
    var code: Int64  = e1.hashCode()
    var e2 = e1
    if (e1 != e2) {
        return 1
    }
    var e3: ID3v2TextFrameData = ID3v2TextFrameData(true, expBuffer)
    var e4: ID3v2TextFrameData = ID3v2TextFrameData(true, expBuffer)
    if (e3 == e4) {
        return 1
    }
    0
}
