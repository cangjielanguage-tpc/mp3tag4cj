// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var str = "ID3 some track"
    var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
    var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
    try {
        var tag2 = ID3v22Tag(sb2, true)
    } catch (e: Exception) {
        if (e.toString() != "Exception: Unsupported version 2.32.115") {
            return 1
        }
    }
    return 0
}
