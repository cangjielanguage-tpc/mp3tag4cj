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
 * 得到文件的全路径名称
 *
 * @return Type of String
 * @since 0.31.4
 */
public open func getFilename (): String
/**
 * 得到文件的大小
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
public init (file: FileInfo)
public init (file: FileInfo, bufferLength: Int32)
public init (file: FileInfo, bufferLength: Int32, scanFile: Bool)
/**
 * 是否包含ID3v1标签
 *
 * @return Type of Bool
 * @since 0.31.4
 */
public func hasId3v1Tag (): Bool
/**
 * 获得ID3v1标签
 *
 * @return Type of Option<ID3v1>
 * @since 0.31.4
 */
public func getId3v1Tag (): Option<ID3v1>
/**
 * 设置ID3v1标签
 *
 * @param id3v1Tag of Option<ID3v1>
 *
 * @return Type of Unit
 * @since 0.31.4
 */
public func setId3v1Tag (id3v1Tag: Option<ID3v1>): Unit
/**
 * 移除ID3v1标签
 *
 * @return Type of Uni
 * @since 0.31.4
 */
public func removeId3v1Tag (): Unit
/**
 * 保存文件，不能保存同名文件
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
public func toBytes (): Array<Byte>
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
public static func matchGenreDescription (description: String): Int32
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