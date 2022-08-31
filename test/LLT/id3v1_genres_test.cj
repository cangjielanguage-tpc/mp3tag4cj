// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*

main() {
    var res: Int32 = ID3v1Genres.matchGenreDescription("Synthpop")
    println(res)
    if (res != 147){
        return 1
    }
    var res2: Int32 = ID3v1Genres.matchGenreDescription("no")
    if (res2 != -1){
        return 1
    }
    0
}


