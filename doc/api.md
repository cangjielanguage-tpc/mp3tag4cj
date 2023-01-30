### 接口说明

主要是核心类和成员函数说明

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
 * 得到文件的全路径名称 核心接口
 *
 * @return Type of String
 * @since 0.31.4
 */
public open func getFilename (): String

/**
 * 得到文件的大小 核心接口
 *
 * @return Type of Int64
 * @since 0.31.4
 */
public open func getLength (): Int64
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

/**
* The Function is init constructor
* 
* @param file of FileInfo
* @since 0.31.4
*/
public init (file: FileInfo)

/**
* The Function is init constructor
* 
* @param file of FileInfo
* @param bufferLength of Int32
* @since 0.31.4
*/
public init (file: FileInfo, bufferLength: Int32)

/**
* The Function is init constructor
* 
* @param file of FileInfo
* @param bufferLength of Int32
* @param scanFile of Bool
* @since 0.31.4
*/
public init (file: FileInfo, bufferLength: Int32, scanFile: Bool)

/**
* The Function is init constructor
*
* @param path of Path
*/
public init (path: Path)

/**
* The Function is init constructor
*
* @param path of Path
* @param bufferLength of Int32
*/
public init (path: Path, bufferLength: Int32)

/**
* The Function is init constructor
*
* @param path of Path
* @param bufferLength of Int32
* @param scanFile of Bool
*/
public init (path: Path, bufferLength: Int32, scanFile: Bool)

/**
 * 是否包含ID3v1标签 核心接口
 *
 * @return Type of Bool
 * @since 0.31.4
 */
public func hasId3v1Tag (): Bool

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

/**
 * The Function is hasCustomTag, Include custom labels 核心接口
 * 
 * @return Type of Bool
 * @since 0.31.4
 */
public func hasCustomTag(): Bool

/**
 * 获取Custom标签 核心接口
 *
 * @return Type of Option
 * @since 0.31.4
 */
public func getCustomTag (): Option<Array<Int8>>

/**
 * 设置Custom标签 核心接口
 *
 * @param customTag of Option<Array<Int8>>
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func setCustomTag (customTag: Option<Array<Int8>>): Unit

/**
 * 移除ID3v2标签 核心接口
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func removeCustomTag (): Unit

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

/**
 * 获得音频数据帧开始的偏移量,如果存在Xing-header会越过Xing-header
 *
 * @return Type of Int32
 */
 public func getStartOffset(): Int32 

/**
 * 获得Xing-header开始的偏移量 核心接口
 *
 * @return Type of Int32
 */
public func getXingOffset(): Int32

/**
 * 获得音频数据帧结束的偏移量，如果有customTag在customTag之前 核心接口
 *
 * @return Type of Int32
 */
public func getEndOffset(): Int32

/**
 * 获得音频数据帧的数量 核心接口
 *
 * @return Type of Int32
 */
public func getFrameCount(): Int32

/**
 * 获得位率，若是可变位率的音频，该数值为平均位率 核心接口
 *
 * @return Type of Int32
 */
public func getBitrate(): Int32

/**
 * 获得Xing-header帧的位率 核心接口
 *
 * @return Type of Int32
 */
public func getXingBitrate(): Int32

/**
 * 获得位率集合，若scanfile为false时。该一个size只有1为第一个音频数据真的位率。
 * 集合的key为位率的值，MutableInteger 记录该位率出现的次数 核心接口
 *
 * @return Type of Map<Int32, MutableInteger>
 */
public func getBitrates(): Map<Int32, MutableInteger>

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
 * 获取MP3长度，单位毫秒 核心接口
 *
 * @return Type of Int64
 */
public func getLengthInMilliseconds(): Int64

/**
 * 获取MP3长度，单位秒 核心接口
 *
 * @return Type of Int64
 */
public func getLengthInSeconds(): Int64

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

/**
 * 判断是否有 xing帧 核心接口
 *
 * @return Type of Bool
 */
public func hasXingFrame(): Bool

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
public func toBytes (): Array<Int8>

/**
 * The Function is getVersion 核心接口
 * 
 * @return Type of String
 * @since 0.31.4
 */
public func getVersion (): String

/**
 * The Function is getTrack 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.31.4
 */
public func getTrack (): Option<String>

/**
 * The Function is setTrack 核心接口
 * 
 * @param track of Option<String>
 * 
 * @return Type of Unit
 * @since 0.31.4
 */
public func setTrack (track: Option<String>): Unit

/**
 * The Function is getArtist 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.31.4
 */
public func getArtist (): Option<String>

/**
 * The Function is setArtist 核心接口
 * 
 * @param artist of Option<String>
 * 
 * @return Type of Unit
 * @since 0.31.4
 */
public func setArtist (artist: Option<String>): Unit

/**
 * The Function is getTitle 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.31.4
 */
public func getTitle (): Option<String>

/**
 * The Function is setTitle 核心接口
 * 
 * @param title of Option<String>
 * 
 * @return Type of Unit
 * @since 0.31.4
 */
public func setTitle (title: Option<String>): Unit

/**
 * The Function is getAlbum 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.31.4
 */
public func getAlbum (): Option<String>

/**
 * The Function is setAlbum 核心接口
 * 
 * @param album of Option<String>
 * 
 * @return Type of Unit
 * @since 0.31.4
 */
public func setAlbum (album: Option<String>): Unit

/**
 * The Function is getYear 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.31.4
 */
public func getYear (): Option<String>

/**
 * The Function is setYear 核心接口
 * 
 * @param year of Option<String>
 * 
 * @return Type of Unit
 * @since 0.31.4
 */
public func setYear (year: Option<String>): Unit

/**
 * The Function is getGenre 核心接口
 * 
 * @return Type of Option<Int64>
 * @since 0.31.4
 */
public func getGenre (): Option<Int64>

/**
 * The Function is setGenre 核心接口
 * 
 * @param genre of Option<Int64>
 * 
 * @return Type of Unit
 * @since 0.31.4
 */
public func setGenre (genre: Option<Int64>): Unit

/**
 * The Function is getGenreDescription 核心接口
 * 
 * @return Type of String
 * @since 0.31.4
 */
public func getGenreDescription (): String

/**
 * The Function is getComment 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.31.4
 */
public func getComment (): Option<String>

/**
 * The Function is setComment 核心接口
 * 
 * @param comment of Option<String>
 * 
 * @return Type of Unit
 * @since 0.31.4
 */
public func setComment (comment: Option<String>): Unit
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
/**
 * The Function is init constructor
 * 
 * @param value of Int32
 * @since 0.31.4
 */
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
/**
 * The Function is init constructor.
 * 
 * @since 0.32.5
 */
public init ()

/**
 * The Function is init constructor.
 * 
 * @param bytes of Array<Int8>
 * @since 0.32.5
 */
public init (bytes: Array<Int8>)

/**
 * The Function is init constructor.
 * 
 * @param bytes of Array<Int8>
 * @param obseleteFormat of Bool
 * @since 0.32.5
 */
public init (bytes: Array<Int8>, obseleteFormat: Bool)

/**
 * The Function is toBytes, Convert object data to byte data. 核心接口
 * 
 * @return Type of Array<Int8>
 * @since 0.32.5
 */
public open func toBytes (): Array<Int8>

/**
 * The Function is getVersion, Get the version of id3v2 tag, including 2.0, 3.0 and 4.0. 核心接口
 * 
 * @return Type of String
 * @since 0.32.5
 */
public open func getVersion (): String

/**
 * 得到整个标签数据长度. 核心接口
 *
 * @return Type of Int32
 * @since 0.32.5
 */
public open func getDataLength (): Int32

/**
 * 得到整个标签长度。 核心接口
 *
 * @return Type of Int32
 * @since 0.32.5
 */
public open func getLength (): Int32

/**
 * 得到标签帧map，key为标签帧标识，value为标签帧数据集合封装类。 核心接口
 *
 * @return Type of HashMap<String, ID3v2FrameSet>
 * @since 0.32.5
 */
public open func getFrameSets (): HashMap<String, ID3v2FrameSet>

/**
 * The Function is getPadding
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func getPadding (): Bool

/**
 * 设置padding。设置之前会给dataLength置零 核心接口
 *
 * @param footer of Bool
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setPadding(padding: Bool): Unit

/**
 * The Function is hasFooter, Whether there is a label foot. 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasFooter (): Bool

/**
 * 只有id3v24版本支持设置标签页脚。其他版本设置无效。设置之前会给dataLength置零  核心接口
 *
 * @param footer of Bool
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setFooter (footer: Bool): Unit

/**
 * The Function is hasUnsynchronisation 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasUnsynchronisation (): Bool

/**
 * The Function is setUnsynchronisation。 设置之前会给dataLength置零 核心接口
 * 
 * @param unsynchronisation of Bool
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setUnsynchronisation (unsynchronisation: Bool): Unit

/**
 * The Function is getObseleteFormat, Is it observer mode. 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func getObseleteFormat (): Bool

/**
 * TRCK or TRK 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getTrack (): Option<String>

/**
 * The Function is setTrack。设置之前会给dataLength置零 核心接口
 * 
 * @param track of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setTrack (track: Option<String>): Unit

/**
 * TPOS or TPA 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getPartOfSet (): Option<String>

/**
 * The Function is setPartOfSet。 设置之前会给dataLength置零 核心接口
 * 
 * @param partOfSet of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setPartOfSet (partOfSet: Option<String>): Unit

/**
 * TCMP or TCP 标识对应的数据 核心接口
 *
 * @return Type of Bool
 * @since 0.32.5
 */
public open func isCompilation (): Bool

/**
 * The Function is setCompilation。 设置之前会给dataLength置零 核心接口
 * 
 * @param compilation of Bool
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setCompilation (compilation: Bool): Unit

/**
 * TIT1 or TT1 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getGrouping (): Option<String>

/**
 * The Function is setGrouping。设置之前会给dataLength置零 核心接口
 * 
 * @param grouping of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setGrouping (grouping: Option<String>): Unit

/**
 * TPE1 or TP1 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getArtist (): Option<String>

/**
 * The Function is setArtist。 设置之前会给dataLength置零 核心接口
 * 
 * @param artist of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setArtist (artist: Option<String>): Unit

/**
 * TPE2 or TP2 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getAlbumArtist (): Option<String>

/**
 * The Function is setAlbumArtist。 设置之前会给dataLength置零 核心接口
 * 
 * @param albumArtist of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setAlbumArtist (albumArtist: Option<String>): Unit

/**
 * TIT2 or TT2 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getTitle (): Option<String>

/**
 * The Function is setTitle。 设置之前会给dataLength置零 核心接口
 * 
 * @param title of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setTitle (title: Option<String>): Unit

/**
 * TALB or TAL 标识对应的数据 核心核心
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getAlbum (): Option<String>

/**
 * The Function is setAlbum。设置之前会给dataLength置零 核心接口
 * 
 * @param album of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setAlbum (album: Option<String>): Unit

/**
 * TYER or TYE 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getYear (): Option<String>

/**
 * The Function is setYear。 设置之前会给dataLength置零 核心接口
 * 
 * @param year of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setYear (year: Option<String>): Unit

/**
 * TDAT or TDA 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getDate (): Option<String>

/**
 * The Function is setDate。 设置之前会给dataLength置零 核心接口
 * 
 * @param date of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setDate (date: Option<String>): Unit

/**
 * TCON or TCO 标识对应的数据 核心接口
 *
 * @return Type of Option<Int64>
 * @since 0.32.5
 */
public func getGenre (): Option<Int64>

/**
 * The Function is setGenre。设置之前会给dataLength置零 核心接口
 * 
 * @param genre of Option<Int64>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setGenre (genre: Option<Int64>): Unit

/**
 * TBPM or TBP 标识对应的数据 核心接口
 *
 * @return Type of Option<Int32>
 * @since 0.32.5
 */
public open func getBPM (): Option<Int32>

/**
 * The Function is setBPM。设置之前会给dataLength置零  核心接口
 * 
 * @param bpm of Int32
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setBPM (bpm: Int32): Unit

/**
 * TKEY or TKE 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getKey (): Option<String>

/**
 * The Function is setKey  设置之前会给dataLength置零 核心接口
 * 
 * @param key of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setKey (key: Option<String>): Unit

/**
 * The Function is getGenreDescription 核心接口
 * 
 * @return Type of String
 * @since 0.32.5
 */
public open func getGenreDescription (): String

/**
 * The Function is setGenreDescription 核心接口
 * 
 * @param text of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setGenreDescription (text: Option<String>): Unit

/**
 * TCOM or TCM 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getComposer (): Option<String>

/**
 * The Function is setComposer TCOM or TCM 标识对应的数据 核心接口
 * 
 * @param composer of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setComposer (composer: Option<String>): Unit

/**
 * TPUB or TBP 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getPublisher (): Option<String>

/**
 * The Function is setPublisher TPUB or TBP 标识对应的数据 核心接口
 * 
 * @param publisher of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setPublisher (publisher: Option<String>): Unit

/**
 * TOPE or TOA 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getOriginalArtist (): Option<String>

/**
 * The Function is setOriginalArtist TOPE or TOA 标识对应的数据 核心接口
 * 
 * @param originalArtist of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setOriginalArtist (originalArtist: Option<String>): Unit

/**
 * TCOP or TCR 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getCopyright (): Option<String>

/**
 * The Function is setCopyright TCOP or TCR 标识对应的数据 核心接口
 * 
 * @param copyright of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setCopyright (copyright: Option<String>): Unit

/**
 * TENC or TEN 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.32.5
 */
public open func getEncoder (): Option<String>

/**
 * The Function is setEncoder TENC or TEN 标识对应的数据 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setEncoder (encoder: Option<String>): Unit

/**
 * COMM or COM 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getComment (): Option<String>

/**
 * The Function is setComment COMM or COM 标识对应的数据 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setComment (comment: Option<String>): Unit

/**
 * COMM or COM 标识且内容包含engiTunNORM的标签帧对应的数据 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getItunesComment (): Option<String>

/**
 * The Function is setItunesComment COMM or COM 标识且内容包含engiTunNORM的标签帧对应的数据 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setItunesComment (itunesComment: Option<String>): Unit

/**
 * 获取USLT标识对应的，eng后的内容数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getLyrics (): Option<String>

/**
 * The Function is setLyrics 获取USLT标识对应的，eng后的内容数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setLyrics (lyrics: Option<String>): Unit

/**
 * 获取WOAR标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getArtistUrl (): Option<String>、

/**
 * The Function is setArtistUrl 获取WOAR标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setArtistUrl (url: Option<String>): Unit

/**
 * 获取WCOM标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getCommercialUrl (): Option<String>

/**
 * The Function is setCommercialUrl 获取WCOM标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setCommercialUrl (url: Option<String>): Unit

/**
 * 获取WCOP标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getCopyrightUrl (): Option<String>

/**
 * The Function is setCopyrightUrl 获取WCOP标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setCopyrightUrl (url: Option<String>): Unit

/**
 * 获取WOAF标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getAudiofileUrl (): Option<String>

/**
 * The Function is setAudiofileUrl 获取WOAF标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setAudiofileUrl (url: Option<String>): Unit

/**
 * 获取WOAS标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getAudioSourceUrl (): Option<String>

/**
 * The Function is setAudioSourceUrl 获取WOAS标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setAudioSourceUrl (url: Option<String>): Unit

/**
 * 获取WORS标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getRadiostationUrl (): Option<String>

/**
 * The Function is setRadiostationUrl 获取WORS标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setRadiostationUrl (url: Option<String>): Unit

/**
 * 获取WPAY标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getPaymentUrl (): Option<String>

/**
 * The Function is setPaymentUrl 获取WPAY标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setPaymentUrl (url: Option<String>): Unit

/**
 * 获取WPUB标识对应的数据，无ob标识 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getPublisherUrl (): Option<String>

/**
 * The Function is setPublisherUrl 获取WPUB标识对应的数据，无ob标识 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setPublisherUrl (url: Option<String>): Unit

/**
 * WXXX or WXX 标识对应的数据 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getUrl (): Option<String>

/**
 * The Function is setUrl WXXX or WXX 标识对应的数据 核心接口
 * 
 * @param encoder of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setUrl (url: Option<String>): Unit

/**
 * 移除指定标识的标签帧 核心接口
 *
 * @param id of String
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public open func clearFrameSet (id: String): Unit

/**
 * 获得APIC标识中的图片数据. 核心接口
 *
 * @return Type of Option<Array<Int8>>
 * @since 0.33.3
 */
public open func getAlbumImage(): Option<Array<Int8>>

/**
 * 获得APIC标识中的MimeType数据，一般为image/png, image/jpeg. 核心接口
 *
 * @return Type of Option<String>
 * @since 0.33.3
 */
public open func getAlbumImageMimeType(): Option<String>

/**
 * 设置APIC标识中的数据 核心接口
 *
 * @param albumImage of Option<Array<Int8>> 图片的字节数据
 * @param mimeType of Option<String>，一般设置为image/png, image/jpeg
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setAlbumImage(albumImage: Option<Array<Int8>>, mimeType: Option<String>): Unit

/**
 * 设置APIC标识中的数据 核心接口
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
public open func setAlbumImage(albumImage: Option<Array<Int8>>, mimeType: Option<String>, imageType: Int8, imageDescription: Option<String>): Unit

/**
 * 得到CHAP标识数据，ID3v2ChapterFrameData为一个集合。参考ID3v2ChapterFrameData 提供的api。 核心接口
 *
 * @return Type of Option<ArrayList<ID3v2ChapterFrameData>>
 * @since 0.33.3
 */
public open func getChapters(): Option<ArrayList<ID3v2ChapterFrameData>>

/**
 * The Function is setChapters, CHAP 核心接口
 * 
 * @param chapters of Option<ArrayList<ID3v2ChapterFrameData>>, Provide CHAP data frame encapsulation type
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setChapters(chapters: Option<ArrayList<ID3v2ChapterFrameData>>): Unit

/**
 * 得到CTOC标识数据，ID3v2ChapterFrameData为一个集合。参考ID3v2ChapterTOCFrameData提供的api。 核心接口
 * 
 * @return Type of Option<ArrayList<ID3v2ChapterTOCFrameData>>
 * @since 0.33.3
 */
public open func getChapterTOC(): Option<ArrayList<ID3v2ChapterTOCFrameData>> 

/**
 * The Function is setChapterTOC, CTOC 核心接口
 * 
 * @param toc of Option<ArrayList<ID3v2ChapterTOCFrameData>>, Provide CTOC data frame encapsulation type
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setChapterTOC(toc: Option<ArrayList<ID3v2ChapterTOCFrameData>>): Unit

/**
 * 得到POPM标识数据 核心接口
 *
 * @return Type of Int32
 * @since 0.33.3
 */
public open func getWmpRating(): Int32

/**
 * 设置POPM标识数据, 有效值[0,5]  核心接口
 *
 * @param rating of Int32
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public open func setWmpRating(rating: Int32): Unit

/**
 * The Function is clearAlbumImage, Clear APIC or PIC label frame content 核心接口
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public open func clearAlbumImage(): Unit



```

#### class ID3v22Tag <: AbstractID3v2Tag

```
/**
 * The Function is init constructor
 * 
 * @since 0.32.5
 */
public init ()

/**
 * The Function is init constructor
 * 
 * @param buffer of Array<Int8>
 * @since 0.32.5
 */
public init (buffer: Array<Int8>)

/**
 * The Function is init constructor
 * 
 * @param buffer of Array<Int8>
 * @param obseleteFormat of Bool
 * @since 0.32.5
 */
public init (buffer: Array<Int8>, obseleteFormat: Bool)
```

#### class ID3v23Tag <: AbstractID3v2Tag

```
/**
 * The Function is init constructor
 * 
 * @since 0.32.5
 */
public init ()

/**
 * The Function is init constructor
 * 
 * @param buffer of Array<Int8>
 * @since 0.32.5
 */
public init (buffer: Array<Int8>)
```

#### class ID3v24Tag <: AbstractID3v2Tag

```
/**
 * The Function is init constructor
 * 
 * @since 0.34.3
 */
public init ()

/**
 * The Function is init constructor
 * 
 * @param buffer of Array<Int8>
 * @since 0.32.5
 */
public init (buffer: Array<Int8>)

/**
 * The Function is setGenreDescription 核心接口
 * 
 * @param text of String
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public func setGenreDescription (text: String): Unit

/**
 * The Function is getRecordingTime 核心接口
 * 
 * @return Type of Option<String>
 * @since 0.32.5
 */
public func getRecordingTime (): Option<String>

/**
 * The Function is setRecordingTime 核心接口
 * 
 * @param recTime of Option<String>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public func setRecordingTime (recTime: Option<String>): Unit
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
 * 将对象数据转换成字节数据 核心接口
 *
 * @return Type of Array<Int8>
 */
public open func toBytes (): Array<Int8>

/**
 * The Function is 获取id 核心接口
 * 
 * @return Type of String
 * @since 0.32.5
 */
public open func getId (): String

/**
 * The Function is getDataLength 核心接口
 * 
 * @return Type of Int32
 * @since 0.32.5
 */
public open func getDataLength (): Int32

/**
 * The Function is getLength, Get the length of the label frame. 核心接口 
 * 
 * @return Type of Int32
 * @since 0.32.5
 */
public open func getLength (): Int32

/**
 * The Function is getData, Get the data length of the tag frame. 核心接口
 * 
 * @return Type of Array<Int8>
 * @since 0.32.5
 */
public open func getData (): Array<Int8>

/**
 * The Function is setData 核心接口
 * 
 * @param data of Array<Int8>
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public open func setData (data: Array<Int8>): Unit

/**
 * The Function is 判断DataLengthIndicator 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasDataLengthIndicator (): Bool

/**
 * The Function is 判断Compression 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasCompression (): Bool

/**
 * The Function is 判断Encryption 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasEncryption (): Bool

/**
 * The Function is 判断Group 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasGroup (): Bool

/**
 * The Function is 判断PreserveFile 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasPreserveFile (): Bool

/**
 * The Function is 判断PreserveTag 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasPreserveTag (): Bool

/**
 * The Function is 判断是否ReadOnly 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func isReadOnly (): Bool

/**
 * The Function is 判断Unsynchronisation 核心接口
 * 
 * @return Type of Bool
 * @since 0.32.5
 */
public open func hasUnsynchronisation (): Bool
```

#### class ID3v2FrameSet

```
/**
 * The Function is init constructor
 *
 * @param id of String, 标签帧标识
 */
public init (id: String)

/**
 * The Function is getId, Get tag frame identification.
 * 
 * @return Type of String
 * @since 0.32.5
 */
public open func getId (): String

/**
 * The Function is addFrame, Add label frame objects.
 * 
 * @param frame of ID3v2Frame
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
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

/**
 * The Function is init constructor
 * 
 * @param frameData1 of Int8
 * @param frameData2 of Int8
 * @param frameData3 of Int8
 * @param frameData4 of Int8
 * @since 0.32.5
 */
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
/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @since 0.32.5
 */
public init (unsynchronisation: Bool)
```

#### class ID3v2TextFrameData

对id3v2 下列Track，PartOfSet，Compilation，Grouping，Artist，AlbumArtist，Title，Album，Year，Date，Genre，BPM，
Key，Composer，Publisher，OriginalArtist，Copyright，Encoder 标识的标签帧的解析和转码操作。

```
/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @since 0.32.5
 */
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

/**
 * The Function is getText, Get encoding conversion type.
 * 
 * @return Type of Option<EncodedText>
 * @since 0.32.5
 */
public func getText (): Option<EncodedText>

/**
 * The Function is setText
 * 
 * @param text of EncodedText
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public func setText (text: EncodedText): Unit
```

#### class ID3v2ChapterFrameData

```
/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @since 0.33.3
 */
public init(unsynchronisation: Bool)

/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @param id of Option<String>
 * @param startTime of Int32
 * @param endTime of Int32
 * @param startOffset of Int32
 * @param endOffset of Int32
 * @since 0.33.3
 */
public init(unsynchronisation: Bool, isRoot: Bool, isOrdered: Bool, id: Option<String>, children: Option<Array<String>>)

/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @param bytes of Array<Int8>
 * @since 0.33.3
 */
public init(unsynchronisation: Bool, bytes: Array<Int8>)

/**
 * The Function is addSubframe
 * 
 * @param id of String
 * @param frame of AbstractID3v2FrameData
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit

/**
 * The Function is 获取id
 * 
 * @return Type of Option<String>
 * @since 0.33.3
 */
public func getId(): Option<String>

/**
 * The Function is 设置Id
 * 
 * @param id of String
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setId(id: String): Unit

/**
 * The Function is 获取StartTime
 * 
 * @return Type of Int32
 * @since 0.33.3
 */
public func getStartTime(): Int32

/**
 * The Function is 设置StartTime
 * 
 * @param startTime of Int32
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setStartTime(startTime: Int32): Unit

/**
 * The Function is 获取EndTime
 * 
 * @return Type of Int32
 * @since 0.33.3
 */
public func getEndTime(): Int32

/**
 * The Function is 设置EndTime
 * 
 * @param endTime of Int32
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setEndTime(endTime: Int32): Unit

/**
* The Function is 获取StartOffset
* 
* @return Type of Int32
* @since 0.33.3
*/
public func getStartOffset(): Int32

/**
 * The Function is 设置StartOffset
 * 
 * @param startOffset of Int32
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setStartOffset(startOffset: Int32): Unit

/**
 * The Function is 获取EndOffset
 * 
 * @return Type of Int32
 * @since 0.33.3
 */
public func getEndOffset(): Int32

/**
 * The Function is 设置EndOffset
 * 
 * @param endOffset of Int32
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setEndOffset(endOffset: Int32): Unit

/**
* The Function is 获取子帧
* 
* @return Type of Option<ArrayList<ID3v2Frame>>
* @since 0.33.3
*/
public func getSubframes(): Option<ArrayList<ID3v2Frame>>

/**
* The Function is 设置子帧
* 
* @param subframes of Option<ArrayList<ID3v2Frame>>
* 
* @return Type of Unit
* @since 0.33.3
*/
public func setSubframes(subframes: Option<ArrayList<ID3v2Frame>>): Unit

/**
* The Function is 获取Length
* 
* @return Type of Int32
* @since 0.33.3
*/
public func getLength(): Int32

/**
 * The Function is toString
 * 
 * @return Type of String
 * @since 0.33.3
 */
public func toString(): String
```

#### class ID3v2ChapterTOCFrameData <: AbstractID3v2FrameData

```
/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @since 0.33.3
 */
public init(unsynchronisation: Bool)

/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @param isRoot of Bool
 * @param isOrdered of Bool
 * @param id of Option<String>
 * @param children of Option<Array<String>>
 * @since 0.33.3
 */
public init(unsynchronisation: Bool, isRoot: Bool, isOrdered: Bool, id: Option<String>, children: Option<Array<String>>)

/**
 * The Function is init constructor
 * 
 * @param unsynchronisation of Bool
 * @param bytes of Array<Int8>
 * @since 0.33.3
 */
public init(unsynchronisation: Bool, bytes: Array<Int8>)

/**
 * The Function is add子帧
 *
 * @param id of String
 * @param frame of AbstractID3v2FrameData
 *
 * @return Type of Unit
 * @since 0.34.3
 */
public func addSubframe(id: String, frame: AbstractID3v2FrameData): Unit

/**
 * The Function is 判断isRoot
 * 
 * @return Type of Bool
 * @since 0.33.3
 */
public func isRoot(): Bool

/**
 * The Function is setRoot
 * 
 * @param isRoot of Bool
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setRoot(isRoot: Bool): Unit

/**
 * The Function is 判断isOrdered
 * 
 * @return Type of Bool
 * @since 0.33.3
 */
public func isOrdered(): Bool

/**
 * The Function is setOrdered
 * 
 * @param isOrdered of Bool
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setOrdered(isOrdered: Bool): Unit

/**
 * The Function is 获取Id
 * 
 * @return Type of Option<String>
 * @since 0.33.3
 */
public func getId(): Option<String>

/**
 * The Function is setId
 * 
 * @param id of Option<String>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setId(id: Option<String>): Unit

/**
 * The Function is getChildren
 * 
 * @return Type of Option<Array<String>>
 * @since 0.33.3
 */
public func getChildren(): Option<Array<String>>

/**
 * The Function is setChildren
 * 
 * @param children of Option<Array<String>>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setChildren(children: Option<Array<String>>): Unit

/**
 * The Function is get子帧
 * 
 * @return Type of Option<ArrayList<ID3v2Frame>>
 * @since 0.33.3
 */
public func getSubframes(): Option<ArrayList<ID3v2Frame>>

/**
 * The Function is set子帧
 * 
 * @param subframes of Option<ArrayList<ID3v2Frame>>
 * 
 * @return Type of Unit
 * @since 0.33.3
 */
public func setSubframes(subframes: Option<ArrayList<ID3v2Frame>>): Unit

/**
 * The Function is getLength
 * 
 * @return Type of Int32
 * @since 0.33.3
 */
public func getLength(): Int32

/**
 * The Function is toString
 * 
 * @return Type of String
 * @since 0.33.3
 */
public func toString(): String

```

#### class EncodedText

```
/**
 * The Function is init constructor.
 * 
 * @param string of String
 * @since 0.32.5
 */
public init (string: String)

/**
 * The Function is init constructor.
 * 
 * @param textEncoding of Int8, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8
 * @param string of String
 * @since 0.32.5
 */
public init (textEncoding: Int8, string: String) 

/**
 * The Function is init constructor
 *
 * @param textEncoding of Int8，0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8
 * @param value of Array<Int8>，字节数据
 */
public init (string: String)
public init (textEncoding: Int8, string: String) 
public init (value: Array<Int8>)

/**
 * The Function is init constructor.
 * 
 * @param textEncoding of Int8, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8
 * @param value of Array<Int8>, Byte data
 * @since 0.32.5
 */
public init (textEncoding: Int8, value: Array<Int8>)

/**
 * The Function is init constructor.
 * 
 * @param string of String
 * @param transcodeToTextEncoding of Int8, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16, 2-CHARSET_UTF_16BE
 * 3-CHARSET_UTF_8
 * @since 0.32.5
 */
public init (string: String, transcodeToTextEncoding: Int8)

/**
 * The Function is getTextEncoding, Get the corresponding number of the code set.
 * 
 * @return Type of Int8
 * @since 0.32.5
 */
public func getTextEncoding (): Int8

/**
 * Set encoding and perform encoding conversion on value, Coding set 0-CHARSET_ISO_8859_1, 1-CHARSET_UTF_16,
 * 2-CHARSET_UTF_16BE, 3-CHARSET_UTF_8.
 * 
 * @param textEncoding of Int8
 * 
 * @return Type of Unit
 * @since 0.32.5
 */
public func setTextEncoding (textEncoding: Int8): Unit

/**
 * The Function is toBytes, Get byte data.
 * 
 * @return Type of Array<Int8>
 * @since 0.32.5
 */
public func toBytes (): Array<Int8>

/**
 * The Function is toString
 * 
 * @return Type of Option<String>
 * @since 0.33.3
 */
public func toString (): Option<String>

/**
 * The Function is 获取CharacterSet
 * 
 * @return Type of String
 * @since 0.33.3
 */
public func getCharacterSet (): String
```
