// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var text0: EncodedText = EncodedText("I`m", 0)
    var text: EncodedText = EncodedText("I`m")
    var bytes: Array<Int8> = text.toBytes()
    if (bytes != [0x49, 0x60, 0x6D]) {
        return 1
    }
    var text1: EncodedText = EncodedText("测试UTF-16LE", 1)
    var bytes1: Array<Int8> = text1.toBytes()
    var bytes11: Array<Int8> = text1.toBytes(true)
    var terminator: Array<Int8> = text1.getTerminator()
    if (bytes11 != [-1, -2, 75, 109, -43, -117, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 76, 0, 69, 0]){
        return 1
    }
    if (terminator != [0, 0]) {
        return 1
    }
    if (bytes1 != [75, 109, -43, -117, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 76, 0, 69, 0]) {
        return 1
    }
    var text2: EncodedText = EncodedText("测试UTF-16BE", 2)
    var bytes2: Array<Int8> = text2.toBytes()
    if (bytes2 != [109, 75, -117, -43, 0, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 66, 0, 69]) {
        return 1
    }
    var text3: EncodedText = EncodedText("测试UTF-8", 3)
    var bytes3: Array<Int8> = text3.toBytes()
    if (bytes3 != [-26, -75, -117, -24, -81, -107, 85, 84, 70, 45, 56]) {
        return 1
    }
    var text4: EncodedText = EncodedText("测试UTF-16BE")
    var textEncoding: Int8 = text4.getTextEncoding()
    var CharacterSet: String = text4.getCharacterSet()
    if (textEncoding != 2) {
        return 1
    }
    if (CharacterSet != "UTF-16BE") {
        return 1
    }
    var bytes4: Array<Int8> = text4.toBytes()
    if (bytes4 != [109, 75, -117, -43, 0, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 66, 0, 69]) {
        return 1
    }
    text4.setTextEncoding(1)
    var textEncodingNew: Int8 = text4.getTextEncoding()
    if (textEncodingNew != 1) {
        return 1
    }
    CharacterSet = text4.getCharacterSet()
    if (CharacterSet != "UTF-16LE") {
        return 1
    }
    bytes4 = text4.toBytes()
    var text5: EncodedText = EncodedText(1, "测试UTF-16BE")
    var bytes5: Array<Int8> = text5.toBytes()
    if (bytes4 != bytes5) {
        return 1
    }
    var e1: EncodedText = EncodedText("测试相等")
    var e2 = e1
    if (e1 != e2) {
        return 1
    }

    var e3: EncodedText = EncodedText("测试不等3")
    var e4: EncodedText = EncodedText("测试不等4")
    if (e3 == e4) {
        return 1
    }
    0
}
