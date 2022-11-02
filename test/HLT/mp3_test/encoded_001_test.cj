// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/charset/build/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
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
public class EncodedTestA {
    var CHARSET_ISO_8859_1: String = "iso-8859-1"
    var CHARSET_UTF_16: String = "UTF-16LE"
    var CHARSET_UTF_16BE: String = "UTF-16BE"
    var CHARSET_UTF_8: String = "UTF-8"

    var string: String = "string"
    var stringNull: String = ""
    var stringNormal: String = "中文"

    var TEXT_ENCODING_ISO_8859_1: Int8 = 0
    var TEXT_ENCODING_UTF_16: Int8 = 1
    var TEXT_ENCODING_UTF_16BE: Int8 = 2
    var TEXT_ENCODING_UTF_8: Int8 = 3
    var int1: Int8 = 5
    var int2: Int8 = -1

    // 接口测试:init (string: String) ???特殊编码格式如何获取对应字符串?
    // 接口测试:init (textEncoding: Int8, string: String)
    @TestCase
    func encoded_test_01(): Unit {
        // 普通字符串为CHARSET_ISO_8859_1
        var cText1: EncodedText = EncodedText(string)
        @Expect(cText1.getCharacterSet(), CHARSET_ISO_8859_1)

        // 默认为CHARSET_ISO_8859_1
        var cText2: EncodedText = EncodedText(stringNull)
        @Expect(cText2.getCharacterSet(), CHARSET_ISO_8859_1)

        // 中文识别为CHARSET_UTF_16BE
        var cText3: EncodedText = EncodedText(stringNormal)
        @Expect(cText3.getCharacterSet(), CHARSET_UTF_16BE)

        // 0-CHARSET_ISO_8859_1
        var eText1: EncodedText = EncodedText(TEXT_ENCODING_ISO_8859_1, string)
        @Expect(eText1.getCharacterSet(), CHARSET_ISO_8859_1)
        var eText2: EncodedText = EncodedText(TEXT_ENCODING_ISO_8859_1, stringNull)
        @Expect(eText2.getCharacterSet(), CHARSET_ISO_8859_1)
        var eText3: EncodedText = EncodedText(TEXT_ENCODING_ISO_8859_1, stringNormal)
        @Expect(eText3.getCharacterSet(), CHARSET_ISO_8859_1)

        // 1-CHARSET_UTF_16
        var eText4: EncodedText = EncodedText(TEXT_ENCODING_UTF_16, string)
        @Expect(eText4.getCharacterSet(), CHARSET_UTF_16)
        var eText5: EncodedText = EncodedText(TEXT_ENCODING_UTF_16, stringNull)
        @Expect(eText5.getCharacterSet(), CHARSET_UTF_16)
        var eText6: EncodedText = EncodedText(TEXT_ENCODING_UTF_16, stringNormal)
        @Expect(eText6.getCharacterSet(), CHARSET_UTF_16)

        // 2-CHARSET_UTF_16BE
        var eText7: EncodedText = EncodedText(TEXT_ENCODING_UTF_16BE, string)
        @Expect(eText7.getCharacterSet(), CHARSET_UTF_16BE)
        var eText8: EncodedText = EncodedText(TEXT_ENCODING_UTF_16BE, stringNull)
        @Expect(eText8.getCharacterSet(), CHARSET_UTF_16BE)
        var eText9: EncodedText = EncodedText(TEXT_ENCODING_UTF_16BE, stringNormal)
        @Expect(eText9.getCharacterSet(), CHARSET_UTF_16BE)

        // 3-CHARSET_UTF_8
        var eText10: EncodedText = EncodedText(TEXT_ENCODING_UTF_8, string)
        @Expect(eText10.getCharacterSet(), CHARSET_UTF_8)
        var eText11: EncodedText = EncodedText(TEXT_ENCODING_UTF_8, stringNull)
        @Expect(eText11.getCharacterSet(), CHARSET_UTF_8)
        var eText12: EncodedText = EncodedText(TEXT_ENCODING_UTF_8, stringNormal)
        @Expect(eText12.getCharacterSet(), CHARSET_UTF_8)

        var flag = false
        try {
            var eText13: EncodedText = EncodedText(int1, string)
            @Expect(eText13.getCharacterSet(), CHARSET_ISO_8859_1)
        } catch (e: Exception) {
            println("encoded_test_01 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
        flag = false

        try {
            var eText14: EncodedText = EncodedText(int2, string)
            @Expect(eText14.getCharacterSet(), CHARSET_ISO_8859_1)
        } catch (e: Exception) {
            println("encoded_test_01 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
    }

    //接口测试:init (textEncoding: Int8, string: String)
    @TestCase
    func encoded_test_02(): Unit {
        // 0-TEXT_ENCODING_ISO_8859_1
        var eText1: EncodedText = EncodedText(TEXT_ENCODING_ISO_8859_1, string)
        @Expect(eText1.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)
        var eText2: EncodedText = EncodedText(TEXT_ENCODING_ISO_8859_1, stringNull)
        @Expect(eText2.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)
        var eText3: EncodedText = EncodedText(TEXT_ENCODING_ISO_8859_1, stringNormal)
        @Expect(eText3.getTextEncoding(), TEXT_ENCODING_ISO_8859_1)

        // 1-TEXT_ENCODING_UTF_16
        var eText4: EncodedText = EncodedText(TEXT_ENCODING_UTF_16, string)
        @Expect(eText4.getTextEncoding(), TEXT_ENCODING_UTF_16)
        var eText5: EncodedText = EncodedText(TEXT_ENCODING_UTF_16, stringNull)
        @Expect(eText5.getTextEncoding(), TEXT_ENCODING_UTF_16)
        var eText6: EncodedText = EncodedText(TEXT_ENCODING_UTF_16, stringNormal)
        @Expect(eText6.getTextEncoding(), TEXT_ENCODING_UTF_16)

        // 2-TEXT_ENCODING_UTF_16BE
        var eText7: EncodedText = EncodedText(TEXT_ENCODING_UTF_16BE, string)
        @Expect(eText7.getTextEncoding(), TEXT_ENCODING_UTF_16BE)
        var eText8: EncodedText = EncodedText(TEXT_ENCODING_UTF_16BE, stringNull)
        @Expect(eText8.getTextEncoding(), TEXT_ENCODING_UTF_16BE)
        var eText9: EncodedText = EncodedText(TEXT_ENCODING_UTF_16BE, stringNormal)
        @Expect(eText9.getTextEncoding(), TEXT_ENCODING_UTF_16BE)

        // 3-TEXT_ENCODING_UTF_8
        var eText10: EncodedText = EncodedText(TEXT_ENCODING_UTF_8, string)
        @Expect(eText10.getTextEncoding(), TEXT_ENCODING_UTF_8)
        var eText11: EncodedText = EncodedText(TEXT_ENCODING_UTF_8, stringNull)
        @Expect(eText11.getTextEncoding(), TEXT_ENCODING_UTF_8)
        var eText12: EncodedText = EncodedText(TEXT_ENCODING_UTF_8, stringNormal)
        @Expect(eText12.getTextEncoding(), TEXT_ENCODING_UTF_8)

        var flag = false
        try {
            var eText13: EncodedText = EncodedText(int1, "UTF-8")
            @Expect(eText13.getTextEncoding(), int1)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
        flag = false

        try {
            var eText14: EncodedText = EncodedText(int2, "UTF-8")
            @Expect(eText14.getTextEncoding(), int2)
        } catch (e: Exception) {
            println("encoded_test_02 error: ${e.toString()}")
            flag = true
        }
        @Assert(flag, true)
    }
}
