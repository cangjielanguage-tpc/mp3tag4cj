// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/framedata/testfiles/withitunescomment.mp3")
    var tag_23: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    var tag = tag_23.getOrThrow()
    var itunescomment: Option<String> = tag.getItunesComment()
	println("itunescomment ==> ${itunescomment}")
	if (itunescomment != " 00000A78 00000A74 00000C7C 00000C6C 00000000 00000000 000051F7 00005634 00000000 00000000") {
	    return 1
	}
	try {
	    tag.setItunesComment("中文itunescomment")
    } catch (e: Exception){
        if (e.toString() != "Exception: description and comment must have same text encoding") {
            return 1
        }
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}



