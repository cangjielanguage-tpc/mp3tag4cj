// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v24tagswithalbumimage.mp3
// data_file:./v1tag.mp3
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_ID3v2_02 {
    @TestCase
    func mp3agic_Id3v2_001(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        println(id3V2Tag.getArtistUrl())
        println(id3V2Tag.getCommercialUrl())
        println(id3V2Tag.getCopyrightUrl())
        println(id3V2Tag.getAudiofileUrl())
        println(id3V2Tag.getAudioSourceUrl())
        println(id3V2Tag.getRadiostationUrl())
        println(id3V2Tag.getPaymentUrl())
        println(id3V2Tag.getPublisherUrl())
        println(id3V2Tag.getUrl())
        @Assert(id3V2Tag.getArtistUrl(),"OFFICIALARTISTURL23456789012345")
        @Assert(id3V2Tag.getCommercialUrl(),"COMMERCIALURL234567890123456789")
        @Assert(id3V2Tag.getCopyrightUrl(),"COPYRIGHTURL2345678901234567890")
        @Assert(id3V2Tag.getAudiofileUrl(),"OFFICIALAUDIOFILE23456789012345")
        @Assert(id3V2Tag.getAudioSourceUrl(),"OFFICIALAUDIOSOURCE234567890123")
        @Assert(id3V2Tag.getRadiostationUrl(),"INTERNETRADIOSTATIONURL23456783")
        @Assert(id3V2Tag.getPaymentUrl(),"PAYMENTURL234567890123456789012")
        @Assert(id3V2Tag.getPublisherUrl(),"PUBLISHERURL2345678901234567890")
        @Assert(id3V2Tag.getUrl(),"URL2345678901234567890123456789")
    }

    @TestCase
    func mp3agic_Id3v2_002(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setArtistUrl(Option<String>.Some(" "))
        id3V2Tag.setCommercialUrl(Option<String>.Some(" "))
        id3V2Tag.setCopyrightUrl(Option<String>.Some(" "))
        id3V2Tag.setAudiofileUrl(Option<String>.Some(" "))
        id3V2Tag.setAudioSourceUrl(Option<String>.Some(" "))
        id3V2Tag.setRadiostationUrl(Option<String>.Some(" "))
        id3V2Tag.setPaymentUrl(Option<String>.Some(" "))
        id3V2Tag.setPublisherUrl(Option<String>.Some(" "))
        id3V2Tag.setUrl(Option<String>.Some(" "))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl()," ")
        @Assert(id3V2Tag.getCommercialUrl()," ")
        @Assert(id3V2Tag.getCopyrightUrl()," ")
        @Assert(id3V2Tag.getAudiofileUrl()," ")
        @Assert(id3V2Tag.getAudioSourceUrl()," ")
        @Assert(id3V2Tag.getRadiostationUrl()," ")
        @Assert(id3V2Tag.getPaymentUrl()," ")
        @Assert(id3V2Tag.getPublisherUrl()," ")
        @Assert(id3V2Tag.getUrl()," ")
    }

    @TestCase
    func mp3agic_Id3v2_003(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setArtistUrl(Option<String>.Some(""))
        id3V2Tag.setCommercialUrl(Option<String>.Some(""))
        id3V2Tag.setCopyrightUrl(Option<String>.Some(""))
        id3V2Tag.setAudiofileUrl(Option<String>.Some(""))
        id3V2Tag.setAudioSourceUrl(Option<String>.Some(""))
        id3V2Tag.setRadiostationUrl(Option<String>.Some(""))
        id3V2Tag.setPaymentUrl(Option<String>.Some(""))
        id3V2Tag.setPublisherUrl(Option<String>.Some(""))
        id3V2Tag.setUrl(Option<String>.Some(""))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl(),"OFFICIALARTISTURL23456789012345")
        @Assert(id3V2Tag.getCommercialUrl(),"COMMERCIALURL234567890123456789")
        @Assert(id3V2Tag.getCopyrightUrl(),"COPYRIGHTURL2345678901234567890")
        @Assert(id3V2Tag.getAudiofileUrl(),"OFFICIALAUDIOFILE23456789012345")
        @Assert(id3V2Tag.getAudioSourceUrl(),"OFFICIALAUDIOSOURCE234567890123")
        @Assert(id3V2Tag.getRadiostationUrl(),"INTERNETRADIOSTATIONURL23456783")
        @Assert(id3V2Tag.getPaymentUrl(),"PAYMENTURL234567890123456789012")
        @Assert(id3V2Tag.getPublisherUrl(),"PUBLISHERURL2345678901234567890")
        @Assert(id3V2Tag.getUrl(),"URL2345678901234567890123456789")
    }

    @TestCase
    func mp3agic_Id3v2_004(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setArtistUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setCommercialUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setCopyrightUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setAudiofileUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setAudioSourceUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setRadiostationUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setPaymentUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setPublisherUrl(Option<String>.Some("你好仓颉"))
        id3V2Tag.setUrl(Option<String>.Some("你好仓颉"))
        mp3File.save("../../HLT/1COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl(),"你好仓颉")
        @Assert(id3V2Tag.getCommercialUrl(),"你好仓颉")
        @Assert(id3V2Tag.getCopyrightUrl(),"你好仓颉")
        @Assert(id3V2Tag.getAudiofileUrl(),"你好仓颉")
        @Assert(id3V2Tag.getAudioSourceUrl(),"你好仓颉")
        @Assert(id3V2Tag.getRadiostationUrl(),"你好仓颉")
        @Assert(id3V2Tag.getPaymentUrl(),"你好仓颉")
        @Assert(id3V2Tag.getPublisherUrl(),"你好仓颉")
        @Assert(id3V2Tag.getUrl(),"你好仓颉")
    }

    @TestCase
    func mp3agic_Id3v2_005(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setArtistUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setCommercialUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setCopyrightUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setAudiofileUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setAudioSourceUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setRadiostationUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setPaymentUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setPublisherUrl(Option<String>.Some("nihaocangjie"))
        id3V2Tag.setUrl(Option<String>.Some("nihaocangjie"))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getCommercialUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getCopyrightUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getAudiofileUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getAudioSourceUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getRadiostationUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getPaymentUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getPublisherUrl(),"nihaocangjie")
        @Assert(id3V2Tag.getUrl(),"nihaocangjie")
    }

    @TestCase
    func mp3agic_Id3v2_006(): Unit {
        var data: String = """
             741085296532963451747418529636374185296363741526363741085207410852
             08520852741085296532963451747418529636374185296363741526363741085207410852085
             208527410852965329634517474185296363741852963637415263637410852074108520852085274"""
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setArtistUrl(Option<String>.Some(data))
        id3V2Tag.setCommercialUrl(Option<String>.Some(data))
        id3V2Tag.setCopyrightUrl(Option<String>.Some(data))
        id3V2Tag.setAudiofileUrl(Option<String>.Some(data))
        id3V2Tag.setAudioSourceUrl(Option<String>.Some(data))
        id3V2Tag.setRadiostationUrl(Option<String>.Some(data))
        id3V2Tag.setPaymentUrl(Option<String>.Some(data))
        id3V2Tag.setPublisherUrl(Option<String>.Some(data))
        id3V2Tag.setUrl(Option<String>.Some(data))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl(),data)
        @Assert(id3V2Tag.getCommercialUrl(),data)
        @Assert(id3V2Tag.getCopyrightUrl(),data)
        @Assert(id3V2Tag.getAudiofileUrl(),data)
        @Assert(id3V2Tag.getAudioSourceUrl(),data)
        @Assert(id3V2Tag.getRadiostationUrl(),data)
        @Assert(id3V2Tag.getPaymentUrl(),data)
        @Assert(id3V2Tag.getPublisherUrl(),data)
        @Assert(id3V2Tag.getUrl(),data)
    }

    @TestCase
    func mp3agic_Id3v2_007(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setArtistUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setCommercialUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setCopyrightUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setAudiofileUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setAudioSourceUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setRadiostationUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setPaymentUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setPublisherUrl(Option<String>.Some("“*&$#"))
        id3V2Tag.setUrl(Option<String>.Some("“*&$#"))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl(),"“*&$#")
        @Assert(id3V2Tag.getCommercialUrl(),"“*&$#")
        @Assert(id3V2Tag.getCopyrightUrl(),"“*&$#")
        @Assert(id3V2Tag.getAudiofileUrl(),"“*&$#")
        @Assert(id3V2Tag.getAudioSourceUrl(),"“*&$#")
        @Assert(id3V2Tag.getRadiostationUrl(),"“*&$#")
        @Assert(id3V2Tag.getPaymentUrl(),"“*&$#")
        @Assert(id3V2Tag.getPublisherUrl(),"“*&$#")
        @Assert(id3V2Tag.getUrl(),"“*&$#")
    }

    @TestCase
    func mp3agic_Id3v2_008(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        id3V2Tag.setArtistUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setCommercialUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setCopyrightUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setAudiofileUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setAudioSourceUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setRadiostationUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setPaymentUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setPublisherUrl(Option<String>.Some("你好,nihaocangjie123"))
        id3V2Tag.setUrl(Option<String>.Some("你好,nihaocangjie123"))
        mp3File.save("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getCommercialUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getCopyrightUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getAudiofileUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getAudioSourceUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getRadiostationUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getPaymentUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getPublisherUrl(),"你好,nihaocangjie123")
        @Assert(id3V2Tag.getUrl(),"你好,nihaocangjie123")
    }

    @TestCase
    func mp3agic_Id3v2_009(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        println(id3V2Tag.getArtistUrl())
        id3V2Tag.clearFrameSet("WOAR")
        mp3File.save("../../HLT/clesr_COMM_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl().toString(),"None")
    }

    @TestCase
    func mp3agic_Id3v2_010(): Unit {
        var mp3File: Mp3File = Mp3File("../../HLT/clesr_COMM_v24tagswithalbumimage1.mp3")
        var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        println(id3V2Tag.getArtistUrl())
        id3V2Tag.clearFrameSet("WOAR")
        mp3File.save("../../HLT/1clesr_WOAR_v24tagswithalbumimage1.mp3")
        var mp3File01: Mp3File = Mp3File("../../HLT/1clesr_WOAR_v24tagswithalbumimage1.mp3")
        var id3V2Tag01: AbstractID3v2Tag = ((mp3File01.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
        @Assert(id3V2Tag.getArtistUrl().toString(),"None")
    }
}
