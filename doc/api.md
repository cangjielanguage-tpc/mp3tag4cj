### 接口说明

主要是核心类和成员函数说明

### 下面为 特性1内容 api前有为新增 api前有*为有修改 api前有#为有核心接口

#### class FileWrapper

```
/**
 * The Function is init constructor
 *
 * @param filename of String, 文件全路径名称
 * @since 0.31.4
 */
public init (filename: String)
/**
 * The Function is init constructor
 *
 * @param file of FileInfo
 * @since 0.31.4
 */
public init (file: FileInfo)
/**
 * 得到文件的全路径名称
 *
 * @return Type of String
 * @since 0.31.4
 */
#public open func getFilename (): String
/**
 * 得到文件的大小
 *
 * @return Type of Int64
 * @since 0.31.4
 */
#public open func getLength (): Int64
```

#### class Mp3File

```
/**
 * The Function is init constructor
 *
 * @param filename of String，文件全路径名称
 * @since 0.31.4
 */
public init (filename: String)
/**
 * The Function is init constructor
 *
 * @param filename of String，文件全路径名称
 * @param bufferLength of Int32，读取文件长度
 * @since 0.31.4
 */
public init (filename: String, bufferLength: Int32)
/**
 * The Function is init constructor
 *
 * @param filename of String，文件全路径名称
 * @param scanFile of Bool，是否扫描整个文件
 * @since 0.31.4
 */
public init (filename: String, scanFile: Bool)
/**
 * The Function is init constructor
 *
 * @param filename of String，文件全路径名称
 * @param bufferLength of Int32，读取文件长度
 * @param scanFile of Bool，是否扫描整个文件
 * @since 0.31.4
 */
public init (filename: String, bufferLength: Int32, scanFile: Bool)
public init (file: FileInfo)
public init (file: FileInfo, bufferLength: Int32)
public init (file: FileInfo, bufferLength: Int32, scanFile: Bool)
/**
 * 是否包含ID3v1标签
 *
 * @return Type of Bool
 * @since 0.31.4
 */
#public func hasId3v1Tag (): Bool

# public func getId3v2Tag(): Option<ID3v2>
# public func setId3v2Tag(id3v2Tag: Option<ID3v2>): Unit
# public func removeId3v2Tag(): Unit
# public func hasId3v2Tag(): Bool

# public func hasCustomTag(): Bool
# public func getCustomTag (): Option<Array<Int8>>
# public func setCustomTag (customTag: Option<Array<Int8>>): Unit
# public func removeCustomTag (): Unit

/**
 * 获得ID3v1标签
 *
 * @return Type of Option<ID3v1>
 * @since 0.31.4
 */
#public func getId3v1Tag (): Option<ID3v1>
/**
 * 设置ID3v1标签
 *
 * @param id3v1Tag of Option<ID3v1>
 *
 * @return Type of Unit
 * @since 0.31.4
 */
#public func setId3v1Tag (id3v1Tag: Option<ID3v1>): Unit
/**
 * 移除ID3v1标签
 *
 * @return Type of Uni
 * @since 0.31.4
 */
#public func removeId3v1Tag (): Unit

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
# public func getXingOffset(): Int32 
/**
 * 获得音频数据帧结束的偏移量，如果有customTag在customTag之前
 *
 * @return Type of Int32
 */
# public func getEndOffset(): Int32
/**
 * 获得音频数据帧的数量
 *
 * @return Type of Int32
 */
# public func getFrameCount(): Int32
/**
 * 获得位率，若是可变位率的音频，该数值为平均位率
 *
 * @return Type of Int32
 */
# public func getBitrate(): Int32
/**
 * 获得Xing-header帧的位率
 *
 * @return Type of Int32
 */
# public func getXingBitrate(): Int32
/**
 * 获得位率集合，若scanfile为false时。该一个size只有1为第一个音频数据真的位率。
 * 集合的key为位率的值，MutableInteger 记录该位率出现的次数
 *
 * @return Type of Map<Int32, MutableInteger>
 */
# public func getBitrates(): Map<Int32, MutableInteger>
/**
 * 获取渠道模式
 *
 * @return Type of String
 */
# public func getChannelMode(): String 
/**
 * 获取强调信息
 *
 * @return Type of String
 */
# public func getEmphasis(): String
/**
 * 获取压缩级别
 *
 * @return Type of String
 */
# public func getLayer(): String
/**
 * 获取MP3长度，单位毫秒
 *
 * @return Type of Int64
 */
# public func getLengthInMilliseconds(): Int64
/**
 * 获取MP3长度，单位秒
 *
 * @return Type of Int64
 */
# public func getLengthInSeconds(): Int64
/**
 * 获取模式扩展
 *
 * @return Type of String
 */
# public func getModeExtension(): String
/**
 * 获取音频采样率
 *
 * @return Type of Int32
 */
# public func getSampleRate(): Int32
/**
 * 获取版本
 *
 * @return Type of String
 */
# public func getVersion(): String
/**
 * 是否有版权
 *
 * @return Type of Bool
 */
# public func isCopyright(): Bool
/**
 * 是否是原版
 *
 * @return Type of Bool
 */
# public func isOriginal(): Bool 
/**
 * 是否为VBR编码（可变位率），不是为 CBR编码
 *
 * @return Type of Bool
 */
# public func isVbr(): Bool
/**
 * 判断是否有 xing帧
 *
 * @return Type of Bool
 */
# public func hasXingFrame(): Bool

/**
 * 保存文件，不能保存同名文件
 *
 * @param newFilename of String
 *
 * @return Type of Unit
 * @since 0.31.4
 */
#public func save (newFilename: String): Unit
```

#### class ID3V1Tag

```
/**
 * 通过字节数组，初始化标签成员数据
 *
 * @param bytes of Array<Byte>
 * @since 0.31.4
 */
public init (bytes: Array<Byte>)
/**
 * 将成员数据转换成字节数据
 *
 * @return Type of Array<Byte>
 * @since 0.31.4
 */
* public func toBytes (): Array<Int8>
#public func getVersion (): String
#public func getTrack (): Option<String>
#public func setTrack (track: Option<String>): Unit
#public func getArtist (): Option<String>
#public func setArtist (artist: Option<String>): Unit
#public func getTitle (): Option<String>
#public func setTitle (title: Option<String>): Unit
#public func getAlbum (): Option<String>
#public func setAlbum (album: Option<String>): Unit
#public func getYear (): Option<String>
#public func setYear (year: Option<String>): Unit
#public func getGenre (): Option<Int64>
#public func setGenre (genre: Option<Int64>): Unit
#public func getGenreDescription (): String
#public func getComment (): Option<String>
#public func setComment (comment: Option<String>): Unit
```

#### class ID3v1Genres

```
/**
 * 获取曲风对应的序号
 *
 * @param description of String
 *
 * @return Type of Int32
 * @since 0.31.4
 */
* public static func matchGenreDescription (description: Option<String>): Int32
```

#### class MutableInteger

```
public init (value: Int32)
/**
 * 增长数据加1
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func increment (): Unit
/**
 * 获得数据
 *
 * @return Type of Int32
 * @since 0.31.4
 */
public func getValue (): Int32
/**
 * 设置数据
 *
 * @param value of Int32
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func setValue (value: Int32): Unit
```
### 下面为 特性2新增内容
#### class AbstractID3v2Tag

实现ID3v2接口 存在子类ID3v22Tag， ID3v23Tag， ID3v24Tag
功能api成员可以参考列表 https://blog.csdn.net/qq_41609208/article/details/105812868
```
public init ()
public init (bytes: Array<Int8>)
public init (bytes: Array<Int8>, obseleteFormat: Bool)
#public open func toBytes (): Array<Int8>
#public open func getVersion (): String
/**
 * 得到整个标签数据长度.
 *
 * @return Type of Int32
 * @since 0.32.5
 */
#public open func getDataLength (): Int32
/**
 * 得到整个标签长度。
 *
 * @return Type of Int32
 * @since 0.32.5
 */
#public open func getLength (): Int32
/**
 * 得到标签帧map，key为标签帧标识，value为标签帧数据集合封装类。
 *
 * @return Type of HashMap<String, ID3v2FrameSet>
 * @since 0.32.5
 */
#public open func getFrameSets (): HashMap<String, ID3v2FrameSet>
#public open func getPadding (): Bool
#public open func hasFooter (): Bool
/**
 * 只有id3v24版本支持设置标签页脚。其他版本设置无效。
 *
 * @param footer of Bool
 *
 * @return Type of Unit
 * @since 0.32.5
 */
#public open func setFooter (footer: Bool): Unit
#public open func hasUnsynchronisation (): Bool
#public open func setUnsynchronisation (unsynchronisation: Bool): Unit
#public open func getObseleteFormat (): Bool
/**
 * TRCK or TRK 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getTrack (): Option<String>
#public open func setTrack (track: Option<String>): Unit
/**
 * TPOS or TPA 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getPartOfSet (): Option<String>
#public open func setPartOfSet (partOfSet: Option<String>): Unit
/**
 * TCMP or TCP 标识对应的数据
 *
 * @return Type of Bool
 * @since 0.32.5
 */
#public open func isCompilation (): Bool
#public open func setCompilation (compilation: Bool): Unit
/**
 * TIT1 or TT1 标识对应的数据 
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getGrouping (): Option<String>
#public open func setGrouping (grouping: Option<String>): Unit
/**
 * TPE1 or TP1 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getArtist (): Option<String>
#public open func setArtist (artist: Option<String>): Unit
/**
 * TPE2 or TP2 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getAlbumArtist (): Option<String>
#public open func setAlbumArtist (albumArtist: Option<String>): Unit
/**
 * TIT2 or TT2 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getTitle (): Option<String>
#public open func setTitle (title: Option<String>): Unit
/**
 * TALB or TAL 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getAlbum (): Option<String>
#public open func setAlbum (album: Option<String>): Unit
/**
 * TYER or TYE 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getYear (): Option<String>
#public open func setYear (year: Option<String>): Unit
/**
 * TDAT or TDA 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getDate (): Option<String>
#public open func setDate (date: Option<String>): Unit
/**
 * TCON or TCO 标识对应的数据
 *
 * @return Type of Option<Int64>
 * @since 0.32.5
 */
#public func getGenre (): Option<Int64>
#public open func setGenre (genre: Option<Int64>): Unit
/**
 * TBPM or TBP 标识对应的数据
 *
 * @return Type of Option<Int32>
 * @since 0.32.5
 */
#public open func getBPM (): Option<Int32>
#public open func setBPM (bpm: Int32): Unit
/**
 * TKEY or TKE 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getKey (): Option<String>
#public open func setKey (key: Option<String>): Unit
#public open func getGenreDescription (): String
#public open func setGenreDescription (text: Option<String>): Unit
/**
 * TCOM or TCM 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getComposer (): Option<String>
#public open func setComposer (composer: Option<String>): Unit
/**
 * TPUB or TBP 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getPublisher (): Option<String>
#public open func setPublisher (publisher: Option<String>): Unit
/**
 * TOPE or TOA 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getOriginalArtist (): Option<String>
#public open func setOriginalArtist (originalArtist: Option<String>): Unit
/**
 * TCOP or TCR 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getCopyright (): Option<String>
#public open func setCopyright (copyright: Option<String>): Unit
/**
 * TENC or TEN 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
#public open func getEncoder (): Option<String>
#public open func setEncoder (encoder: Option<String>): Unit
/**
 * COMM or COM 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getComment (): Option<String>
# public open func setComment (comment: Option<String>): Unit
/**
 * COMM or COM 标识且内容包含engiTunNORM的标签帧对应的数据
 * 
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getItunesComment (): Option<String>
# public open func setItunesComment (itunesComment: Option<String>): Unit
/**
 * 获取USLT标识对应的，eng后的内容数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getLyrics (): Option<String>
# public open func setLyrics (lyrics: Option<String>): Unit
/**
 * 获取WOAR标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getArtistUrl (): Option<String>
# public open func setArtistUrl (url: Option<String>): Unit
/**
 * 获取WCOM标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getCommercialUrl (): Option<String>
# public open func setCommercialUrl (url: Option<String>): Unit
/**
 * 获取WCOP标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getCopyrightUrl (): Option<String>
# public open func setCopyrightUrl (url: Option<String>): Unit
/**
 * 获取WOAF标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getAudiofileUrl (): Option<String>
# public open func setAudiofileUrl (url: Option<String>): Unit
/**
 * 获取WOAS标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getAudioSourceUrl (): Option<String>
# public open func setAudioSourceUrl (url: Option<String>): Unit
/**
 * 获取WORS标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getRadiostationUrl (): Option<String>
# public open func setRadiostationUrl (url: Option<String>): Unit
/**
 * 获取WPAY标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getPaymentUrl (): Option<String>
# public open func setPaymentUrl (url: Option<String>): Unit
/**
 * 获取WPUB标识对应的数据，无ob标识
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getPublisherUrl (): Option<String>
# public open func setPublisherUrl (url: Option<String>): Unit
/**
 * WXXX or WXX 标识对应的数据
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# public open func getUrl (): Option<String>
# public open func setUrl (url: Option<String>): Unit
/**
 * 移除指定标识的标签帧
 *
 * @param id of String
 *
 * @return Type of Unit
 * @since 0.33.3
 */
# public open func clearFrameSet (id: String): Unit

/**
 * 获得APIC标识中的图片数据.
 *
 * @return Type of Option<Array<Int8>>
 * @since 0.33.3
 */
# 转测 public open func getAlbumImage(): Option<Array<Int8>>
/**
 * 获得APIC标识中的MimeType数据，一般为image/png, image/jpeg.
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
# 转测 public open func getAlbumImageMimeType(): Option<String>
/**
 * 设置APIC标识中的数据
 *
 * @param albumImage of Option<Array<Int8>> 图片的字节数据
 * @param mimeType of Option<String>，一般设置为image/png, image/jpeg
 *
 * @return Type of Unit
 * @since 0.33.3
 */
# 转测 public open func setAlbumImage(albumImage: Option<Array<Int8>>, mimeType: Option<String>): Unit
/**
 * 设置APIC标识中的数据
 *
 * @param albumImage of Option<Array<Int8>> 图片的字节数据
 * @param mimeType of Option<String> 一般设置为image/png, image/jpeg
 * @param imageType of Int8 下面是图片类型数据的含义
 * Picture type: 
 * $00  Other
 * $01  32x32 pixels 'file icon' (PNG only)
 * $02  Other file icon
 * $03  Cover (front)
 * $04  Cover (back)
 * $05  Leaflet page
 * $06  Media (e.g. label side of CD)
 * $07  Lead artist/lead performer/soloist
 * $08  Artist/performer
 * $09  Conductor
 * $0A  Band/Orchestra
 * $0B  Composer
 * $0C  Lyricist/text writer
 * $0D  Recording Location
 * $0E  During recording
 * $0F  During performance
 * $10  Movie/video screen capture
 * $11  A bright coloured fish
 * $12  Illustration
 * $13  Band/artist logotype
 * $14  Publisher/Studio logotype
 * @param imageDescription of Option<String> 为图片提供简单描述
 *
 * @return Type of Unit
 * @since 0.33.3
 */
# 转测 public open func setAlbumImage(albumImage: Option<Array<Int8>>, mimeType: Option<String>, imageType: Int8, imageDescription: Option<String>): Unit

/**
 * 得到CHAP标识数据，ID3v2ChapterFrameData为一个集合。参考ID3v2ChapterFrameData 提供的api。
 *
 * @return Type of Option<ArrayList<ID3v2ChapterFrameData>>
 * @since 0.33.3
 */
# 转测 public open func getChapters(): Option<ArrayList<ID3v2ChapterFrameData>>
# 转测 public open func setChapters(chapters: Option<ArrayList<ID3v2ChapterFrameData>>): Unit

/**
 * 得到CTOC标识数据，ID3v2ChapterFrameData为一个集合。参考ID3v2ChapterTOCFrameData提供的api。
 * 
 * @return Type of Option<ArrayList<ID3v2ChapterTOCFrameData>>
 * @since 0.33.3
 */
# 转测 public open func getChapterTOC(): Option<ArrayList<ID3v2ChapterTOCFrameData>> 
# 转测 public open func setChapterTOC(toc: Option<ArrayList<ID3v2ChapterTOCFrameData>>): Unit

/**
 * 得到POPM标识数据
 *
 * @return Type of Int32
 * @since 0.33.3
 */
# 转测 public open func getWmpRating(): Int32
/**
 * 设置POPM标识数据, 有效值[0,5] 
 *
 * @param rating of Int32
 *
 * @return Type of Unit
 * @since 0.33.3
 */
# 转测 public open func setWmpRating(rating: Int32): Unit

# 转测 public open func clearAlbumImage(): Unit



```

#### class ID3v22Tag <: AbstractID3v2Tag

```
public init ()
public init (buffer: Array<Int8>)
public init (buffer: Array<Int8>, obseleteFormat: Bool)
```

#### class ID3v23Tag <: AbstractID3v2Tag

```
public init ()
public init (buffer: Array<Int8>)
```

#### class ID3v24Tag <: AbstractID3v2Tag

```
public init ()
public init (buffer: Array<Int8>)
#public func setGenreDescription (text: String): Unit
#public func getRecordingTime (): Option<String>
#public func setRecordingTime (recTime: Option<String>): Unit
```

#### class ID3v2TagFactory

```
/**
 * 创建Id3v2的标签，该方法会根据字节数据解析创建不同版本的Id3v2标签对象
 *
 * @param bytes of Array<Int8>，入参为Id3v2标签的字节数据
 *
 * @return Type of Option<AbstractID3v2Tag>
 */
public static func createTag (bytes: Array<Int8>): Option<AbstractID3v2Tag>
/**
 * 提供ID3V2标签头的检查，包括标签头长度10字节， 前3个字节的内容， 和子版本好进行检查
 *
 * @param bytes of Array<Int8>
 *
 * @return Type of Unit
 */
public static func sanityCheckTag (bytes: Array<Int8>): Unit
```

#### class ID3v2Frame
存在ID3v2ObseleteFrame， ID3v24Frame子类
标签帧数据封装类
```
/**
 * The Function is init constructor
 *
 * @param id of String ，标签帧标识
 * @param data of Array<Int8>，标签帧字节数据
 */
public init (id: String, data: Array<Int8>)
/**
 * The Function is init constructor,构造完成后需要调用unpackFrame解析标签帧的数据
 *
 * @param buffer of Array<Int8>,整个id3v2标签的字节数据
 * @param offset of Int32，某个标签帧开始的偏移量
 */
public init (buffer: Array<Int8>, offset: Int32)
/**
 * The Function is unpackFrame
 *
 * @param buffer of Array<Int8>,整个id3v2标签的字节数据
 * @param offset of Int32，某个标签帧开始的偏移量
 *
 * @return Type of Unit
 */
public open func unpackFrame (buffer: Array<Int8>, offset: Int32): Unit
/**
 * 将对象数据转换成字节数据
 *
 * @return Type of Array<Int8>
 */
#public open func toBytes (): Array<Int8>
#public open func getId (): String
#public open func getDataLength (): Int32
#public open func getLength (): Int32
#public open func getData (): Array<Int8>
#public open func setData (data: Array<Int8>): Unit
#public open func hasDataLengthIndicator (): Bool
#public open func hasCompression (): Bool
#public open func hasEncryption (): Bool
#public open func hasGroup (): Bool
#public open func hasPreserveFile (): Bool
#public open func hasPreserveTag (): Bool
#public open func isReadOnly (): Bool
#public open func hasUnsynchronisation (): Bool
```

#### class ID3v2FrameSet

```
/**
 * The Function is init constructor
 *
 * @param id of String, 标签帧标识
 */
public init (id: String)
public open func getId (): String
public open func addFrame(frame: ID3v2Frame): Unit
/**
 * 清除标签帧对象集合
 *
 * @return Type of Unit
 */
public open func clear (): Unit
/**
 * 获取对应标识的标签帧对象列表
 *
 * @return Type of ArrayList<ID3v2Frame>
 */
public open func getFrames (): ArrayList<ID3v2Frame>
/**
 * 话术格式为 标签标识：该表示下的标签帧对象个数
 *
 * @return Type of String
 */
public open func toString (): String
```

#### class MpegFrame

```
/**
 * The Function is init constructor
 *
 * @param frameData of Array<Int8>, 会取集合中的前4个字节进行解析，音频数据帧的前4个字节，也就是数据帧头，Array长度小于4会报错。
 */
public init (frameData: Array<Int8>)
public init (frameData1: Int8, frameData2: Int8, frameData3: Int8, frameData4: Int8)
/**
 * 获得位率
 *
 * @return Type of Int32
 * @since 0.32.5
 */
public func getBitrate (): Int32
/**
 * 获取渠道模式
 *
 * @return Type of String
 * @since 0.32.5
 */
public func getChannelMode (): String
/**
 * 是否有版权
 *
 * @return Type of Bool
 * @since 0.32.5
 */
public func isCopyright (): Bool
/**
 * 获取强调信息
 *
 * @return Type of String
 * @since 0.32.5
 */
public func getEmphasis (): String
/**
 * 获取压缩级别
 *
 * @return Type of String
 * @since 0.32.5
 */
public func getLayer (): String
/**
 * 获取模式扩展
 *
 * @return Type of String
 * @since 0.32.5
 */
public func getModeExtension (): String
/**
 * 是否是原版
 *
 * @return Type of Bool
 * @since 0.32.5
 */
public func isOriginal (): Bool
/**
 * 获取音频采样率
 *
 * @return Type of Int32
 * @since 0.32.5
 */
public func getSampleRate (): Int32
/**
 * 获取版本
 *
 * @return Type of String
 * @since 0.32.5
 */
public func getVersion (): String
/**
 * 获得音频数据帧长
 *
 * @return Type of Int32
 * @since 0.32.5
 */
public func getLengthInBytes (): Int32
```

### 下列api更偏向于过程调用
#### class AbstractID3v2FrameData

对id3v2标签帧的数据封装转换类型。ID3v2ChapterFrameData，ID3v2ChapterTOCFrameData，ID3v2CommentFrameData，ID3v2ObseletePictureFrameData
ID3v2PictureFrameData，ID3v2PopmFrameData，ID3v2TextFrameData，ID3v2UrlFrameData，ID3v2TextFrameData的父类型

```
public init (unsynchronisation: Bool)
```

#### class ID3v2TextFrameData

对id3v2 下列Track，PartOfSet，Compilation，Grouping，Artist，AlbumArtist，Title，Album，Year，Date，Genre，BPM，
Key，Composer，Publisher，OriginalArtist，Copyright，Encoder 标识的标签帧的解析和转码操作。

```
public init (unsynchronisation: Bool)
/**
 * 用于set值得时候用的构造函数
 *
 * @param unsynchronisation of Bool
 * @param text of EncodedText, 有字符串内容构建的EncodeText对象
 */
public init (unsynchronisation: Bool, text: EncodedText)
/**
 * 用户get值时候使用的构造函数
 *
 * @param unsynchronisation of Bool
 * @param bytes of Array<Int8>, 标签帧字节数据
 */
public init (unsynchronisation: Bool, bytes: Array<Int8>)
public func getText (): Option<EncodedText>
public func setText (text: EncodedText): Unit
```

#### class ID3v2ChapterFrameData

```
转测 public init(unsynchronisation: Bool)
转测 public init(unsynchronisation: Bool, isRoot: Bool, isOrdered: Bool, id: Option<String>, children: Option<Array<String>>)
转测 public init(unsynchronisation: Bool, bytes: Array<Int8>)
转测 public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit
转测 public func getId(): Option<String>
转测 public func setId(id: String): Unit
转测 public func getStartTime(): Int32
转测 public func setStartTime(startTime: Int32): Unit
转测 public func getEndTime(): Int32
转测 public func setEndTime(endTime: Int32): Unit
转测 public func getStartOffset(): Int32
转测 public func setStartOffset(startOffset: Int32): Unit
转测 public func getEndOffset(): Int32
转测 public func setEndOffset(endOffset: Int32): Unit
转测 public func getSubframes(): Option<ArrayList<ID3v2Frame>>
转测 public func setSubframes(subframes: Option<ArrayList<ID3v2Frame>>): Unit
转测 public func getLength(): Int32
转测 public func toString(): String
```

#### class ID3v2ChapterTOCFrameData <: AbstractID3v2FrameData

```
转测 public init(unsynchronisation: Bool)
转测 public init(unsynchronisation: Bool, isRoot: Bool, isOrdered: Bool, id: Option<String>, children: Option<Array<String>>)
转测 public init(unsynchronisation: Bool, bytes: Array<Int8>)
转测 public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit
转测 public func isRoot(): Bool
转测 public func setRoot(isRoot: Bool): Unit
转测 public func isOrdered(): Bool
转测 public func setOrdered(isOrdered: Bool): Unit
转测 public func getId(): Option<String>
转测 public func setId(id: Option<String>): Unit
转测 public func getChildren(): Option<Array<String>>
转测 public func setChildren(children: Option<Array<String>>): Unit
转测 public func getSubframes(): Option<ArrayList<ID3v2Frame>>
转测 public func setSubframes(subframes: Option<ArrayList<ID3v2Frame>>): Unit
转测 public func getLength(): Int32
转测 public func toString(): String

```

#### class EncodedText

```
/**
 * The Function is init constructor
 *
 * @param textEncoding of Int8，0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8
 * @param value of Array<Int8>，字节数据
 */
public init (string: String)
public init (textEncoding: Int8, string: String) 
public init (value: Array<Int8>)
public init (textEncoding: Int8, value: Array<Int8>)
public init (string: String, transcodeToTextEncoding: Int8)
public func getTextEncoding (): Int8
public func setTextEncoding (textEncoding: Int8): Unit
public func toBytes (): Array<Int8>
public func toString (): Option<String>
public func getCharacterSet (): String
```
