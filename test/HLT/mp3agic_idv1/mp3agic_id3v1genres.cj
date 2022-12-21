// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class Mp3agic_ID3v1Genres {
    @TestCase
    func mp3agic_ID3v1Genres(): Unit {
        var style: Int32 = ID3v1Genres.matchGenreDescription("Blues") //最小风格编号
        @Assert(style,0)

        var style1: Int32 = ID3v1Genres.matchGenreDescription("Synthpop") //最大风格编号
        @Assert(style1,147)

        var style2: Int32 = ID3v1Genres.matchGenreDescription("cangjie") //输入风格之外
        @Assert(style2,-1)

        var style3: Int32 = ID3v1Genres.matchGenreDescription("") //输入空字符串风格
        @Assert(style3,-1)
    }
}
