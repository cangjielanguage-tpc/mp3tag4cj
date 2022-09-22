// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3",
        41, true)
    if (mp3File.hasId3v2Tag()) {
        mp3File.removeId3v2Tag()
    }
    if (mp3File.hasId3v2Tag()) {
        return 1
    }
    mp3File.save("../../../../test/LLT/id3v2Test/testv2File/remove_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    var mp3FileReMove23: Mp3File = Mp3File(
        "../../../../test/LLT/id3v2Test/testv2File/remove_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    var removeLength = mp3FileReMove23.getLength()
    if (removeLength != 2997) {
        return 1
    }
    var newId3v22 = ID3v22Tag()
    newId3v22.setTrack(Option<String>.Some("中文track"))
    newId3v22.setPartOfSet(Option<String>.Some("中文partofset"))
    newId3v22.setGrouping(Option<String>.Some("中文grouping"))
    newId3v22.setArtist(Option<String>.Some("中文artist"))
    newId3v22.setAlbumArtist(Option<String>.Some("中文AlbumArtist"))
    newId3v22.setTitle(Option<String>.Some("中文Title"))
    newId3v22.setAlbum(Option<String>.Some("中文Album"))
    newId3v22.setYear(Option<String>.Some("中文Year"))
    newId3v22.setDate(Option<String>.Some("9月16日"))
    newId3v22.setGenre(Option<Int64>.Some(0))
    newId3v22.setBPM(10)
    newId3v22.setKey(Option<String>.Some("中文key"))
    newId3v22.setGenreDescription(Option<String>.Some("Blues"))
    newId3v22.setComposer(Option<String>.Some("中文composer"))
    newId3v22.setPublisher(Option<String>.Some("中文Publisher"))
    newId3v22.setOriginalArtist(Option<String>.Some("中文OriginalArtist"))
    newId3v22.setCopyright(Option<String>.Some("中文Copyright"))
    newId3v22.setEncoder(Option<String>.Some("中文Encoder"))
    newId3v22.setFooter(true)
    newId3v22.setUnsynchronisation(true)
    newId3v22.setCompilation(true)
    mp3File.setId3v2Tag(Option<ID3v2>.Some(newId3v22))
    mp3File.save("../../../../test/LLT/id3v2Test/testv2File/set_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    var newMp3: Mp3File = Mp3File(
        "../../../../test/LLT/id3v2Test/testv2File/set_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    if (newMp3.hasId3v2Tag()) {
        var id3v2Tag = newMp3.getId3v2Tag().getOrThrow()
        if (showV323((id3v2Tag as AbstractID3v2Tag).getOrThrow()) == 1) {
            return 1
        }
        if (newMp3.getLength() != 3528) {
            return 1
        }
    }
    0
}

func showV323(id3v23: AbstractID3v2Tag): Int64 {
    match (id3v23 as AbstractID3v2Tag) {
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
            var id3v2Frame: HashMap<String, ID3v2FrameSet> = x.getFrameSets()
            var hasFooter: Bool = x.hasFooter()
            var padding: Bool = x.getPadding()
            var Unsynchronisation: Bool = x.hasUnsynchronisation()
            if (Int64(x.getDataLength()) != 521) {
                return 1
            }
            if (Int64(x.getLength()) != 531) {
                return 1
            }
            if (id3v2Frame.size != 18) {
                return 1
            }
            if (version != "2.0") {
                return 1
            }
            if (track != "中文track") {
                return 1
            }
            if (partOfSet != "中文partofset") {
                return 1
            }
            if (compilation != true) {
                return 1
            }
            if (grouping != "中文grouping") {
                return 1
            }
            if (artist != "中文artist") {
                return 1
            }
            if (albumArtist != "中文AlbumArtist") {
                return 1
            }
            if (title != "中文Title") {
                return 1
            }
            if (album != "中文Album") {
                return 1
            }
            if (year != "中文Year") {
                return 1
            }
            if (date != "9月16日") {
                return 1
            }
            if (genre != 0) {
                return 1
            }
            if (bpm != 10) {
                return 1
            }
            if (key != "中文key") {
                return 1
            }
            if (genreDescription != "Blues") {
                return 1
            }
            if (composer != "中文composer") {
                return 1
            }
            if (publisher != "中文Publisher") {
                return 1
            }
            if (originalArtist != "中文OriginalArtist") {
                return 1
            }
            if (copyright != "中文Copyright") {
                return 1
            }
            if (encoder != "中文Encoder") {
                return 1
            }
            if (hasFooter != false) {
                return 1
            }
            if (Unsynchronisation != true) {
                return 1
            }
        case None => println("Not id3v23")
    }
    0
}
