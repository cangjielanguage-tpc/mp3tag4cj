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
    id3v24tag.clearFrameSet("WOAR");
    id3v24tag.clearFrameSet("WCOM");
    id3v24tag.clearFrameSet("WCOP");
    id3v24tag.clearFrameSet("WOAF");
    id3v24tag.clearFrameSet("WOAS");
    id3v24tag.clearFrameSet("WORS");
    id3v24tag.clearFrameSet("WPAY");
    id3v24tag.clearFrameSet("WPUB");
    id3v24tag.clearFrameSet("WXXX");
    if (check02(id3v24tag) == 1) { return 1 }
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
    if (artistUrl != Option<String>.None ) { return 1 }
    if (commercialUrl != Option<String>.None) { return 1 }
    if (copyrightUrl != Option<String>.None) { return 1 }
    if (audiofileUrl != Option<String>.None) { return 1 }
    if (audioSourceUrl != Option<String>.None) { return 1 }
    if (radiostationUrl != Option<String>.None) { return 1 }
    if (paymentUrl != Option<String>.None) { return 1 }
    if (publisherUrl != Option<String>.None) { return 1 }
    if (url != Option<String>.None) { return 1 }
    0
}