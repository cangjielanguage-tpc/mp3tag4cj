// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/v24tagswithalbumimage.mp3")
    var hasId3v2Tag = mp3File.hasId3v2Tag()
    if (hasId3v2Tag != true) {
        return 1
    }
    var tagOp = mp3File.getId3v2Tag()
    var id3v24tag = (tagOp.getOrThrow() as AbstractID3v2Tag).getOrThrow()
	id3v24tag.setArtistUrl("testsetUrl")
	id3v24tag.setCommercialUrl("testsetUrl")
	id3v24tag.setCopyrightUrl("testsetUrl")
	id3v24tag.setAudiofileUrl("testsetUrl")
	id3v24tag.setAudioSourceUrl("testsetUrl")
	id3v24tag.setRadiostationUrl("testsetUrl")
	id3v24tag.setPaymentUrl("testsetUrl")
	id3v24tag.setPublisherUrl("testsetUrl")
	id3v24tag.setUrl("testsetUrl")
    mp3File.save("../../../../test/LLT/framedata/testfiles/save_v24tagswithalbumimage.mp3")
    var mp3FileSave: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/save_v24tagswithalbumimage.mp3")
    var hasId3v2TagSave = mp3FileSave.hasId3v2Tag()
    if (hasId3v2TagSave != true) {
        return 1
    }
    var tagOpSave = mp3FileSave.getId3v2Tag()
    var tagSave = (tagOpSave.getOrThrow() as AbstractID3v2Tag).getOrThrow()
    if (check02(tagSave) == 1) { return 1 }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}

func check02(id3v24tag: AbstractID3v2Tag): Int64{
    var artistUrl = id3v24tag.getArtistUrl();
    var commercialUrl = id3v24tag.getCommercialUrl();
    var copyrightUrl = id3v24tag.getCopyrightUrl();
    var audiofileUrl = id3v24tag.getAudiofileUrl();
    var audioSourceUrl = id3v24tag.getAudioSourceUrl();
    var radiostationUrl = id3v24tag.getRadiostationUrl();
    var paymentUrl = id3v24tag.getPaymentUrl();
    var publisherUrl = id3v24tag.getPublisherUrl();
    var url = id3v24tag.getUrl()
    if (artistUrl != "testsetUrl") { return 1 }
    if (commercialUrl != "testsetUrl") { return 1 }
    if (copyrightUrl != "testsetUrl") { return 1 }
    if (audiofileUrl != "testsetUrl") { return 1 }
    if (audioSourceUrl != "testsetUrl") { return 1 }
    if (radiostationUrl != "testsetUrl") { return 1 }
    if (paymentUrl != "testsetUrl") { return 1 }
    if (publisherUrl != "testsetUrl") { return 1 }
    if (url != "testsetUrl") { return 1 }
    0
}