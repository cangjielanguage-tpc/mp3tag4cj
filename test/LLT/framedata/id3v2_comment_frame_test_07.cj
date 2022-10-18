// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/withitunescomment.mp3")
    var hasId3v2Tag = mp3File.hasId3v2Tag()
    if (hasId3v2Tag != true) {
        return 1
    }
    var tagOp = mp3File.getId3v2Tag()
    var tag = (tagOp.getOrThrow() as AbstractID3v2Tag).getOrThrow()
	var itunescomment: Option<String> = tag.getItunesComment()
	println("itunescomment ==> ${itunescomment}")
	if(itunescomment != " 00000A78 00000A74 00000C7C 00000C6C 00000000 00000000 000051F7 00005634 00000000 00000000"){
	    return 1
	}
	tag.setItunesComment("itunescomment")
	itunescomment = tag.getItunesComment()
	println("itunescomment ==> ${itunescomment}")
	if(itunescomment != "itunescomment"){
	    return 1
	}
	var byteSrc = tag.toBytes()
    mp3File.save("../../../../test/LLT/framedata/testfiles/save_withitunescomment.mp3")
    var mp3FileSave: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/save_withitunescomment.mp3")
    var hasId3v2TagSave = mp3FileSave.hasId3v2Tag()
    if (hasId3v2TagSave != true) {
        return 1
    }
    var tagOpSave = mp3FileSave.getId3v2Tag()
    var tagSave = (tagOpSave.getOrThrow() as AbstractID3v2Tag).getOrThrow()
	var itunescommentSave: Option<String> = tagSave.getItunesComment()
	println("itunescommentSave ==> ${itunescommentSave}")
    if (itunescommentSave != "itunescomment") {
        return 1
    }
    var bytesTag = tagSave.toBytes()
    if (byteSrc != bytesTag){
        return 1
    }
    0
}



