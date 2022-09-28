// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var file = FileInfo("../../../../test/LLT/id3v2Test/testv2File/nofile.mp3")
    try {
        var mp3File: FileWrapper = FileWrapper(file)
    }catch (e: Exception){
        if (e.toString() != "IllegalArgumentException: File path exception"){
            return 1
        }
    }
    0
}
