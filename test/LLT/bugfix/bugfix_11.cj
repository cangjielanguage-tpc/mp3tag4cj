// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var mp3: Mp3File = Mp3File("../../../../test/LLT/framedata/testfiles/v24tagswithalbumimage.mp3")
    var id3v24tag = mp3.getId3v2Tag().getOrThrow()
    if (check01(id3v24tag) == 1) { return 1 }
	id3v24tag.setArtistUrl("testsetUrl Artist")
	id3v24tag.setCommercialUrl("testsetUrl Commercial")
	id3v24tag.setCopyrightUrl("testsetUrl Copyright")
	id3v24tag.setAudiofileUrl("testsetUrl Audiofile")
	id3v24tag.setAudioSourceUrl("testsetUrl AudioSource")
	id3v24tag.setRadiostationUrl("testsetUrl Radiostation")
	id3v24tag.setPaymentUrl("testsetUrl Payment")
	id3v24tag.setPublisherUrl("testsetUrl Publisher")
	id3v24tag.setUrl("testset Url")
    if (check02(id3v24tag) == 1) { return 1 }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}

func check01(id3v24tag: ID3v2): Int64{
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

func check02(id3v24tag: ID3v2): Int64{
    var artistUrl = id3v24tag.getArtistUrl();
    var commercialUrl = id3v24tag.getCommercialUrl();
    var copyrightUrl = id3v24tag.getCopyrightUrl();
    var audiofileUrl = id3v24tag.getAudiofileUrl();
    var audioSourceUrl = id3v24tag.getAudioSourceUrl();
    var radiostationUrl = id3v24tag.getRadiostationUrl();
    var paymentUrl = id3v24tag.getPaymentUrl();
    var publisherUrl = id3v24tag.getPublisherUrl();
    var url = id3v24tag.getUrl()
    if (artistUrl != "testsetUrl Artist") { return 1 }
    if (commercialUrl != "testsetUrl Commercial") { return 1 }
    if (copyrightUrl != "testsetUrl Copyright") { return 1 }
    if (audiofileUrl != "testsetUrl Audiofile") { return 1 }
    if (audioSourceUrl != "testsetUrl AudioSource") { return 1 }
    if (radiostationUrl != "testsetUrl Radiostation") { return 1 }
    if (paymentUrl != "testsetUrl Payment") { return 1 }
    if (publisherUrl != "testsetUrl Publisher") { return 1 }
    if (url != "testset Url") { return 1 }
    0
}