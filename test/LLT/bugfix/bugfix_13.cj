// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/withitunescomment.mp3")
    var hasId3v2Tag = mp3File.hasId3v2Tag()
    var tagOp: Option<ID3v2> = mp3File.getId3v2Tag()
    var tag: ID3v2 = tagOp.getOrThrow()
	var itunescomment: Option<String> = tag.getItunesComment()
	if(itunescomment != " 00000A78 00000A74 00000C7C 00000C6C 00000000 00000000 000051F7 00005634 00000000 00000000"){
	    return 1
	}
	tag.setItunesComment("123456")
	itunescomment = tag.getItunesComment()
	if(itunescomment != "123456"){
	    return 1
	}
	var lyrics: Option<String> = tag.getLyrics()
	tag.setLyrics("中文Lyrics")
	lyrics = tag.getLyrics()
	if (lyrics != "中文Lyrics") {
	    return 1
	}
    0
}