// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var charset1 = match(Charsets.forName("iso-8859-1")){
        case Some(cs) => cs
        case None => return -1
    }
    var charset2 = match(Charsets.forName("UTF-16LE")){
        case Some(cs) => cs
        case None => return -1
    }
    var charset3 = match(Charsets.forName("UTF-16BE")){
        case Some(cs) => cs
        case None => return -1
    }
    var charset4 = match(Charsets.forName("UTF-8")){
             case Some(cs) => cs
             case None => return -1
    }
    var srcBytes: Array<UInt8> = charset2.newEncoder().encode("测试UTF-16LE")
    println(BufferTools.transUInt8ArrayToInt8(srcBytes))
    if (BufferTools.transUInt8ArrayToInt8(srcBytes) != [75, 109, -43, -117, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 76, 0, 69, 0]){
        return 1
    }
    var srcBytes1: Array<UInt8> = charset3.newEncoder().encode("测试UTF-16BE")
    println(BufferTools.transUInt8ArrayToInt8(srcBytes1))
    if (BufferTools.transUInt8ArrayToInt8(srcBytes1) != [109, 75, -117, -43, 0, 85, 0, 84, 0, 70, 0, 45, 0, 49, 0, 54, 0, 66, 0, 69]){
        return 1
    }
    var srcBytes2: Array<UInt8> = charset4.newEncoder().encode("测试UTF-8")
    println(BufferTools.transUInt8ArrayToInt8(srcBytes2))
    if (BufferTools.transUInt8ArrayToInt8(srcBytes2) != [-26, -75, -117, -24, -81, -107, 85, 84, 70, 45, 56]){
        return 1
    }
    0
}


