// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var expimgDataSrc: Array<Int8> = BufferTools.transUInt8ArrayToInt8(File.readFrom("../../../../test/LLT/bugfix/testfiles/test_jp.jpeg"))
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/bugfix/testfiles/v1andv23tagswithalbumimage.mp3")
    var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
    id3V22Tag.setAlbumImage(expimgDataSrc, "TuPianLeiXing:jpeg",127, "");
    mp3File.save("../../../../test/LLT/bugfix/testfiles/save_pic_v1andv23tagswithalbumimage.mp3")
    var mp3FileSave: Mp3File = Mp3File("../../../../test/LLT/bugfix/testfiles/save_pic_v1andv23tagswithalbumimage.mp3")
    var id3V2Tag1 = mp3FileSave.getId3v2Tag().getOrThrow()
    var result =id3V2Tag1.getAlbumImage()
    if (id3V2Tag1.getAlbumImage() != expimgDataSrc) {
        return 1
    }
    if (id3V2Tag1.getAlbumImageMimeType() != "TuPianLeiXing:jpeg") {
        return 1
    }
    0
}