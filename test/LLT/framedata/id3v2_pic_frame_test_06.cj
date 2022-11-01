// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var expimgData = loadFile("../../../../test/LLT/framedata/testfiles/image.png")
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/obsolete.mp3")
    var id3v2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as  AbstractID3v2Tag).getOrThrow()
    var albumImage = id3v2Tag.getAlbumImage().getOrThrow()
    var albumImageMimeType = id3v2Tag.getAlbumImageMimeType()
    if (albumImage.slice(0, 1885) != expimgData) {
        return 1
    }
    if (albumImageMimeType != "image/png") {
        return 1
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}
