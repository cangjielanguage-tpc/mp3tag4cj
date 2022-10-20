// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var expectedBytes: Array<Int8> = [116, 111, 99, 49, 0, 3, 2, 99, 104, 49, 0, 99, 104, 50, 0, 84, 73, 84, 50, 0, 0,
    0, 12, 0, 0, 0, 72, 101, 108, 108, 111, 32, 116, 104, 101, 114, 101]
    var tocChapterFrame1: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false)
    var hashCode1 = tocChapterFrame1.hashCode()
    println("hashCode1 ==> ${hashCode1}")
    var tocChapterFrame2: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false, false, false, Option<String>.Some("a"),
    Option<Array<String>>.Some(["ch1", "ch2"]))
    var hashCode2 = tocChapterFrame2.hashCode()
    println("hashCode2 ==> ${hashCode2}")
    var tocChapterFrame3: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false, expectedBytes)
    var hashCode3 = tocChapterFrame3.hashCode()
    println("hashCode3 ==> ${hashCode3}")
    var tocChapterFrame4: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false)
    var hashCode4 = tocChapterFrame4.hashCode()
    println("hashCode4 ==> ${hashCode4}")
    var tocChapterFrame5: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false, false, false, Option<String>.Some("a"),
    Option<Array<String>>.Some(["ch1", "ch2"]))
    var hashCode5 = tocChapterFrame5.hashCode()
    println("hashCode5 ==> ${hashCode5}")
    var tocChapterFrame6: ID3v2ChapterTOCFrameData = ID3v2ChapterTOCFrameData(false, expectedBytes)
    var hashCode6 = tocChapterFrame6.hashCode()
    println("hashCode6 ==> ${hashCode6}")
    if (hashCode1 != hashCode4 || hashCode2 != hashCode5 || hashCode3 != hashCode6) {
        return 1
    }
    if (hashCode1 == hashCode2 || hashCode2 == hashCode3){
        return 1
    }
    0
}