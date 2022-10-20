// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var bytes1: Array<Int8> = [Int8(UInt32('A')), Int8(UInt32('d')), Int8(UInt32('d')), Int8(UInt32('r')), Int8(UInt32('e')),
    Int8(UInt32('s')), Int8(UInt32('s')), Int8(0), Int8(0x00)]
    var bytes2: Array<Int8> = [Int8(UInt32('A')), Int8(UInt32('d')), Int8(UInt32('d')), Int8(UInt32('r')), Int8(UInt32('e')),
    Int8(UInt32('s')), Int8(UInt32('s'))]
    var encodedText1: EncodedText = EncodedText(bytes1)
    var hashCode1 = encodedText1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var encodedText2: EncodedText = EncodedText(bytes2)
    var hashCode2 = encodedText2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var encodedText3: EncodedText = EncodedText("Address")
    var hashCode3 = encodedText3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    if (hashCode2 != hashCode3) {
        return 1
    }
    if (hashCode1 == hashCode2){
        return 1
    }
    0
}
