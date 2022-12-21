// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./dummyframes.mp3:./luomanshi.mp3:./notanmp3.mp3:./obsolete-noimage.mp3
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_Filename_001 {
    @TestCase
    func filEname_001(): Unit {
        var mp3file: Mp3File = Mp3File("dummyframes.mp3") //不同的文件
        @Assert(mp3file.getVersion(),"1.0")
        @Assert(mp3file.getLayer(),"III")
        @Assert(mp3file.getSampleRate(),44100)
        @Assert(mp3file.getChannelMode(),"Joint stereo")
        @Assert(mp3file.getModeExtension(),"None")
        @Assert(mp3file.isCopyright(),false)
        @Assert(mp3file.isOriginal(),true)
        @Assert(mp3file.getEmphasis(),"None")

        var mp3file1: Mp3File = Mp3File("luomanshi.mp3")
        @Assert(mp3file1.getVersion(),"1.0")
        @Assert(mp3file1.getLayer(),"III")
        @Assert(mp3file1.getSampleRate(),44100)
        @Assert(mp3file1.getChannelMode(),"Stereo")
        @Assert(mp3file1.getModeExtension(),"n/a")
        @Assert(mp3file1.isCopyright(),false)
        @Assert(mp3file1.isOriginal(),true)
        @Assert(mp3file1.getEmphasis(),"None")

        try {
            var mp3file2: Mp3File = Mp3File("notanmp3.mp3") //没有音频的文件 
            @Assert(mp3file2.getVersion(),"No mpegs frames found")
            @Assert(mp3file2.getLayer(),"III")
            @Assert(mp3file2.getSampleRate(),44100)
            @Assert(mp3file2.getChannelMode(),"Joint stereo")
            @Assert(mp3file2.getModeExtension(),"None")
            @Assert(mp3file2.isCopyright(),false)
            @Assert(mp3file2.isOriginal(),true)
            @Assert(mp3file2.getEmphasis(),"None")
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: No mpegs frames found")
        }
        var mp3file3: Mp3File = Mp3File("obsolete-noimage.mp3")
        @Assert(mp3file3.getVersion(),"1.0")
        @Assert(mp3file3.getLayer(),"III")
        @Assert(mp3file3.getSampleRate(),44100)
        @Assert(mp3file3.getChannelMode(),"Joint stereo")
        @Assert(mp3file3.getModeExtension(),"M/S stereo")
        @Assert(mp3file3.isCopyright(),false)
        @Assert(mp3file3.isOriginal(),true)
        @Assert(mp3file3.getEmphasis(),"None")
    }
}
