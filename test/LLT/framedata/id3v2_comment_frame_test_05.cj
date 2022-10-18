// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/v24tagswithalbumimage.mp3")
    var hasId3v2Tag = mp3File.hasId3v2Tag()
    if (hasId3v2Tag != true) {
        return 1
    }
    var tagOp = mp3File.getId3v2Tag()
    var tag = (tagOp.getOrThrow() as AbstractID3v2Tag).getOrThrow()
	var lyrics: Option<String> = tag.getLyrics()
	println("lyrics ==> ${lyrics}")
	if(lyrics != "LYRICS1234567890123456789012345"){
	    return 1
	}
	tag.setLyrics("中文lyrics");
	lyrics = tag.getLyrics()
	println("lyrics ==> ${lyrics}")
	if(lyrics != "中文lyrics"){
	    return 1
	}
	var byteSrc = tag.toBytes()
    mp3File.save("../../../../test/LLT/framedata/testfiles/save_v24tagswithalbumimage.mp3")
    var mp3FileSave: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/save_v24tagswithalbumimage.mp3")
    var hasId3v2TagSave = mp3FileSave.hasId3v2Tag()
    if (hasId3v2TagSave != true) {
        return 1
    }
    var tagOpSave = mp3FileSave.getId3v2Tag()
    var tagSave = (tagOpSave.getOrThrow() as AbstractID3v2Tag).getOrThrow()
	var lyricsSave: Option<String> = tagSave.getLyrics()
	println("lyricsSave ==> ${lyricsSave}")
    if (lyricsSave != "中文lyrics") {
        return 1
    }
    var bytesTag = tagSave.toBytes()
    if (byteSrc != bytesTag){
        return 1
    }
    0
}



