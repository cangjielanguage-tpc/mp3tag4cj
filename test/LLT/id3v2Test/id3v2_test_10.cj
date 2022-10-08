// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3")
    var tag_23: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    match(tag_23) {
        case Some(x) =>
            var expBuffer: Array<Int8> = [1, -1, -2, 84, 0, 73, 0, 84, 0, 76, 0, 69, 0, 49, 0, 50, 0, 51, 0, 52, 0, 53, 0,
            54, 0, 55, 0, 56, 0, 57, 0, 48, 0, 49, 0, 50, 0, 51, 0, 52, 0, 53, 0, 54, 0, 55, 0, 56, 0, 57, 0, 48, 0, 49,
            0, 50, 0, 51, 0, 52, 0, 53, 0]
            var frameSets: Map<String, ID3v2FrameSet> = x.getFrameSets()
		    var tit2: ID3v2FrameSet = frameSets.get("TIT2").getOrThrow()
		    var frames: ArrayList<ID3v2Frame> = tit2.getFrames()
		    for (frame in frames){
		        var buffer = frame.getData()
		        if (buffer != expBuffer) {return 1}
		    }
        case None => return 1
    }
    0
}


func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}



