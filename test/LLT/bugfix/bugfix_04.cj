// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var bytes: Array<Int8> = [0x49, 0x44, 0x33, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    try {
        var tag2 = ID3v22Tag(bytes, true)
    } catch (e: Exception) {
        if (e.toString() != "Exception: Zero size tag") {
            return 1
        }
    }
    return 0
}
