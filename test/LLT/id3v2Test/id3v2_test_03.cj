// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/id3v2Test/testv2File/v1andv23andcustomtags.mp3")
    var tag_23: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    match(tag_23) {
        case Some(x) => if (showV323(x) == 1) { return  1 }
        case None => ()
    }
    0
}

func showV323(id3v23: AbstractID3v2Tag): Int64{
    match(id3v23 as ID3v23Tag) {
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
            if (version != "3.0"){ return 1 }
			if (track != "1") { return 1 }
			if (partOfSet != Option<String>.None){ return 1 }
			if (compilation != false) { return 1 }
			if (grouping != Option<String>.None){ return 1 }
			if (artist != "ARTIST123456789012345678901234") { return 1 }
			if (albumArtist != Option<String>.None) { return 1 }
			if (title != "TITLE1234567890123456789012345") { return 1 }
			if (album != "ALBUM1234567890123456789012345") { return 1 }
			if (year != "2001") { return 1 }
			if (date != Option<String>.None) { return 1 }
			if (genre != 13) { return 1 }
			if (bpm != -1) { return 1 }
			if (key != Option<String>.None) { return 1 }
			if (genreDescription != "Pop") { return 1 }
			if (composer != "COMPOSER23456789012345678901234") { return 1 }
			if (publisher != Option<String>.None) { return 1 }
			if (originalArtist != "ORIGARTIST234567890123456789012") { return 1 }
			if (copyright != "COPYRIGHT2345678901234567890123") { return 1 }
			if (encoder != "ENCODER234567890123456789012345") { return 1 }
        case None => return 1
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}



