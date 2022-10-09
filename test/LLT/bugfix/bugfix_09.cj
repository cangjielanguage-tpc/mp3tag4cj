// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/bugfix/testfiles/obsolete-noimage.mp3")
    var tag2: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
    tag2.setTrack("中文track")
    if (showV322(tag2) == 1) {
        return 1
    }
    return 0
}

func showV322(id3v22: ID3v2): Int64 {
    match (id3v22 as ID3v22Tag) {
        case Some(x) =>
            var version = x.getVersion()
            var track = x.getTrack()
            var partOfSet = x.getPartOfSet()
            var compilation = x.isCompilation()
            var grouping = x.getGrouping()
            var artist = x.getArtist()
            var albumArtist = x.getAlbumArtist()
            var title = x.getTitle()
            var album = x.getAlbum()
            var year = x.getYear()
            var date = x.getDate()
            var genre = x.getGenre()
            var bpm = x.getBPM()
            var key = x.getKey()
            var genreDescription = x.getGenreDescription()
            var composer = x.getComposer()
            var publisher = x.getPublisher()
            var originalArtist = x.getOriginalArtist()
            var copyright = x.getCopyright()
            var encoder = x.getEncoder()
            println("version ==> ${version}")
            println("track ==> ${track}")
            println("partOfSet ==> ${partOfSet}")
            println("compilation ==> ${compilation}")
            println("grouping ==> ${grouping}")
            println("artist ==> ${artist}")
            println("albumArtist ==> ${albumArtist}")
            println("title ==> ${title}")
            println("album ==> ${album}")
            println("year ==> ${year}")
            println("date ==> ${date}")
            println("genre ==> ${genre}")
            println("bpm ==> ${bpm}")
            println("key ==> ${key}")
            println("genreDescription ==> ${genreDescription}")
            println("composer ==> ${composer}")
            println("publisher ==> ${publisher}")
            println("originalArtist ==> ${originalArtist}")
            println("copyright ==> ${copyright}")
            println("encoder ==> ${encoder}")
            if (version != "2.0") {
                return 1
            }
            if (track != "2") {
                return 1
            }
            if (partOfSet != Option<String>.None) {
                return 1
            }
            if (compilation != false) {
                return 1
            }
            if (grouping != Option<String>.None) {
                return 1
            }
            if (artist != "ARTISTABCDEFGHIJKLMNOPQRSTUVWXYZ") {
                return 1
            }
            if (albumArtist != Option<String>.None) {
                return 1
            }
            if (title != "NAMEABCDEFGHIJKLMNOPQRSTUVWXYZ") {
                return 1
            }
            if (album != "ALBUMNAMEABCDEFGHIJKLMNOPQRSTUVWXYZ") {
                return 1
            }
            if (year != "2009") {
                return 1
            }
            if (date != Option<String>.None) {
                return 1
            }
            if (genre != 20) {
                return 1
            }
            if (bpm != -1) {
                return 1
            }
            if (key != Option<String>.None) {
                return 1
            }
            if (genreDescription != "Alternative") {
                return 1
            }
            if (composer != "COMPOSERNAMEABCDEFGHIJKLMNOPQRSTUVWXYZ") {
                return 1
            }
            if (publisher != Option<String>.None) {
                return 1
            }
            if (originalArtist != Option<String>.None) {
                return 1
            }
            if (copyright != Option<String>.None) {
                return 1
            }
            if (encoder != Option<String>.None) {
                return 1
            }
        case None => return 1
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}
