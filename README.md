<div align="center">
<h1>mp3agic</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.32.5-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-82.1%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>


## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>介绍

一个用于读取mp3文件和读取/操作ID3标记（ID3v1和ID3v2.2到ID3v2.4）的库。参考：https://github.com/mpatric/mp3agic

### 特性

- 🚀 特性1

读取、写入、添加和删除ID3v1标签。

- 🚀 特性2

读取、写入、添加和删除ID3v2标签，标签表示内容支持ISO-8859-1，UTF-16LE，UTF-16BE，UTF-8 4种编码； 读取音频数据帧帧头包含的数据信息；
判断vbr文件，获得每个音频数据帧的位率；在音频数据帧结尾和ID3v1标记之间添加或删除自定义标签。

### 路线

<p align="center">
<img src="./doc/assets/路线.png" width="100%" >
</p>


##    <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 软件架构

### 架构图

<p align="center">
<img src="./doc/assets/ID3V1.png" width="40%" >
</p>

### 源码目录

```shell
.
├── README.md
├── CHANGELOG.md
├── README.OPENSOURCE
├── mit-license.txt
├── doc
│   ├── assets
│   ├── design.md
│   ├── api.md
│   └── xxx_lib.md
├── src
│   └── mp3agic 
│       ├──abstract_id3v2_frame_data.cj
│       ├──abstract_id3v2_tag.cj
│       ├──base_exception.cj
│       ├──buffer_tools.cj
│       ├──encoded_text.cj
│       ├──file_wrapper.cj
│       ├──id3v1.cj
│       ├──id3v1_genres.cj
│       ├──id3v1_tag.cj
│       ├──id3v2.cj
│       ├──id3v2_frame.cj
│       ├──id3v2_frame_set.cj
│       ├──id3v2_obselete_frame.cj
│       ├──id3v2_tag_factory.cj
│       ├──id3v2_text_frame_data.cj
│       ├──id3v22_tag.cj
│       ├──id3v23_tag.cj
│       ├──id3v24_frame.cj
│       ├──id3v24_tag.cj
│       ├──invalid_data_exception.cj
│       ├──mp3_file.cj
│       ├──mpeg_frame.cj
│       ├──mutable_integer.cj
│       ├──no_such_tag_exception.cj
│       ├──not_supported_exception.cj
│       └──unsupported_tag_exception.cj
└── test
    ├── HLT 
    ├── LLT
    └── UT
```

- `doc`是库的设计文档、提案、库的使用文档、LLT 覆盖率报告
- `src`是库源码目录
- `test`是存放测试用例，包括HLT用例、LLT 用例和UT用例

### 接口说明

主要是核心类和成员函数说明，详情请见 [API](./doc/api.md)

#### class FileWrapper

##### func getFilename

得到文件的全路径名称

```cangjie
public open func getFilename (): String
```

##### func getLength

得到文件的大小

```cangjie
public open func getLength (): Int64
```

#### class Mp3File

##### func hasId3v1Tag

是否存在ID3V1标签

```cangjie
public func hasId3v1Tag (): Bool
```

##### func getId3v1Tag

获得ID3v1标签

```cangjie
public func getId3v1Tag (): Option<ID3v1>
```

##### func setId3v1Tag

设置ID3v1标签

```cangjie
public func setId3v1Tag (id3v1Tag: Option<ID3v1>): Unit
```

##### func removeId3v1Tag

移除ID3v1标签

```cangjie
public func removeId3v1Tag (): Unit
```

##### func hasId3v2Tag

是否存在ID3V2标签

```cangjie
public func hasId3v2Tag(): Bool
```

##### func getId3v2Tag

获得ID3v2标签

```cangjie
public func getId3v2Tag(): Option<ID3v2>
```

##### func setId3v2Tag

设置ID3v2标签

```cangjie
public func setId3v2Tag(id3v2Tag: Option<ID3v2>): Unit
```

##### func removeId3v2Tag

移除ID3v2标签

```cangjie
public func removeId3v2Tag(): Unit
```

##### func hasCustomTag

是否存在CustomTag标签

```cangjie
public func hasCustomTag(): Bool
```

##### func getCustomTag

获得CustomTag标签

```cangjie
public func getCustomTag (): Option<Array<Int8>>
```

##### func setCustomTag

设置CustomTag标签

```cangjie
public func setCustomTag (customTag: Option<Array<Int8>>): Unit
```

##### func removeCustomTag

移除CustomTag标签

```cangjie
public func removeCustomTag (): Unit
```

#### 获取音频数据信息

```
/**
 * 获得音频数据帧开始的偏移量,如果存在Xing-header会越过Xing-header
 *
 * @return Type of Int32
 */
public func getStartOffset(): Int32 
/**
 * 获得Xing-header开始的偏移量
 *
 * @return Type of Int32
 */
public func getXingOffset(): Int32 
/**
 * 获得音频数据帧结束的偏移量，如果有customTag在customTag之前
 *
 * @return Type of Int32
 */
public func getEndOffset(): Int32
/**
 * 获得音频数据帧的数量
 *
 * @return Type of Int32
 */
public func getFrameCount(): Int32
/**
 * 获得位率，若是可变位率的音频，该数值为平均位率
 *
 * @return Type of Int32
 */
public func getBitrate(): Int32
/**
 * 获得Xing-header帧的位率
 *
 * @return Type of Int32
 */
public func getXingBitrate(): Int32
/**
 * 获得位率集合，若scanfile为false时。该一个size只有1为第一个音频数据真的位率。
 * 集合的key为位率的值，MutableInteger 记录该位率出现的次数
 *
 * @return Type of Map<Int32, MutableInteger>
 */
public func getBitrates(): Map<Int32, MutableInteger>
/**
 * 获取渠道模式
 *
 * @return Type of String
 */
public func getChannelMode(): String 
/**
 * 获取强调信息
 *
 * @return Type of String
 */
public func getEmphasis(): String
/**
 * 获取压缩级别
 *
 * @return Type of String
 */
public func getLayer(): String
/**
 * 获取MP3长度，单位毫秒
 *
 * @return Type of Int64
 */
public func getLengthInMilliseconds(): Int64
/**
 * 获取MP3长度，单位秒
 *
 * @return Type of Int64
 */
public func getLengthInSeconds(): Int64
/**
 * 获取模式扩展
 *
 * @return Type of String
 */
public func getModeExtension(): String
/**
 * 获取音频采样率
 *
 * @return Type of Int32
 */
public func getSampleRate(): Int32
/**
 * 获取版本
 *
 * @return Type of String
 */
public func getVersion(): String
/**
 * 是否有版权
 *
 * @return Type of Bool
 */
public func isCopyright(): Bool
/**
 * 是否是原版
 *
 * @return Type of Bool
 */
public func isOriginal(): Bool 
/**
 * 是否为VBR编码（可变位率），不是为 CBR编码
 *
 * @return Type of Bool
 */
public func isVbr(): Bool
/**
 * 判断是否有 xing帧
 *
 * @return Type of Bool
 */
public func hasXingFrame(): Bool
```

##### func save

保存文件，不能保存同名文件

```cangjie
public func save (): Unit
```

#### class ID3V1Tag

##### func toBytes

将标签数据转化为字节数据

```cangjie
public func toBytes (): Array<Int8>
```

##### 设置、获取id3v1标签数据

```cangjie
public func getVersion (): String
public func getTrack (): Option<String>
public func setTrack (track: Option<String>): Unit
public func getArtist (): Option<String>
public func setArtist (artist: Option<String>): Unit
public func getTitle (): Option<String>
public func setTitle (title: Option<String>): Unit
public func getAlbum (): Option<String>
public func setAlbum (album: Option<String>): Unit
public func getYear (): Option<String>
public func setYear (year: Option<String>): Unit
public func getGenre (): Option<Int64>
public func setGenre (genre: Option<Int64>): Unit
public func getGenreDescription (): String
public func getComment (): Option<String>
public func setComment (comment: Option<String>): Unit
```

#### class AbstractID3v2Tag

##### func toBytes

将标签数据转化为字节数据

```cangjie
public open func toBytes (): Array<Int8>
```

##### 设置、获取id3v2标签数据

```cangjie
public open func getVersion (): String
/**
 * 得到整个标签数据长度.
 *
 * @return Type of Int32
 * @since 0.32.5
 */
public open func getDataLength (): Int32
/**
 * 得到整个标签长度。
 *
 * @return Type of Int32
 * @since 0.32.5
 */
public open func getLength (): Int32
/**
 * 得到标签帧map，key为标签帧标识，value为标签帧数据集合封装类。
 *
 * @return Type of HashMap<String, ID3v2FrameSet>
 * @since 0.32.5
 */
public open func getFrameSets (): HashMap<String, ID3v2FrameSet>
/**
 * 是否包含标签脚 3DI
 *
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasFooter (): Bool
/**
 * 只有id3v24版本支持设置标签页脚。其他版本设置无效。
 *
 * @param footer of Bool
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setFooter (footer: Bool): Unit
/**
 * TRCK or TRK 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getTrack (): Option<String>
public open func setTrack (track: Option<String>): Unit
/**
 * TPOS or TPA 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getPartOfSet (): Option<String>
public open func setPartOfSet (partOfSet: Option<String>): Unit
/**
 * TCMP or TCP 标识对应的数据
 *
 * @return Type of Bool
 * @since 0.32.5
 */
public open func isCompilation (): Bool
public open func setCompilation (compilation: Bool): Unit
/**
 * TIT1 or TT1 标识对应的数据 
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getGrouping (): Option<String>
public open func setGrouping (grouping: Option<String>): Unit
/**
 * TPE1 or TP1 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getArtist (): Option<String>
public open func setArtist (artist: Option<String>): Unit
/**
 * TPE2 or TP2 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getAlbumArtist (): Option<String>
public open func setAlbumArtist (albumArtist: Option<String>): Unit
/**
 * TIT2 or TT2 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getTitle (): Option<String>
public open func setTitle (title: Option<String>): Unit
/**
 * TALB or TAL 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getAlbum (): Option<String>
public open func setAlbum (album: Option<String>): Unit
/**
 * TYER or TYE 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getYear (): Option<String>
public open func setYear (year: Option<String>): Unit
/**
 * TDAT or TDA 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getDate (): Option<String>
public open func setDate (date: Option<String>): Unit
/**
 * TCON or TCO 标识对应的数据
 *
 * @return Type of Option<Int64>
 * @since 0.32.5
 */
public func getGenre (): Option<Int64>
public open func setGenre (genre: Option<Int64>): Unit
/**
 * TBPM or TBP 标识对应的数据
 *
 * @return Type of Option<Int32>
 * @since 0.32.5
 */
public open func getBPM (): Option<Int32>
public open func setBPM (bpm: Int32): Unit
/**
 * TKEY or TKE 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getKey (): Option<String>
public open func setKey (key: Option<String>): Unit
/**
 * TCOM or TCM 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getComposer (): Option<String>
public open func setComposer (composer: Option<String>): Unit
/**
 * TPUB or TBP 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getPublisher (): Option<String>
public open func setPublisher (publisher: Option<String>): Unit
/**
 * TOPE or TOA 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getOriginalArtist (): Option<String>
public open func setOriginalArtist (originalArtist: Option<String>): Unit
/**
 * TCOP or TCR 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getCopyright (): Option<String>
public open func setCopyright (copyright: Option<String>): Unit
/**
 * TENC or TEN 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getEncoder (): Option<String>
public open func setEncoder (encoder: Option<String>): Unit
public open func getGenreDescription (): String
public open func setGenreDescription (text: Option<String>): Unit
```

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/>编译执行

### 编译

编译描述和具体shell命令

```shell
cpm update
cpm build
```

### 使用示例

对ID3V1标签的设置、获取和保存

```cangjie
获取和设置IDCV1标签数据:

from std import io.*
from mp3agic import mp3agic.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var file = FileInfo("../../../../test/LLT/testFile/v1tag.mp3")
    var mp3File = Mp3File(file)
    if (mp3File.hasId3v1Tag()){
        var id3v1Tag = mp3File.getId3v1Tag().getOrThrow()
        showId3v1(id3v1Tag)
        id3v1Tag.setTrack(Option<String>.Some(""))
        id3v1Tag.setArtist(Option<String>.Some("NEWARTIST12345678901234567890"))
        id3v1Tag.setTitle(Option<String>.Some("NEWTITLE12345678901234567890"))
        id3v1Tag.setAlbum(Option<String>.Some("NEWALBUM1234567890123456789011111111111111111111111111"))
        id3v1Tag.setYear(Option<String>.Some("19940821"))
        id3v1Tag.setGenre(Option<Int64>.Some(20))
        id3v1Tag.setComment(Option<String>.Some("NEWCOMMENT123456"))
    }
    mp3File.save("../../../../test/LLT/testFile/v1tagNew.mp3")
    var file2 = FileInfo("../../../../test/LLT/testFile/v1tagNew.mp3")
    var mp3FileNew = Mp3File(file2)
    if (mp3FileNew.hasId3v1Tag()){
        var id3v1Tag = mp3FileNew.getId3v1Tag().getOrThrow()
        showId3v1(id3v1Tag)
        checkId3v1(id3v1T    
    }
    File.delete("../../../../test/LLT/testFile/v1tagNew.mp3")
    0
}
func checkId3v1(id3v1Tag: ID3v1){
    if (id3v1Tag.getVersion() != "0") {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getTrack() != "") {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getArtist() != "NEWARTIST12345678901234567890") {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getTitle() != "NEWTITLE12345678901234567890") {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getAlbum() != "NEWALBUM1234567890123456789011") {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getYear() != "1994") {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getGenre() != 20) {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getComment() != "NEWCOMMENT123456") {
        throw RuntimeException("Expected non conformance")
    }
    if (id3v1Tag.getGenreDescription() != "Alternative") {
        throw RuntimeException("Expected non conformance")
    }
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
    println("version ==> ${version}")
    println("track ==> ${track}")
    println("artist ==> ${artist}")
    println("title ==> ${title}")
    println("album ==> ${album}")
    println("year ==> ${year}")
    println("genre ==> ${genre}")
    println("comm ==> ${comm}")
    println("des ==> ${des}")
}
```

执行结果如下：

```cangjie
执行结果:
version ==> 1
track ==> Some(1)
artist ==> Some(ARTIST123456789012345678901234)
title ==> Some(TITLE1234567890123456789012345)
album ==> Some(ALBUM1234567890123456789012345)
year ==> Some(2001)
genre ==> Some(13)
comm ==> Some(COMMENT123456789012345678901)
des ==> Pop
version ==> 0
track ==> Some()
artist ==> Some(NEWARTIST12345678901234567890)
title ==> Some(NEWTITLE12345678901234567890)
album ==> Some(NEWALBUM1234567890123456789011)
year ==> Some(1994)
genre ==> Some(20)
comm ==> Some(NEWCOMMENT123456)
des ==> Alternative
```

获取MP3音频数据相关成员

```cangjie
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    //v1andv23andcustomtags.mp3
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23andcustomtags.mp3")
    var startOffset:Int32 = mp3File.getStartOffset()
    var xingOffset:Int32 = mp3File.getXingOffset()
    var endOffset:Int32 = mp3File.getEndOffset()
    var frameCount:Int32 = mp3File.getFrameCount()
    var bitrate:Int32 = mp3File.getBitrate()
    var xingBitrate:Int32 = mp3File.getXingBitrate()
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
    println("startOffset ===> ${startOffset}")
    println("xingOffset ===> ${xingOffset}")
    println("endOffset ===> ${endOffset}")
    println("frameCount ===> ${frameCount}")
    println("bitrate ===> ${bitrate}")
    println("xingBitrate ===> ${xingBitrate}")
    println("channelMode ===> ${channelMode}")
    println("emphasis ===> ${emphasis}")
    println("layer ===> ${layer}")
    println("lengthInMilliseconds ===> ${lengthInMilliseconds}")
    println("lengthInSeconds ===> ${lengthInSeconds}")
    println("modeExtension ===> ${modeExtension}")
    println("sampleRate ===> ${sampleRate}")
    println("version ===> ${version}")
    println("copyright ===> ${copyright}")
    println("original ===> ${original}")
    println("vbr ===> ${vbr}")
    for ( (k,v) in bitrates ){
        println("bitrates key ===> ${k}")
        println("bitrates val ===> ${v.getValue()}")
    }
    0
}
```

执行结果如下：

```cangjie
执行结果:
startOffset ===> 1516
xingOffset ===> 1099
endOffset ===> 3967
frameCount ===> 6
bitrate ===> 125
xingBitrate ===> 128
channelMode ===> Joint stereo
emphasis ===> None
layer ===> III
lengthInMilliseconds ===> 156
lengthInSeconds ===> 0
modeExtension ===> None
sampleRate ===> 44100
version ===> 1.0
copyright ===> false
original ===> true
vbr ===> true
bitrates key ===> 224
bitrates val ===> 1
bitrates key ===> 112
bitrates val ===> 1
bitrates key ===> 96
bitrates val ===> 2
bitrates key ===> 192
bitrates val ===> 1
bitrates key ===> 32
bitrates val ===> 1
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

[@sygaowork](https://gitee.com/sygaowork)