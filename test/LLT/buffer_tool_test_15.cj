// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

main() {
    var res = BufferTools.asciiOnly("ü12¬34ü567¬¬¬89ü")
    if (res != "?12?34?567???89?"){
        return 1
    }
    0
}
