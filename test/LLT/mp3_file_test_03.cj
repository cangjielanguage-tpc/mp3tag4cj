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
    var mp3File = Mp3File(file)
    if (mp3File.hasId3v1Tag()){
        var id3v1Tag = mp3File.getId3v1Tag().getOrThrow()
        showId3v1(id3v1Tag)
        id3v1Tag.setTrack(Option<String>.Some(""))
        id3v1Tag.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v1Tag.setTitle(Option<String>.Some("NEWTITLE67890"))
        id3v1Tag.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v1Tag.setYear(Option<String>.Some("19940821"))
        id3v1Tag.setGenre(Option<Int64>.Some(20))
        id3v1Tag.setComment(Option<String>.Some("NEWCOMMENT123456"))
    }
    mp3File.save("../../../../test/LLT/testFile/v1tagNew.mp3")
    var file2 = FileInfo("../../../../test/LLT/testFile/v1tagNew.mp3")
    var mp3FileNew = Mp3File(file2)
    if (mp3FileNew.hasId3v1Tag()){
        var id3v1Tag = mp3FileNew.getId3v1Tag().getOrThrow()
        showId3v1(id3v1Tag)
        var res = checkId3v1(id3v1Tag)
        if (res == 1) {
            return 1
        }
    }
    0
}
func checkId3v1(id3v1Tag: ID3v1): Int64{
    if (id3v1Tag.getVersion() != "0") {
        return 1
    }
    if (id3v1Tag.getTrack() != "") {
        return 1
    }
    if (id3v1Tag.getArtist() != "NEWARTIST12345678901234567890") {
        return 1
    }
    if (id3v1Tag.getTitle() != "NEWTITLE67890") {
        return 1
    }
    if (id3v1Tag.getAlbum() != "NEWALBUM1234567890123456789011") {
        return 1
    }
    if (id3v1Tag.getYear() != "1994") {
        return 1
    }
    if (id3v1Tag.getGenre() != 20) {
        return 1
    }
    if (id3v1Tag.getComment() != "NEWCOMMENT123456") {
        return 1
    }
    if (id3v1Tag.getGenreDescription() != "Alternative") {
        return 1
    }
    return 0
}

func showId3v1(id3v1Tag: ID3v1) {
    var version = id3v1Tag.getVersion()
    var track = id3v1Tag.getTrack()
    var artist = id3v1Tag.getArtist()
    var title = id3v1Tag.getTitle()
    var album = id3v1Tag.getAlbum()
    var year = id3v1Tag.getYear()
    var genre = id3v1Tag.getGenre()
    var des = id3v1Tag.getGenreDescription()
    var comm = id3v1Tag.getComment()
    println("version ==> ${version}")
    println("track ==> ${track}")
    println("artist ==> ${artist}")
    println("title ==> ${title}")
    println("album ==> ${album}")
    println("year ==> ${year}")
    println("genre ==> ${genre}")
    println("comm ==> ${comm}")
    println("des ==> ${des}")
}


