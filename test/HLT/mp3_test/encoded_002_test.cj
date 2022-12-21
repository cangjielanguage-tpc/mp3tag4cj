// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/charset/build/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
package test

from std import unittest.*
from std import unittest.testmacro.*
from std import fs.*
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

// EncodedTest类验证
@Test
public class EncodedTestB {
    var TEXT_ENCODING_ISO_8859_1: Int8 = 0
    var TEXT_ENCODING_UTF_16: Int8 = 1
    var TEXT_ENCODING_UTF_16BE: Int8 = 2
    var TEXT_ENCODING_UTF_8: Int8 = 3
    var int1: Int8 = 5
    var int2: Int8 = -1

    var string: String = "string"
    var stringNull: String = ""
    var stringNormal: String = "中文"

    //接口测试:init (string: String, transcodeToTextEncoding: Int8)
    @TestCase
    func encoded_test_03(): Unit {
        // 0-TEXT_ENCODING_ISO_8859_1
        var eText1: EncodedText = EncodedText(string, TEXT_ENCODING_ISO_8859_1)
        @Expect(eText1.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)
        var eText2: EncodedText = EncodedText(stringNull, TEXT_ENCODING_ISO_8859_1)
        @Expect(eText2.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)

        var flag = false
        try {
            var eText3: EncodedText = EncodedText(stringNormal, TEXT_ENCODING_ISO_8859_1)
            @Expect(eText3.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
        flag = false

        // 1-TEXT_ENCODING_UTF_16
        var eText4: EncodedText = EncodedText(string, TEXT_ENCODING_UTF_16)
        @Expect(eText4.getTextEncoding(), TEXT_ENCODING_UTF_16)
        var eText5: EncodedText = EncodedText(stringNull, TEXT_ENCODING_UTF_16)
        @Expect(eText5.getTextEncoding(), TEXT_ENCODING_UTF_16)
        var eText6: EncodedText = EncodedText(stringNormal, TEXT_ENCODING_UTF_16)
        @Expect(eText6.getTextEncoding(), TEXT_ENCODING_UTF_16)

        // 2-TEXT_ENCODING_UTF_16BE
        var eText7: EncodedText = EncodedText(string, TEXT_ENCODING_UTF_16BE)
        @Expect(eText7.getTextEncoding(), TEXT_ENCODING_UTF_16BE)
        var eText8: EncodedText = EncodedText(stringNull, TEXT_ENCODING_UTF_16BE)
        @Expect(eText8.getTextEncoding(), TEXT_ENCODING_UTF_16BE)
        var eText9: EncodedText = EncodedText(stringNormal, TEXT_ENCODING_UTF_16BE)
        @Expect(eText9.getTextEncoding(), TEXT_ENCODING_UTF_16BE)

        // 3-TEXT_ENCODING_UTF_8
        var eText10: EncodedText = EncodedText(string, TEXT_ENCODING_UTF_8)
        @Expect(eText10.getTextEncoding(), TEXT_ENCODING_UTF_8)
        var eText11: EncodedText = EncodedText(stringNull, TEXT_ENCODING_UTF_8)
        @Expect(eText11.getTextEncoding(), TEXT_ENCODING_UTF_8)
        var eText12: EncodedText = EncodedText(stringNormal, TEXT_ENCODING_UTF_8)
        @Expect(eText12.getTextEncoding(), TEXT_ENCODING_UTF_8)

        try {
            var eText13: EncodedText = EncodedText("UTF-8", int1)
            @Expect(eText13.getTextEncoding(), int1)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
        flag = false

        try {
            var eText14: EncodedText = EncodedText("UTF-8", int2)
            @Expect(eText14.getTextEncoding(), int2)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
    }

    //接口测试:setTextEncoding (textEncoding: Int8): Unit
    @TestCase
    func encoded_test_04(): Unit {
        // 0-TEXT_ENCODING_ISO_8859_1
        var eText1: EncodedText = EncodedText(string)
        eText1.setTextEncoding(TEXT_ENCODING_ISO_8859_1)
        @Expect(eText1.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)

        // 1-TEXT_ENCODING_UTF_16
        var eText4: EncodedText = EncodedText(string)
        eText4.setTextEncoding(TEXT_ENCODING_UTF_16)
        @Expect(eText4.getTextEncoding(), TEXT_ENCODING_UTF_16)

        // 2-TEXT_ENCODING_UTF_16BE
        var eText7: EncodedText = EncodedText(string)
        eText7.setTextEncoding(TEXT_ENCODING_UTF_16BE)
        @Expect(eText7.getTextEncoding(), TEXT_ENCODING_UTF_16BE)

        // 3-TEXT_ENCODING_UTF_8
        var eText10: EncodedText = EncodedText(string)
        eText10.setTextEncoding(TEXT_ENCODING_UTF_8)
        @Expect(eText10.getTextEncoding(), TEXT_ENCODING_UTF_8)

        var flag = false
        try {
            var eText5: EncodedText = EncodedText(string)
            eText5.setTextEncoding(int1)
            @Expect(eText5.getTextEncoding(), int1)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
        flag = false

        try {
            var eText13: EncodedText = EncodedText(stringNormal)
            eText13.setTextEncoding(TEXT_ENCODING_ISO_8859_1)
            @Expect(eText13.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
        flag = false

        try {
            var eText14: EncodedText = EncodedText(string)
            eText14.setTextEncoding(int2)
            @Expect(eText14.getTextEncoding(), int2)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
    }
}
