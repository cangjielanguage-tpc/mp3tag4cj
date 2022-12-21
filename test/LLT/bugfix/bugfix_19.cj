// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import collection.*
from std import io.*
from std import fs.*
from std import math.*

main() {
    var id3tag = ID3v24Tag()
    println(id3tag.getPadding())
    if (id3tag.getPadding() != false) {
        return 1
    }
    id3tag.setPadding(true)
    println(id3tag.getPadding())
    if (id3tag.getPadding() != true) {
        return 1
    }
    0
}
