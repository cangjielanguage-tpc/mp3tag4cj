## mp3agic库

### 介绍

  一个用于读取mp3文件和读取/操作ID3标记（ID3v1和ID3v2.2到ID3v2.4）的库。参考：[https://github.com/mpatric/mp3agic](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fmpatric%2Fmp3agic) 

### 1读取、写入mp3文件并添加和删除ID3v1标签功能

前置条件：NA 
场景：
1. 解析和读取/操作ID3V1标签
2. 判断vbr文件，获得每个音频数据帧的位率
3. 保存文件

约束：
性能： 支持版本几何性能持平
可靠性： NA



#### 1.1 用于读取mp3文件和读取/操作ID3V1标签

##### 1.1.1 主要接口

可对ID3V1标签判断，获取，设置，删除。

```
/**
 * 是否包含ID3v1标签 核心接口
 *
 * @return Type of Bool
 * @since 0.31.4
 */
public func hasId3v1Tag (): Bool

/**
 * 获得ID3v1标签 核心接口
 *
 * @return Type of Option<ID3v1>
 * @since 0.31.4
 */
public func getId3v1Tag (): Option<ID3v1>

/**
 * 设置ID3v1标签 核心接口
 *
 * @param id3v1Tag of Option<ID3v1>
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func setId3v1Tag (id3v1Tag: Option<ID3v1>): Unit

/**
 * 移除ID3v1标签 核心接口
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func removeId3v1Tag (): Unit
```

##### 1.1.2 示例

```
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from std import fs.*
from mp3agic import mp3agic.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var file = FileInfo("../../../../test/LLT/testFile/v1tag.mp3")
    var mp3File = Mp3File(file)
    var id3v1: ID3v1Tag = ID3v1Tag()
    id3v1.setTrack(Option<String>.Some(""))
    id3v1.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
    id3v1.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
    id3v1.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
    id3v1.setYear(Option<String>.Some("19940821"))
    id3v1.setGenre(Option<Int64>.Some(20))
    id3v1.setComment(Option<String>.Some("NEWCOMMENT123456"))
    if (mp3File.hasId3v1Tag()){
        var id3v1Tag = mp3File.getId3v1Tag().getOrThrow()
        showId3v1(id3v1Tag)
    }
    mp3File.setId3v1Tag(Option<ID3v1>.Some(id3v1))
    mp3File.save("../../../../test/LLT/testFile/v1tagNew2.mp3")
    var file2 = FileInfo("../../../../test/LLT/testFile/v1tagNew2.mp3")
    var mp3FileNew = Mp3File(file2)
    if (mp3FileNew.hasId3v1Tag()){
        var id3v1Tag = mp3FileNew.getId3v1Tag().getOrThrow()
        showId3v1(id3v1Tag)
        var res = checkId3v1(id3v1Tag)
        if (res == 1) {
            return 1
        }
    }
    0
}
func checkId3v1(id3v1Tag: ID3v1): Int64{
    if (id3v1Tag.getVersion() != "0") {
        return 1
    }
    if (id3v1Tag.getTrack() != "") {
        return 1
    }
    if (id3v1Tag.getArtist() != "NEWARTIST12345678901234567890") {
        return 1
    }
    if (id3v1Tag.getTitle() != "NEWTITLE12345678901234567890") {
        return 1
    }
    if (id3v1Tag.getAlbum() != "NEWALBUM1234567890123456789011") {
        return 1
    }
    if (id3v1Tag.getYear() != "1994") {
        return 1
    }
    if (id3v1Tag.getGenre() != 20) {
        return 1
    }
    if (id3v1Tag.getComment() != "NEWCOMMENT123456") {
        return 1
    }
    if (id3v1Tag.getGenreDescription() != "Alternative") {
        return 1
    }
    return 0
}

func showId3v1(id3v1Tag: ID3v1) {
    var version = id3v1Tag.getVersion()
    var track = id3v1Tag.getTrack()
    var artist = id3v1Tag.getArtist()
    var title = id3v1Tag.getTitle()
    var album = id3v1Tag.getAlbum()
    var year = id3v1Tag.getYear()
    var genre = id3v1Tag.getGenre()
    var des = id3v1Tag.getGenreDescription()
    var comm = id3v1Tag.getComment()
}

```



#### 1.2 判断是否为VBR编码（可变位率）

##### 1.2.1 主要接口

```
/**
 * 是否为VBR编码（可变位率），不是为 CBR编码 核心接口
 *
 * @return Type of Bool
 */
public func isVbr(): Bool
```

##### 1.2.2 示例

```
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/爱的罗曼史.mp3", false)
    var startOffset: Int32 = mp3File.getStartOffset()
    var xingOffset: Int32 = mp3File.getXingOffset()
    var endOffset: Int32 = mp3File.getEndOffset()
    var frameCount: Int32 = mp3File.getFrameCount()
    var bitrate: Int32 = mp3File.getBitrate()
    var xingBitrate: Int32 = mp3File.getXingBitrate()
    var bitrates: Map<Int32, MutableInteger> = mp3File.getBitrates()
    var vbr: Bool = mp3File.isVbr()
    
    if (vbr != false) {
        return 1
    }
    0
}

```

#### 1.3 将编辑后的map保存

##### 1.3.1 主要接口

```
/**
 * 保存文件，不能保存同名文件 核心接口
 *
 * @param newFilename of String
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func save (newFilename: String): Unit
```

##### 1.3.2 示例

```
// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import time.*
from std import fs.*
from std import collection.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/performance/testfile/v1tag.mp3")
    var start: Int64
    var end: Int64
    var times = 1
    var list: ArrayList<Int64> = ArrayList<Int64>()
    for (i in 0..times) {
        start = Time.now().nanosecond()
        mp3File.save("title1v1tag.mp3")
        end = Time.now().nanosecond() - start
        list.append(end)
    }
    var res : Int64 = 0
    for (i in list){
        res += i
    }
    println("save ==> ${res/times}")
}

```

### 2. 提供读取、写入mp3文件并添加和删除ID3v2标签功能

前置条件：NA 
场景：

1. 读取、写入、添加和删除ID3v2标签，标签表示内容支持ISO-8859-1，UTF-16LE，UTF-16BE，UTF-8 4种编码；
2. 读取音频数据帧帧头包含的数据信息
3. 支持音频批量合成功能

约束：
性能： 支持版本几何性能持平
可靠性： NA



#### 2.1 用于读取mp3文件和读取/操作ID3V2.2标签

##### 2.1.1 主要接口

```
/**
 * 获取ID3v2标签 核心接口
 *
 * @return Type of Option
 * @since 0.31.4
 */
public func getId3v2Tag(): Option<ID3v2>

/**
 * 设置Id3v2标签 核心接口
 *
 * @param id3v2Tag of Option<Id3v2>
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func setId3v2Tag(id3v2Tag: Option<ID3v2>): Unit

/**
 * 移除ID3v2标签 核心接口
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func removeId3v2Tag(): Unit

/**
 * 是否包含ID3v2标签 核心接口
 *
 * @return Type of Bool
 * @since 0.31.4
 */
public func hasId3v2Tag(): Bool

```

##### 2.1.2  示例

```
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3",
        41, true)
    var mp3File1: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/obsolete.mp3")
    var mp3File2: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/obsolete-noimage.mp3")
    if (mp3File.hasId3v2Tag()) {
        mp3File.removeId3v2Tag()
    }
    if (mp3File.hasId3v2Tag()) {
        return 1
    }
    mp3File.save("../../../../test/LLT/id3v2Test/testv2File/remove_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    var mp3FileReMove23: Mp3File = Mp3File(
        "../../../../test/LLT/id3v2Test/testv2File/remove_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    var removeLength = mp3FileReMove23.getLength()
    if (removeLength != 2997) {
        return 1
    }
    var newId3v23 = ID3v23Tag()
    newId3v23.setTrack(Option<String>.Some("中文track"))
    newId3v23.setPartOfSet(Option<String>.Some("中文partofset"))
    newId3v23.setGrouping(Option<String>.Some("中文grouping"))
    newId3v23.setArtist(Option<String>.Some("中文artist"))
    newId3v23.setAlbumArtist(Option<String>.Some("中文AlbumArtist"))
    newId3v23.setTitle(Option<String>.Some("中文Title"))
    newId3v23.setAlbum(Option<String>.Some("中文Album"))
    newId3v23.setYear(Option<String>.Some("中文Year"))
    newId3v23.setDate(Option<String>.Some("9月16日"))
    newId3v23.setGenre(Option<Int64>.Some(0))
    newId3v23.setBPM(10)
    newId3v23.setKey(Option<String>.Some("中文key"))
    newId3v23.setGenreDescription(Option<String>.Some("Blues"))
    newId3v23.setComposer(Option<String>.Some("中文composer"))
    newId3v23.setPublisher(Option<String>.Some("中文Publisher"))
    newId3v23.setOriginalArtist(Option<String>.Some("中文OriginalArtist"))
    newId3v23.setCopyright(Option<String>.Some("中文Copyright"))
    newId3v23.setEncoder(Option<String>.Some("中文Encoder"))
    newId3v23.setFooter(true)
    newId3v23.setUnsynchronisation(true)
    newId3v23.setCompilation(true)
    mp3File.setId3v2Tag(Option<ID3v2>.Some(newId3v23))
    mp3File.save("../../../../test/LLT/id3v2Test/testv2File/set_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    var newMp3: Mp3File = Mp3File(
        "../../../../test/LLT/id3v2Test/testv2File/set_id3v23_v1andv23tagswithalbumimage-utf16le.mp3")
    if (newMp3.hasId3v2Tag()) {
        var id3v2Tag = newMp3.getId3v2Tag().getOrThrow()
        if (showV323((id3v2Tag as AbstractID3v2Tag).getOrThrow()) == 1) {
            return 1
        }
        if (newMp3.getLength() != 3528) {
            return 1
        }
    }
    0
}

func showV323(id3v23: AbstractID3v2Tag): Int64 {
    match (id3v23 as AbstractID3v2Tag) {
        case Some(x) =>
            var version = x.getVersion()
            var track = x.getTrack()
            var partOfSet = x.getPartOfSet()
            var compilation = x.isCompilation()
            var grouping = x.getGrouping()
            var artist = x.getArtist()
            var albumArtist = x.getAlbumArtist()
            var title = x.getTitle()
            var album = x.getAlbum()
            var year = x.getYear()
            var date = x.getDate()
            var genre = x.getGenre()
            var bpm = x.getBPM()
            var key = x.getKey()
            var genreDescription = x.getGenreDescription()
            var composer = x.getComposer()
            var publisher = x.getPublisher()
            var originalArtist = x.getOriginalArtist()
            var copyright = x.getCopyright()
            var encoder = x.getEncoder()
            var id3v2Frame: HashMap<String, ID3v2FrameSet> = x.getFrameSets()
            var hasFooter: Bool = x.hasFooter()
            var padding: Bool = x.getPadding()
            var Unsynchronisation: Bool = x.hasUnsynchronisation()
            if (Int64(x.getDataLength()) != 521) {
                return 1
            }
            if (Int64(x.getLength()) != 531) {
                return 1
            }
            if (id3v2Frame.size != 18) {
                return 1
            }
            if (version != "3.0") {
                return 1
            }
            if (track != "中文track") {
                return 1
            }
            if (partOfSet != "中文partofset") {
                return 1
            }
            if (compilation != true) {
                return 1
            }
            if (grouping != "中文grouping") {
                return 1
            }
            if (artist != "中文artist") {
                return 1
            }
            if (albumArtist != "中文AlbumArtist") {
                return 1
            }
            if (title != "中文Title") {
                return 1
            }
            if (album != "中文Album") {
                return 1
            }
            if (year != "中文Year") {
                return 1
            }
            if (date != "9月16日") {
                return 1
            }
            if (genre != 0) {
                return 1
            }
            if (bpm != 10) {
                return 1
            }
            if (key != "中文key") {
                return 1
            }
            if (genreDescription != "Blues") {
                return 1
            }
            if (composer != "中文composer") {
                return 1
            }
            if (publisher != "中文Publisher") {
                return 1
            }
            if (originalArtist != "中文OriginalArtist") {
                return 1
            }
            if (copyright != "中文Copyright") {
                return 1
            }
            if (encoder != "中文Encoder") {
                return 1
            }
            if (hasFooter != false) {
                return 1
            }
            if (Unsynchronisation != true) {
                return 1
            }
        case None => println("Not id3v23")
    }
    0
}

```

#### 2.2 获取mp3文件的音频数据信息。

##### 2.2.1 主要接口

```
/**
 * 获得位率，若是可变位率的音频，该数值为平均位率 核心接口
 *
 * @return Type of Int32
 */
public func getBitrate(): Int32

/**
 * 获取渠道模式 核心接口
 *
 * @return Type of String
 */
public func getChannelMode(): String 

/**
 * 获取强调信息 核心接口
 *
 * @return Type of String
 */
public func getEmphasis(): String

/**
 * 获取压缩级别 核心接口
 *
 * @return Type of String
 */
public func getLayer(): String

/**
 * 获取模式扩展 核心接口
 *
 * @return Type of String
 */
public func getModeExtension(): String

/**
 * 获取音频采样率 核心接口
 *
 * @return Type of Int32
 */
public func getSampleRate(): Int32

/**
 * 获取版本 核心接口
 *
 * @return Type of String
 */
public func getVersion(): String

/**
 * 是否有版权 核心接口
 *
 * @return Type of Bool
 */
public func isCopyright(): Bool

/**
 * 是否是原版 核心接口
 *
 * @return Type of Bool
 */
public func isOriginal(): Bool 

/**
 * 是否为VBR编码（可变位率），不是为 CBR编码 核心接口
 *
 * @return Type of Bool
 */
public func isVbr(): Bool

```

##### 2.2.2 示例

```
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3")
    var startOffset: Int32 = mp3File.getStartOffset()
    var xingOffset: Int32 = mp3File.getXingOffset()
    var endOffset: Int32 = mp3File.getEndOffset()
    var frameCount: Int32 = mp3File.getFrameCount()
    var bitrate: Int32 = mp3File.getBitrate()
    var xingBitrate: Int32 = mp3File.getXingBitrate()
    var bitrates: Map<Int32, MutableInteger> = mp3File.getBitrates()
    var channelMode: String = mp3File.getChannelMode()
    var emphasis: String = mp3File.getEmphasis()
    var layer: String = mp3File.getLayer()
    var lengthInMilliseconds: Int64 = mp3File.getLengthInMilliseconds()
    var lengthInSeconds: Int64 = mp3File.getLengthInSeconds()
    var modeExtension: String = mp3File.getModeExtension()
    var sampleRate: Int32 = mp3File.getSampleRate()
    var version: String = mp3File.getVersion()
    var copyright: Bool = mp3File.isCopyright()
    var original: Bool = mp3File.isOriginal()
    var vbr: Bool = mp3File.isVbr()
    if (startOffset != 3564) {
        return 1
    }
    if (xingOffset != 3147) {
        return 1
    }
    if (endOffset != 6015) {
        return 1
    }
    if (frameCount != 6) {
        return 1
    }
    if (bitrate != 125) {
        return 1
    }
    if (xingBitrate != 128) {
        return 1
    }
    if (channelMode != "Joint stereo") {
        return 1
    }
    if (emphasis != "None") {
        return 1
    }
    if (layer != "III") {
        return 1
    }
    if (lengthInMilliseconds != 156) {
        return 1
    }
    if (lengthInSeconds != 0) {
        return 1
    }
    if (modeExtension != "None") {
        return 1
    }
    if (sampleRate != 44100) {
        return 1
    }
    if (version != "1.0") {
        return 1
    }
    if (copyright != false) {
        return 1
    }
    if (original != true) {
        return 1
    }
    if (vbr != true) {
        return 1
    }
    if (bitrates.size != 5) {
        return 1
    }
    if (bitrates.get(224).getOrThrow().getValue() != 1) {
        return 1
    }
    if (bitrates.get(112).getOrThrow().getValue() != 1) {
        return 1
    }
    if (bitrates.get(96).getOrThrow().getValue() != 2) {
        return 1
    }
    if (bitrates.get(192).getOrThrow().getValue() != 1) {
        return 1
    }
    if (bitrates.get(32).getOrThrow().getValue() != 1) {
        return 1
    }
    0
}

```

 