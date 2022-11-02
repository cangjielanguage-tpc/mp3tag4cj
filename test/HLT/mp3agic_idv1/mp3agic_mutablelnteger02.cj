// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*

@Test
public class mp3agic_MutableInteger_002 {
    @TestCase
    func mp3agic_MutableInteger_002(): Unit {
        var mutableInteger3: MutableInteger = MutableInteger(2147483646) //Value最大int32位
        mutableInteger3.setValue(10)
        @Assert(mutableInteger3.getValue(),10)

        var mutableInteger4: MutableInteger = MutableInteger(-2147483648) //Value最小int32位值
        mutableInteger4.setValue(-21474836)
        @Assert(mutableInteger4.getValue(),-21474836)

        var mutableInteger5: MutableInteger = MutableInteger(1000000) //Value int32位值
        mutableInteger5.setValue(10000)
        @Assert(mutableInteger5.getValue(),10000)
    }
}
