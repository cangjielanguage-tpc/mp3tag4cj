// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/id3v2Test/testv2File/set_id3v23_v1andv23tagswithalbumimage-utf16le-foot-3FI.mp3")
    try {
        var tag_24: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    }catch(e: Exception){
        if (e.toString() != "Exception: Premature end of tag Exception: Invalid footer"){
            return 1
        }
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}
