// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3")
    var tag_23: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    match(tag_23) {
        case Some(x) => if (showV323(x) == 1) { return 1 }
        case None => ()
    }
    0
}

func showV323(id3v23: AbstractID3v2Tag): Int64{
    match(id3v23 as ID3v23Tag) {
        case Some(x) =>
        if (testSetTitle(x) == 1) { return 1 }
        case None => return 1
    }
    0
}

func testSetTitle(id3v23: ID3v23Tag) : Int64{
    var getDataLength: Int32 = id3v23.getDataLength()
    if (getDataLength != 3137){ return 1 }
    var Unsynchronisation: Bool = id3v23.hasUnsynchronisation()
    if (Unsynchronisation != false) { return 1 }
    var title: String = id3v23.getTitle().getOrThrow()
    if (title != "TITLE1234567890123456789012345") { return 1 }
    id3v23.setTitle("中文标题")
    title = id3v23.getTitle().getOrThrow()
    if (title != "中文标题") { return 1 }
    getDataLength = id3v23.getDataLength()
    if (getDataLength != 2663) { return 1 }
    return 0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}



