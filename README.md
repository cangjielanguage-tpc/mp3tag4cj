<p align="center">
<img src="./doc/assets/iocn.png" width="40%" >
</p>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.31.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-90%25-brightgreen" style="display: inline-block;" />
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
│        ├──base_exception.cj
│        ├──buffer_tools.cj
│        ├──file_wrapper.cj
│        ├──id3v1.cj
│        ├──id3v1_genres.cj
│        ├──id3v1_tag.cj
│        ├──id3v2.cj
│        ├──invalid_data_exception.cj
│        ├──mp3_file.cj
│        ├──mutable_integer.cj
│        ├──no_such_tag_exception.cj
│        ├──not_supported_exception.cj
│        └──unsupported_tag_exception.cj
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

##### func save

保存文件，不能保存同名文件

```cangjie
public func save (): Unit
```

#### class ID3V1Tag

##### func toBytes

将标签数据转化为字节数据

```cangjie
public func toBytes (): Array<Byte>
```

##### 设置、获取标签数据

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

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

[@sygaowork](https://gitee.com/sygaowork)