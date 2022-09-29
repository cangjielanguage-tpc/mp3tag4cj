// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*


main() {
    try{
        var mp3file1:Mp3File=Mp3File("../../../../test/LLT/bugfix/testfiles/notanmp3.mp3")
        println(mp3file1.getStartOffset())
        println(mp3file1.getXingOffset())
        println(mp3file1.getEndOffset())
        println(mp3file1.getXingBitrate())
    } catch (e: Exception){
        if (e.toString() != "Exception: No mpegs frames found"){
            return 1
        }
    }
    return 0
}


