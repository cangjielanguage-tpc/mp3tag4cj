// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from std import fs.*
from mp3agic import mp3agic.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var file = FileInfo("../../../../test/LLT/testFile/v1tag.mp3")
    var file2 = Mp3File(file)
    var file3 = Mp3File("../../../../test/LLT/testFile/v1tag.mp3")
    var file4 = Mp3File("../../../../test/LLT/testFile/v1tag.mp3", true)
    var file5 = Mp3File("../../../../test/LLT/testFile/v1tag.mp3", 65536)
    var file6 = Mp3File("../../../../test/LLT/testFile/v1tag.mp3", 65536, true)
    var file7 = Mp3File(file, 65536)
    if (file2.hasId3v1Tag()){
        var id3v1Tag = file2.getId3v1Tag().getOrThrow()
        var version = id3v1Tag.getVersion()
        var track = id3v1Tag.getTrack()
        var artist = id3v1Tag.getArtist()
        var title = id3v1Tag.getTitle()
        var album = id3v1Tag.getAlbum()
        var year = id3v1Tag.getYear()
        var genre = id3v1Tag.getGenre()
        var des = id3v1Tag.getGenreDescription()
        var comm = id3v1Tag.getComment()
        println(version)
        if (version != "1") {
            return 1
        }
        println(track)
        if (track != "1") {
            return 1
        }
        println(artist)
        if (artist != "ARTIST123456789012345678901234") {
            return 1
        }
        println(title)
        if (title != "TITLE1234567890123456789012345") {
            return 1
        }
        println(album)
        if (album != "ALBUM1234567890123456789012345") {
            return 1
        }
        println(year)
        if (year != "2001") {
            return 1
        }
        println(genre)
        if (genre != 13) {
            return 1
        }
        println(des)
        if (des != "Pop") {
            return 1
        }
        println(comm)
        if (comm != "COMMENT123456789012345678901") {
            return 1
        }
        var pack: Array<Byte> = BufferTools.transInt8ArrayToUInt8(id3v1Tag.toBytes())
        println(pack.toString())
        var res = BufferTools.byteBufferToString(pack, 0, 128)
        println(res)
    }
    0
}


