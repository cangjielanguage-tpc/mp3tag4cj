// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/obsolete-noimage.mp3")
    if (mp3File.hasId3v2Tag()) {
        var id3v2Tag = mp3File.getId3v2Tag().getOrThrow()
        try {
            id3v2Tag.toBytes()
        }catch (e: Exception){
            if (e.toString() != "Exception: Packing Obselete frames is not supported"){
                return 1
            }
        }
    }
    0
}