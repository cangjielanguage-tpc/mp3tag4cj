// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from mp3agic import mp3agic.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var file = Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23andcustomtags_updateGenNumAndDes.mp3")
    if (file.hasId3v2Tag()){
        var id3v2Tag = file.getId3v2Tag().getOrThrow()
        var genre = id3v2Tag.getGenre()
        var des = id3v2Tag.getGenreDescription()
        var ob = id3v2Tag.getObseleteFormat()
        if (ob != false){
            return 1
        }
        if (genre != -1){
            return 1
        }
        if (des != "Poq"){
            return 1
        }
    }
    0
}


