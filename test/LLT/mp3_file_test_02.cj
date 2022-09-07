// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from mp3agic import mp3agic.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var file = FileInfo("../../../../test/LLT/testFile/v1tag.mp3")
    var file2 = Mp3File(file)
    if (file2.hasId3v1Tag()){
        var id3v1Tag = file2.getId3v1Tag().getOrThrow()
    }
    file2.save("../../../../test/LLT/testFile/saveV1tag3.mp3")
    0
}


