// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    try {
        var mp3File: Mp3File = Mp3File(
            "../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3", 40, true)
    } catch (e: Exception) {
        if (e.toString() != "IllegalArgumentException: Buffer too small") {
            return 1
        }
    }
    0
}
