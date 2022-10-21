// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var iD3v2Frame1: ID3v2Frame = ID3v2Frame("C", [1, 0, 1, 0])
    var hashCode1 = iD3v2Frame1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var iD3v2Frame2: ID3v2Frame = ID3v2Frame("C", [1, 0, 1, 0])
    var hashCode2 = iD3v2Frame2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var iD3v2Frame3: ID3v2Frame = ID3v2Frame("C", [1, 0, 1, 0])
    var bytes1: Array<Int8> = Array<Int8>(Int64(iD3v2Frame3.getLength()), {i => 0})
    var bytes2: Array<Int8> = Array<Int8>(Int64(iD3v2Frame3.getLength()), {i => 0})
    iD3v2Frame3.toBytes(bytes1, 0)
    //[67, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1, 0, 1, 0] 4 标识 4长度 2标志 + 内容
    println("bytes1 ==> ${bytes1}")
    iD3v2Frame3.setData([0, 1, 0, 1])
    iD3v2Frame3.toBytes(bytes2, 0)
    println("bytes2 ==> ${bytes2}")
    var hashCode3 = iD3v2Frame3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    if (hashCode1 != hashCode2) {
        return 1
    }
    if (hashCode2 == hashCode3){
        return 1
    }
    if (bytes1 != [67, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1, 0, 1, 0]) {
        return 1
    }
    if (bytes2 != [67, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1, 0, 1]){
        return 1
    }
    0
}
