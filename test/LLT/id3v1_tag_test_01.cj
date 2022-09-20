// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var id3v1Tag: ID3v1Tag = ID3v1Tag()
    id3v1Tag.setArtist("我是谁我在哪")
    var bytes: Array<Int8> = id3v1Tag.toBytes()
    if (bytes[34] != 26){
        return -1
    }
    0
}


