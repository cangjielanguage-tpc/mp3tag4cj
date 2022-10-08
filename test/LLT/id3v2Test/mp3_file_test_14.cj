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
    try {
        var mp3File: FileWrapper = FileWrapper("../../../../test/LLT/id3v2Test/testv2File/nofile.mp3")
    }catch (e: Exception){
        if (e.toString() != "FSException: The `path` is invalid!"){
            return 1
        }
    }
    0
}
