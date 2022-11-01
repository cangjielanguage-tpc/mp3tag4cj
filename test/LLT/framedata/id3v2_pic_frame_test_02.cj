// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var expimgDataSrc = loadFile("../../../../test/LLT/framedata/testfiles/image.png")
    var expimgDataUpDate = loadFile("../../../../test/LLT/framedata/testfiles/test_jp.jpeg")
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/v24tagswithalbumimage.mp3")
    var id3v2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as  AbstractID3v2Tag).getOrThrow()
    var albumImage = id3v2Tag.getAlbumImage()
    var albumImageMimeType = id3v2Tag.getAlbumImageMimeType()
    if (albumImage != expimgDataSrc) {
        return 1
    }
    if (albumImageMimeType != "image/png") {
        return 1
    }
    id3v2Tag.setAlbumImage(expimgDataUpDate, "testMimeType123")
    mp3File.save("../../../../test/LLT/framedata/testfiles/save_pic_v24tagswithalbumimage.mp3")
    var mp3FileSave: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/save_pic_v24tagswithalbumimage.mp3")
    var id3v2TagSave: AbstractID3v2Tag = ((mp3FileSave.getId3v2Tag().getOrThrow()) as  AbstractID3v2Tag).getOrThrow()
    albumImage = id3v2TagSave.getAlbumImage()
    albumImageMimeType = id3v2TagSave.getAlbumImageMimeType()
    if (albumImage != expimgDataUpDate) {
        return 1
    }
    if (albumImageMimeType != "testMimeType123") {
        return 1
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}