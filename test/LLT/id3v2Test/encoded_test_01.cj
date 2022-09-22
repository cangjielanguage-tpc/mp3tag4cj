// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
main() {
    //测试iso88591
    var text: EncodedText = EncodedText(0, [0x49,  0x60,  0x6D])
    var textStr = text.toString().getOrThrow()
    println("textStr ==> ${textStr}")
    if (textStr != "I`m"){
        return 1
    }
    //测试UTF-16LE
    var text2: EncodedText = EncodedText(1, [75, 109, -43, -117, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 76, 0, 69, 0])
    var textStr2 = text2.toString().getOrThrow()
    println("textStr2 ==> ${textStr2}")
    if(textStr2 != "测试UTF-16LE") {
        return 1
    }
    var text3: EncodedText = EncodedText(2, [109, 75, -117, -43, 0, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 66, 0, 69])
    var textStr3 = text3.toString().getOrThrow()
    println("textStr3 ==> ${textStr3}")
    if(textStr3 != "测试UTF-16BE") {
        return 1
    }
    var text4: EncodedText = EncodedText(3, [-26, -75, -117, -24, -81, -107, 85, 84, 70, 45, 56])
    var textStr4 = text4.toString().getOrThrow()
    println("textStr4 ==> ${textStr4}")
    if(textStr4 != "测试UTF-8") {
        return 1
    }
    0
}


