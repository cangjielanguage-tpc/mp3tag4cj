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
public class Mp3agic_MutableInteger_001 {
    @TestCase
    func mp3agic_MutableInteger_001(): Unit {
        var mutableInteger: MutableInteger = MutableInteger(2147483646) //最大int32位值
        mutableInteger.increment()
        @Assert(mutableInteger.getValue(),2147483647)

        var mutableInteger1: MutableInteger = MutableInteger(-2147483648) //最小int32位值
        mutableInteger1.increment()
        @Assert(mutableInteger1.getValue(),-2147483647)

        var mutableInteger2: MutableInteger = MutableInteger(10000) //int32位值
        mutableInteger2.increment()
        @Assert(mutableInteger2.getValue(),10001)
    }
}
