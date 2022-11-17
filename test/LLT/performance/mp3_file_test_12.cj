// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import time.*
from std import fs.*
from std import collection.*

main() {
    var stringToCopy: String = "TAG"
    var srcBytes: Array<Int8> = [84, 65, 71]
    var bytes: Array<Int8> = Array<Int8>(Int64(128), {i => 0})

    srcBytes.copyTo(bytes, 0, 0, Int64(srcBytes.size))
}


