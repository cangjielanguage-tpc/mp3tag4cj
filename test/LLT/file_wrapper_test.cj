// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import fs.*

main() {
    var file = FileInfo("../../../../test/LLT/testFile/v1tag.mp3")
    var file2 = FileWrapper(file)
    println(file2.getFilename())
    println(file2.getFilename())
    println(file2.getLength())
    if (file2.getLength() != 2997){
        return 1
    }
    var file3 = FileWrapper("../../../../test/LLT/testFile/v1tag.mp3")
    println(file3.getFilename())
    println(file3.getFilename())
    println(file3.getLength())
    if (file3.getLength() != 2997){
        return 1
    }
    try{
        var file4 = FileWrapper("../../../../test/LLT/testFile/v1tagThrow.mp3")
    }catch(e: Exception){}
    0
}


