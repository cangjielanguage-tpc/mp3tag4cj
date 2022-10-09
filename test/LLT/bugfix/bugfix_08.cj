// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var bytes: Array<Int8> = loadFile("../../../../test/LLT/bugfix/testfiles/obsolete-noimage.mp3")
    var tag2 = ID3v22Tag(bytes, false)
    tag2.setTrack("中文track");
    if (showV322(tag2) == 1) {
        return 1
    }
    return 0
}

func showV322(id3v22: ID3v22Tag): Int64 {
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
            if (version != "2.0") {
                return 1
            }
            if (track != "中文track") {
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
            if (artist != Option<String>.None) {
                return 1
            }
            if (albumArtist != Option<String>.None) {
                return 1
            }
            if (title != Option<String>.None) {
                return 1
            }
            if (album != Option<String>.None) {
                return 1
            }
            if (year != Option<String>.None) {
                return 1
            }
            if (date != Option<String>.None) {
                return 1
            }
            if (genre != -1) {
                return 1
            }
            if (bpm != -1) {
                return 1
            }
            if (key != Option<String>.None) {
                return 1
            }
            if (genreDescription != "") {
                return 1
            }
            if (composer != Option<String>.None) {
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
