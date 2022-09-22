// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mp3FileSrc: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23andcustomtags.mp3", 41, true)
    mp3FileSrc.save("../../../../test/LLT/id3v2Test/testv2File/Savev1andv23andcustomtags.mp3")
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/Savev1andv23andcustomtags.mp3")
    if (mp3File.hasId3v2Tag()) {
        var id3v2: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
        match (id3v2 as ID3v23Tag) {
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
                if (version != "3.0") {
                    return 1
                }
                if (track != "1") {
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
                if (artist != "ARTIST123456789012345678901234") {
                    return 1
                }
                if (albumArtist != Option<String>.None) {
                    return 1
                }
                if (title != "TITLE1234567890123456789012345") {
                    return 1
                }
                if (album != "ALBUM1234567890123456789012345") {
                    return 1
                }
                if (year != "2001") {
                    return 1
                }
                if (date != Option<String>.None) {
                    return 1
                }
                if (genre != 13) {
                    return 1
                }
                if (bpm != -1) {
                    return 1
                }
                if (key != Option<String>.None) {
                    return 1
                }
                if (genreDescription != "Pop") {
                    return 1
                }
                if (composer != "COMPOSER23456789012345678901234") {
                    return 1
                }
                if (publisher != Option<String>.None) {
                    return 1
                }
                if (originalArtist != "ORIGARTIST234567890123456789012") {
                    return 1
                }
                if (copyright != "COPYRIGHT2345678901234567890123") {
                    return 1
                }
                if (encoder != "ENCODER234567890123456789012345") {
                    return 1
                }
            case None => return 1
        }
    }
    if (mp3File.hasId3v1Tag()) {
        var id3v1: ID3v1 = mp3File.getId3v1Tag().getOrThrow()
        match (id3v1 as ID3v1Tag) {
            case Some(x) =>
                var version = x.getVersion()
                var track = x.getTrack()
                var artist = x.getArtist()
                var title = x.getTitle()
                var album = x.getAlbum()
                var year = x.getYear()
                var genre = x.getGenre()
                var des = x.getGenreDescription()
                var comm = x.getComment()
                if (version != "1") {
                    return 1
                }
                if (track != "1") {
                    return 1
                }
                if (artist != "ARTIST123456789012345678901234") {
                    return 1
                }
                if (title != "TITLE1234567890123456789012345") {
                    return 1
                }
                if (album != "ALBUM1234567890123456789012345") {
                    return 1
                }
                if (year != "2001") {
                    return 1
                }
                if (genre != 13) {
                    return 1
                }
                if (des != "Pop") {
                    return 1
                }
                if (comm != "COMMENT123456789012345678901") {
                    return 1
                }
            case None => return 1
        }
    }
    var startOffset: Int32 = mp3File.getStartOffset()
    var xingOffset: Int32 = mp3File.getXingOffset()
    var endOffset: Int32 = mp3File.getEndOffset()
    var frameCount: Int32 = mp3File.getFrameCount()
    var bitrate: Int32 = mp3File.getBitrate()
    var xingBitrate: Int32 = mp3File.getXingBitrate()
    var bitrates: Map<Int32, MutableInteger> = mp3File.getBitrates()
    var channelMode: String = mp3File.getChannelMode()
    var emphasis: String = mp3File.getEmphasis()
    var layer: String = mp3File.getLayer()
    var lengthInMilliseconds: Int64 = mp3File.getLengthInMilliseconds()
    var lengthInSeconds: Int64 = mp3File.getLengthInSeconds()
    var modeExtension: String = mp3File.getModeExtension()
    var sampleRate: Int32 = mp3File.getSampleRate()
    var version: String = mp3File.getVersion()
    var copyright: Bool = mp3File.isCopyright()
    var original: Bool = mp3File.isOriginal()
    var vbr: Bool = mp3File.isVbr()
    if (startOffset != 1516) {
        return 1
    }
    if (xingOffset != 1099) {
        return 1
    }
    if (endOffset != 3967) {
        return 1
    }
    if (frameCount != 6) {
        return 1
    }
    if (bitrate != 125) {
        return 1
    }
    if (xingBitrate != 128) {
        return 1
    }
    if (channelMode != "Joint stereo") {
        return 1
    }
    if (emphasis != "None") {
        return 1
    }
    if (layer != "III") {
        return 1
    }
    if (lengthInMilliseconds != 156) {
        return 1
    }
    if (lengthInSeconds != 0) {
        return 1
    }
    if (modeExtension != "None") {
        return 1
    }
    if (sampleRate != 44100) {
        return 1
    }
    if (version != "1.0") {
        return 1
    }
    if (copyright != false) {
        return 1
    }
    if (original != true) {
        return 1
    }
    if (vbr != true) {
        return 1
    }
    if (bitrates.size != 5) {
        return 1
    }
    if (bitrates.get(224).getOrThrow().getValue() != 1) {
        return 1
    }
    if (bitrates.get(112).getOrThrow().getValue() != 1) {
        return 1
    }
    if (bitrates.get(96).getOrThrow().getValue() != 2) {
        return 1
    }
    if (bitrates.get(192).getOrThrow().getValue() != 1) {
        return 1
    }
    if (bitrates.get(32).getOrThrow().getValue() != 1) {
        return 1
    }
    0
}
