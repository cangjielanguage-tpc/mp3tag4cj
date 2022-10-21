// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var bytes: Array<Int8> = [Int8(UInt32('A')), Int8(UInt32('d')), Int8(UInt32('d')), Int8(UInt32('r')), Int8(UInt32('e')),
    Int8(UInt32('s')), Int8(UInt32('s')), Int8(0), Int8(0x00)]
    var popmFrame1: ID3v2PopmFrameData = ID3v2PopmFrameData(false, bytes)
    var hashCode1 = popmFrame1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var popmFrame2: ID3v2PopmFrameData = ID3v2PopmFrameData(false, 1)
    var hashCode2 = popmFrame2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var popmFrame3: ID3v2PopmFrameData = ID3v2PopmFrameData(false, bytes)
    var hashCode3 = popmFrame3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    var popmFrame4: ID3v2PopmFrameData = ID3v2PopmFrameData(false, 1)
    var hashCode4 = popmFrame4.hashCode()
    println("hashCode4 ==> ${hashCode4}")
    var popmFrame5: ID3v2PopmFrameData = ID3v2PopmFrameData(true, 1)
    var hashCode5 = popmFrame5.hashCode()
    println("hashCode5 ==> ${hashCode5}")
    if (hashCode1 == hashCode2 || hashCode2 == hashCode5){
        return 1
    }
    if (hashCode1 != hashCode3 || hashCode2 != hashCode4) {
        return 1
    }
    0
}
