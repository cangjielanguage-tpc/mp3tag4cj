// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var buffer: Array<Int8> = [99, 104, 50, 0, 0, 0, 0, 1, 0, 0, 1, 124, 0, 0, 0, 3, 0, 0, 1, -112, 84, 73, 84, 50, 0,
    0, 0, 12, 0, 0, 0, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101]
    var chapterFrame1: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false)
    var hashCode1 = chapterFrame1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var chapterFrame2: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false, Option<String>.Some("a"), 1, 2, 3, 4)
    var hashCode2 = chapterFrame2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var chapterFrame3: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false, buffer)
    var hashCode3 = chapterFrame3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    var chapterFrame4: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false)
    var hashCode4 = chapterFrame4.hashCode()
    println("hashCode4 ==> ${hashCode4}")
    var chapterFrame5: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false, Option<String>.Some("a"), 1, 2, 3, 4)
    var hashCode5 = chapterFrame5.hashCode()
    println("hashCode5 ==> ${hashCode5}")
    var chapterFrame6: ID3v2ChapterFrameData = ID3v2ChapterFrameData(false, buffer)
    var hashCode6 = chapterFrame6.hashCode()
    println("hashCode6 ==> ${hashCode6}")
    if (hashCode1 == hashCode2 || hashCode2 == hashCode3){
        return 1
    }
    if (hashCode1 != hashCode4 || hashCode2 != hashCode5 || hashCode3 != hashCode6) {
        return 1
    }
    0
}
