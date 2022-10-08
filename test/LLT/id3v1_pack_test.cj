// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var expt: Array<Byte> =  [84, 65, 71, 84, 73, 84, 76, 69, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 65, 82, 84, 73, 83, 84, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51,
    52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 65, 76, 66, 85, 77, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51,
    52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 50, 48, 48, 49, 67, 79, 77, 77, 69, 78, 84, 49, 50, 51, 52, 53, 54,
    55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 0, 1, 13]
    var expStr: String = BufferTools.byteBufferToString(expt,0, 128)
    var file = FileInfo("../../../../test/LLT/testFile/v1tag.mp3")
    var file2 = Mp3File(file)
     if (file2.hasId3v1Tag()){
         var id3v1Tag = file2.getId3v1Tag().getOrThrow()
         var bytes: Array<UInt8> = BufferTools.transInt8ArrayToUInt8(id3v1Tag.toBytes())
         var resStr: String = BufferTools.byteBufferToString(bytes,0, 128)
         if (bytes.size != 128) {
             println("bytesSize ==> ${bytes.size}")
             return 1
         }

         if (!resStr.equals(expStr)) {
             println("resStr ==> " + resStr)
             println("resStrsize ==> ${resStr.size}")
             return 1
         }
     }
    0
}


