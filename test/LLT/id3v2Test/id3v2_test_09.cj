// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var buffer: Array<Int8> = loadFile(
        "../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3")
    var tag_23: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    match (tag_23) {
        case Some(x) => if (showV323(x) == 1) {
                return 1
            }
        case None => ()
    }
    0
}

func showV323(id3v23: AbstractID3v2Tag): Int64 {
    match (id3v23 as ID3v23Tag) {
        case Some(x) =>
            showV323(x)
            x.getFrameSets().clear()
            if (showV323(x) == 1) {
                return 1
            }
            var dataLength: Int32 = x.getDataLength();
            if (dataLength != 3137) {
                return 1
            }
        case None => return 1
    }
    0
}

func setV323(id3v23: ID3v23Tag): Int64 {
    match (id3v23 as ID3v23Tag) {
        case Some(x) =>
            x.setTrack("中文track");
            x.setPartOfSet("中文PartOfSet");
            x.setCompilation(true);
            x.setGrouping("中文Grouping");
            x.setArtist("中文Artist");
            x.setAlbumArtist("中文AlbumArtist");
            x.setTitle("中文Title");
            x.setAlbum("中文Album");
            x.setYear("中文Year");
            x.setDate("中文Date");
            x.setGenre(0);
            x.setBPM(67);
            x.setKey("中文Key");
            x.setGenreDescription("Pop");
            x.setComposer("中文Composer");
            x.setPublisher("中文Publisher");
            x.setOriginalArtist("中文OriginalArtist");
            x.setCopyright("中文Copyright");
            x.setEncoder("中文Encoder");
        case None => return 1
    }
    0
}

func showV323(id3v23: ID3v23Tag): Int64 {
    match (id3v23 as ID3v23Tag) {
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
            if (track != Option<String>.None) {
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
