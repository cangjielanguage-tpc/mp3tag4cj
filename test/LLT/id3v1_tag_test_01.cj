// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var expt: Array<Int8> = [84, 65, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 49,
    50, 51, 52, 53, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1]
    var id3v1Tag: ID3v1Tag = ID3v1Tag()
    id3v1Tag.setArtist("我是谁我在哪")
    var bytes: Array<Int8> = id3v1Tag.toBytes()
    println("bytes[34] ==> ${bytes[34]}")
    if (bytes[34] != -120){
        return -1
    }
    var id3v1Tag2: ID3v1Tag = ID3v1Tag()
    id3v1Tag2.setArtist("123456")
    var buffer: Array<Int8> =  Array<Int8>(128 ,{ i => 0 })
    id3v1Tag2.toBytes(buffer)
    if (buffer != expt){
        return 1
    }
    var id3v1Tag3: ID3v1Tag = ID3v1Tag()
    id3v1Tag3.setArtist("123456")
    try {
        var buffer: Array<Int8> =  Array<Int8>(2 ,{ i => 0 })
        id3v1Tag3.toBytes(buffer)
    }catch (e: Exception){
        if (e.toString() != "Exception: TAG pack fail"){
            return 1
        }
    }
    0
}


