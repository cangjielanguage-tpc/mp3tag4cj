// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import math.*

@Test
public class Mp3agic_MpegFrame {


    @TestCase
    func mp3agic_MpegFrame01(): Unit {
        var mpegFrame: MpegFrame = MpegFrame()
        mpegFrame.setProtection(12)
        mpegFrame.setPrivate(12)
        mpegFrame.setOriginal(12)
        @Assert(mpegFrame.getVersion(),"")
        @Assert(mpegFrame.getBitrate(),0)
        @Assert(mpegFrame.getSampleRate(),0)
        @Assert(mpegFrame.getChannelMode(),"")
        @Assert(mpegFrame.getModeExtension(),"")
        @Assert(mpegFrame.isCopyright(),false)
        @Assert(mpegFrame.isOriginal(),false)
    }


    @TestCase
    func mp3agic_MpegFrame02(): Unit {
        var mpegFrame: MpegFrame = MpegFrame()
        mpegFrame.setProtection(0)
        mpegFrame.setPrivate(0)
        mpegFrame.setOriginal(0)
        @Assert(mpegFrame.getVersion(),"")
        @Assert(mpegFrame.getBitrate(),0)
        @Assert(mpegFrame.getSampleRate(),0)
        @Assert(mpegFrame.getChannelMode(),"")
        @Assert(mpegFrame.getModeExtension(),"")
        @Assert(mpegFrame.isCopyright(),false)
        @Assert(mpegFrame.isOriginal(),false)
    }


    @TestCase
    func mp3agic_MpegFrame03(): Unit {
        try{
        var mpegFrame: MpegFrame = MpegFrame()
        mpegFrame.setProtection(12)
        mpegFrame.setPrivate(12)
        mpegFrame.setOriginal(12)
        mpegFrame.setEmphasis(12)
        @Assert(mpegFrame.getVersion(),"")
        @Assert(mpegFrame.getBitrate(),0)
        @Assert(mpegFrame.getSampleRate(),0)
        @Assert(mpegFrame.getChannelMode(),"")
        @Assert(mpegFrame.getModeExtension(),"")
        @Assert(mpegFrame.isCopyright(),false)
        @Assert(mpegFrame.isOriginal(),false)
        }catch(e:Exception){
        @Assert(e.toString(),"Exception: Invalid emphasis in frame header")
    }
    }


    @TestCase
    func mp3agic_MpegFrame04(): Unit {

        var expectedBytes1: Array<Int8> = [1, -1, 0, -2, -77, 3, -75, 3, -71, 3, -84, 3, 0, 0, 104, 116, 116, 112, 58, 47, 47]
        var abstr:AbstractID3v2Tag=AbstractID3v2Tag()
        abstr.packTag(expectedBytes1)
        abstr.setArtistUrl(Option<String>.Some("你好,nihaocangjie123"))
        @Assert(abstr.getArtistUrl(),"你好,nihaocangjie123")

    }



}