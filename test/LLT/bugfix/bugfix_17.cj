// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import collection.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/bugfix/testfiles/v23tagwithchapters.mp3")
    var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
    var chapterTOC: ArrayList<ID3v2ChapterTOCFrameData> = id3V22Tag.getChapterTOC().getOrThrow()
    var id3v2Frame: ID3v2ChapterTOCFrameData = chapterTOC[0]
    var subFrameData1: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText("$#@@$"))
    id3v2Frame.addSubframe("QWERQWEQWEQWEQWEQWEQWE", subFrameData1)
    try {
        id3V22Tag.setChapterTOC(chapterTOC)
    }catch (e: Exception) {
        if (e.toString() != "IndexOutOfBoundsException: Copy length out of bounds") {
            return 1
        }
    }
    0
}

