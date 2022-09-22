// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var buffer: Array<Int8> = loadFile("../../../../test/LLT/id3v2Test/testv2File/v1andv23tags.mp3")
    var tag_23: Option<AbstractID3v2Tag> = ID3v2TagFactory.createTag(buffer)
    match (tag_23) {
        case Some(x) => if (showV323(x) == 1) {
                return 1
            }
        case None => ()
    }
    0
}

func loadFile(filename: String): Array<Int8> {
    return BufferTools.transUInt8ArrayToInt8(File.readFrom(filename))
}

func showV323(id3v23: AbstractID3v2Tag): Int64 {
    match (id3v23 as ID3v23Tag) {
        case Some(x) =>
            if (Int64(x.getDataLength()) != 1089) {
                return 1
            }
            if (Int64(x.getLength()) != 1099) {
                return 1
            }
            println("id3v23 getDataLength ==> ${x.getDataLength()}")
            println("id3v23 getLength ==> ${x.getLength()}")
            println("id3v23 hasUnsynchronisation ==> ${x.hasUnsynchronisation()}")
            var id3v2Frame: HashMap<String, ID3v2FrameSet> = x.getFrameSets()
            if (id3v2Frame.size != 12) {
                return 1
            }
            showId3v2Frame(id3v2Frame)
        case None => return 1
    }
    0
}

func showId3v2Frame(id3v2Frame: HashMap<String, ID3v2FrameSet>) {
    println("id3v2FrameMap =======> ")
    println("id3v2FrameMap.size =======> ${id3v2Frame.size}")
    for ((k, v) in id3v2Frame) {
        println("")
        println("")
        println("id3v2Frame =======> start")
        println("id3v2FrameMap key =======> ${k}")
        println("id3v2FrameMap val =======> ${v.toString()}")
        for (f in v.getFrames()) {
            println("id3v2Frame getId val =======> ${f.getId()}")
            println("id3v2Frame getDataLength val =======> ${f.getDataLength()}")
            println("id3v2Frame getLength val =======> ${f.getLength()}")
            println("id3v2Frame getData val =======> ${f.getData()}")
            println("id3v2Frame hasDataLengthIndicator val =======> ${f.hasDataLengthIndicator()}")
            println("id3v2Frame hasCompression val =======> ${f.hasCompression()}")
            println("id3v2Frame hasEncryption val =======> ${f.hasEncryption()}")
            println("id3v2Frame hasGroup val =======> ${f.hasGroup()}")
            println("id3v2Frame hasPreserveFile val =======> ${f.hasPreserveFile()}")
            println("id3v2Frame hasPreserveTag val =======> ${f.hasPreserveTag()}")
            println("id3v2Frame hasUnsynchronisation val =======> ${f.hasUnsynchronisation()}")
            println("id3v2Frame isReadOnly val =======> ${f.isReadOnly()}")
        }
        println("id3v2Frame =======> end")
        println("")
        println("")
    }
}
