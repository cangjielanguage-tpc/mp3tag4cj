// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
from std import unittest.*
from std import unittest.testmacro.*
from std import io.*
from mp3agic import mp3agic.*

@Test
public class ID3v24TagTest {
    @TestCase
    func testInit(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var bytes = BufferTools.transUInt8ArrayToInt8(sb)

        var tag = ID3v24Tag()
        @Assert(tag.getDataLength(),0)
        tag = ID3v24Tag(bytes)
        @Assert(tag.getDataLength(),243005157)
    }

    @TestCase
    func testSetTrack(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setTrack(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setTrack(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setTrack(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_TRACK]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_TRACK)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setTrack(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_TRACK]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_TRACK)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetTrack(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getTrack(),None)
        tag3.setTrack(Some(str))
        @Assert(tag3.getTrack().getOrThrow(),str)
    }

    @TestCase
    func testSetGetFooter(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag = ID3v24Tag(sb2)
        @Assert(tag.getDataLength(), 243005157)
        tag.setFooter(false)
        @Assert(tag.getDataLength(), 243005157)
        @Assert(tag.hasFooter(),false)

        tag.setFooter(true)
        @Assert(tag.getDataLength(), 10) // ID3v24Tag.FOOTER_LENGTH
        @Assert(tag.hasFooter(),true)
    }

    @TestCase
    func testSetGetUnsynchronisation(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag = ID3v24Tag(sb2)
        @Assert(tag.getDataLength(), 243005157)
        tag.setUnsynchronisation(false)
        @Assert(tag.getDataLength(), 243005157)
        @Assert(tag.hasUnsynchronisation(),false)

        tag.setUnsynchronisation(true)
        @Assert(tag.getDataLength(), 0)
        @Assert(tag.hasUnsynchronisation(),true)
    }

    @TestCase
    func testGetObseleteFormat(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag = ID3v24Tag(sb2)
        @Assert(tag.getObseleteFormat(), false)
    }

    @TestCase
    func testSetPartOfSet(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setPartOfSet(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setPartOfSet(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setPartOfSet(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_PART_OF_SET]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_PART_OF_SET)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setPartOfSet(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_PART_OF_SET]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_PART_OF_SET)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetPartOfSet(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getPartOfSet(),None)
        tag3.setPartOfSet(Some(str))
        @Assert(tag3.getPartOfSet().getOrThrow(),str)
    }

    @TestCase
    func testSetCompilation(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setCompilation(true)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_COMPILATION]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_COMPILATION)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"1")
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setCompilation(false)
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_COMPILATION]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_COMPILATION)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"0")
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetCompilation(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.isCompilation(),false)
        tag3.setCompilation(true)
        @Assert(tag3.isCompilation(),true)
    }

    @TestCase
    func testSetGrouping(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setGrouping(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setGrouping(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setGrouping(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_GROUPING]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_GROUPING)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setGrouping(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_GROUPING]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_GROUPING)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetGrouping(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getGrouping(),None)
        tag3.setGrouping(Some(str))
        @Assert(tag3.getGrouping().getOrThrow(),str)
    }

    @TestCase
    func testSetArtist(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setArtist(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setArtist(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setArtist(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_ARTIST]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ARTIST)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setArtist(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_ARTIST]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ARTIST)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetArtist(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getArtist(),None)
        tag3.setArtist(Some(str))
        @Assert(tag3.getArtist().getOrThrow(),str)
    }

    @TestCase
    func testSetDate(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setDate(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setDate(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setDate(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_DATE]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_DATE)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setDate(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_DATE]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_DATE)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetDate(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getDate(),None)
        tag3.setDate(Some(str))
        @Assert(tag3.getDate().getOrThrow(),str)
    }

    @TestCase
    func testSetYear(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setYear(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setYear(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setYear(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_YEAR]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_YEAR)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setYear(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_YEAR]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_YEAR)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetYear(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getYear(),None)
        tag3.setYear(Some(str))
        @Assert(tag3.getYear().getOrThrow(),str)
    }

    @TestCase
    func testSetAlbum(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setAlbum(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setAlbum(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setAlbum(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_ALBUM]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ALBUM)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setAlbum(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_ALBUM]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ALBUM)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetAlbum(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getAlbum(),None)
        tag3.setAlbum(Some(str))
        @Assert(tag3.getAlbum().getOrThrow(),str)
    }

    @TestCase
    func testSetTitle(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setTitle(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setTitle(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setTitle(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_TITLE]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_TITLE)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setTitle(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_TITLE]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_TITLE)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetTitle(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getTitle(),None)
        tag3.setTitle(Some(str))
        @Assert(tag3.getTitle().getOrThrow(),str)
    }

    @TestCase
    func testSetBPM(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setBPM(-1)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setBPM(0)
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_BPM]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_BPM)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"0")
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setBPM(1)
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_BPM]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_BPM)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"1")
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetBPM(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getBPM(),-1)
        tag3.setBPM(1)
        @Assert(tag3.getBPM(),1)
    }

    @TestCase
    func testSetGenre(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setGenre(None<Int64>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setGenre(Some(-1))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setGenre(Some(0))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_GENRE]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_GENRE)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"(0)${ID3v1Genres.GENRES[0]}")
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setGenre(Some(ID3v1Genres.GENRES.size + 1))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_GENRE]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_GENRE)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"(${ID3v1Genres.GENRES.size+1})")
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetGenre(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getGenre(),-1)
        tag3.setGenre(Some(ID3v1Genres.GENRES.size + 1))
        @Assert(tag3.getGenre(),ID3v1Genres.GENRES.size+1)
    }

    @TestCase
    func testSetGenreDescription(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            try {
                tag.setGenreDescription(None<String>)
                @Assert(false)
            } catch (e: Exception) {
                @Assert(e.message, "Unknown genre: ")
            }
            try {
                tag.setGenreDescription(Some("abc"))
                @Assert(false)
            } catch (e: Exception) {
                @Assert(e.message, "Unknown genre: abc")
            }
            tag.setGenreDescription(Some(ID3v1Genres.GENRES[0]))
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_GENRE]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_GENRE)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"(0)${ID3v1Genres.GENRES[0]}")
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setGenreDescription(Some(ID3v1Genres.GENRES[1]))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_GENRE]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_GENRE)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),"(1)${ID3v1Genres.GENRES[1]}")
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetGenreDescription(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getGenreDescription(),"")
        tag3.setGenreDescription(Some(ID3v1Genres.GENRES[1]))
        @Assert(tag3.getGenreDescription(),ID3v1Genres.GENRES[1])
    }

    @TestCase
    func testSetKey(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setKey(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setKey(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setKey(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_KEY]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_KEY)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setKey(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_KEY]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_KEY)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetKey(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getKey(),None)
        tag3.setKey(Some(str))
        @Assert(tag3.getKey().getOrThrow(),str)
    }

    @TestCase
    func testSetPublisher(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setPublisher(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setPublisher(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setPublisher(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_PUBLISHER]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_PUBLISHER)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setPublisher(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_PUBLISHER]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_PUBLISHER)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetPublisher(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getPublisher(),None)
        tag3.setPublisher(Some(str))
        @Assert(tag3.getPublisher().getOrThrow(),str)
    }

    @TestCase
    func testSetCopyright(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setCopyright(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setCopyright(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setCopyright(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_COPYRIGHT]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_COPYRIGHT)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setCopyright(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_COPYRIGHT]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_COPYRIGHT)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetCopyright(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getCopyright(),None)
        tag3.setCopyright(Some(str))
        @Assert(tag3.getCopyright().getOrThrow(),str)
    }

    @TestCase
    func testSetOriginalArtist(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setOriginalArtist(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setOriginalArtist(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setOriginalArtist(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_ORIGINAL_ARTIST]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ORIGINAL_ARTIST)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setOriginalArtist(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_ORIGINAL_ARTIST]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ORIGINAL_ARTIST)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetOriginalArtist(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getOriginalArtist(),None)
        tag3.setOriginalArtist(Some(str))
        @Assert(tag3.getOriginalArtist().getOrThrow(),str)
    }

    @TestCase
    func testSetEncoder(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setEncoder(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setEncoder(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setEncoder(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_ENCODER]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ENCODER)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setEncoder(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_ENCODER]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_ENCODER)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetEncoder(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getEncoder(),None)
        tag3.setEncoder(Some(str))
        @Assert(tag3.getEncoder().getOrThrow(),str)
    }

    @TestCase
    func testSetComposer(): Unit {
        var str = "ID3 some track"
        var str2 = "ID3 another track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
        var tags = [ID3v24Tag(), ID3v24Tag(sb2)]

        for (tag in tags) {
            tag.setComposer(None<String>)
            var fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setComposer(Some(""))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,0)

            tag.setComposer(Some(str))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            var fs = fs_map[ID3v24Tag.ID_COMPOSER]
            var f_list = fs.getFrames()
            @Assert(f_list.size,1)
            var frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_COMPOSER)
            var frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str)
            @Assert(tag.getDataLength(),frame.getLength())

            tag.setComposer(Some(str2))
            fs_map = tag.getFrameSets()
            @Assert(fs_map.size,1)
            fs = fs_map[ID3v24Tag.ID_COMPOSER]
            f_list = fs.getFrames()
            @Assert(f_list.size,1)
            frame = f_list[0]
            @Assert(frame.getId(),ID3v24Tag.ID_COMPOSER)
            frameData = ID3v2TextFrameData(false, frame.getData())
            @Assert(frameData.getText().getOrThrow().toString().getOrThrow(),str2)
            @Assert(tag.getDataLength(),frame.getLength())
        }
    }

    @TestCase
    func testGetComposer(): Unit {
        var str = "ID3 some track"
        var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
        var sb2 = BufferTools.transUInt8ArrayToInt8(sb)

        var tag3 = ID3v24Tag()
        @Assert(tag3.getComposer(),None)
        tag3.setComposer(Some(str))
        @Assert(tag3.getComposer().getOrThrow(),str)
    }
}
