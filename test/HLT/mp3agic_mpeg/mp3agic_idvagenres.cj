// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

@Test
public class Mp3agic_Id3v1genres_001 {
    @TestCase
    func id3v1Genres(): Unit {
        var style: Int32 = ID3v1Genres.matchGenreDescription(Option<String>.Some("")) //空字符串
        @Assert(style,-1)

        var style1: Int32 = ID3v1Genres.matchGenreDescription(Option<String>.Some("Blues")) //最小编号
        @Assert(style1,0)

        var style2: Int32 = ID3v1Genres.matchGenreDescription(Option<String>.Some("Synthpop")) //最大编号
        @Assert(style2,147)

        var style3: Int32 = ID3v1Genres.matchGenreDescription(Option<String>.Some("cangjie")) //无效编号
        @Assert(style3,-1)
    }
}
