// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/framedata/testfiles/v24tagswithalbumimage.mp3")
    var tag_23: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    var tag = tag_23.getOrThrow()
	var lyrics: Option<String> = tag.getLyrics()
	println("lyrics ==> ${lyrics}")
	if(lyrics != "LYRICS1234567890123456789012345"){
	    return 1
	}
	var byteSrc = tag.toBytes()
	tag.setLyrics("中文lyrics");
	lyrics = tag.getLyrics()
	println("lyrics ==> ${lyrics}")
	if(lyrics != "中文lyrics"){
	    return 1
	}
    var bytesTag = tag.toBytes()
    if (byteSrc == bytesTag){
        return 1
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}



