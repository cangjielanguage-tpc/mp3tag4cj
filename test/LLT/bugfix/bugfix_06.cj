// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var bytes: Array<Int8> = [0x49, 0x44, 0x33, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]
    var tag2 = ID3v22Tag(bytes, false)
    tag2.setTrack("中文track")
    var track = tag2.getTrack()
    println("track ==> ${track}")
    if (track != "中文track") {
        return 1
    }
    var bytes2: Array<Int8> = [0x49, 0x44, 0x33, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]
    var tag22 = ID3v22Tag(bytes2, true)
    tag22.setTrack("中文track")
    var track2 = tag22.getTrack()
    println("track2 ==> ${track2}")
    if (track2 != Option<String>.None) {
        return 1
    }
    return 0
}
