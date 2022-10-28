// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/framedata/testfiles/v24tagswithalbumimage.mp3")
    var tag_24: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    var id3v24tag = tag_24.getOrThrow()
    if (check01(id3v24tag) == 1) { return 1 }
	id3v24tag.setArtistUrl("testsetUrl")
	id3v24tag.setCommercialUrl("testsetUrl")
	id3v24tag.setCopyrightUrl("testsetUrl")
	id3v24tag.setAudiofileUrl("testsetUrl")
	id3v24tag.setAudioSourceUrl("testsetUrl")
	id3v24tag.setRadiostationUrl("testsetUrl")
	id3v24tag.setPaymentUrl("testsetUrl")
	id3v24tag.setPublisherUrl("testsetUrl")
	id3v24tag.setUrl("testsetUrl")
    if (check02(id3v24tag) == 1) { return 1 }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}

func check01(id3v24tag: AbstractID3v2Tag): Int64{
    var artistUrl = id3v24tag.getArtistUrl();
    var commercialUrl = id3v24tag.getCommercialUrl();
    var copyrightUrl = id3v24tag.getCopyrightUrl();
    var audiofileUrl = id3v24tag.getAudiofileUrl();
    var audioSourceUrl = id3v24tag.getAudioSourceUrl();
    var radiostationUrl = id3v24tag.getRadiostationUrl();
    var paymentUrl = id3v24tag.getPaymentUrl();
    var publisherUrl = id3v24tag.getPublisherUrl();
    var url = id3v24tag.getUrl()
    if (artistUrl != "OFFICIALARTISTURL23456789012345") { return 1 }
    if (commercialUrl != "COMMERCIALURL234567890123456789") { return 1 }
    if (copyrightUrl != "COPYRIGHTURL2345678901234567890") { return 1 }
    if (audiofileUrl != "OFFICIALAUDIOFILE23456789012345") { return 1 }
    if (audioSourceUrl != "OFFICIALAUDIOSOURCE234567890123") { return 1 }
    if (radiostationUrl != "INTERNETRADIOSTATIONURL23456783") { return 1 }
    if (paymentUrl != "PAYMENTURL234567890123456789012") { return 1 }
    if (publisherUrl != "PUBLISHERURL2345678901234567890") { return 1 }
    if (url != "URL2345678901234567890123456789") { return 1 }
    0
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