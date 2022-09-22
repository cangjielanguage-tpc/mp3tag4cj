package mp3agic


public class ID3v2TagFactory {

    private init (){}

    public static func createTag (bytes: Array<Int8>): Option<AbstractID3v2Tag> {
        sanityCheckTag(bytes);  //对bytes标签头头内容进行检查，包括标签头长度10字节， 前3个字节的内容， 和子版本好进行检查
        var majorVersion: Int8 = bytes[Int64(AbstractID3v2Tag.MAJOR_VERSION_OFFSET)]; //获得第4个字节的子版本号，也就是ID3 后面的一个字节
        match (majorVersion) {  // 安装子版本创建标签, 各个子版本都继承了AbstractID3v2Tag抽象类，重写了不同方法
            case 2 =>
                return createID3v22Tag(bytes)
            case 3 =>
                return Option<AbstractID3v2Tag>.Some(ID3v23Tag(bytes))
            case 4 =>
                return Option<AbstractID3v2Tag>.Some(ID3v24Tag(bytes))
            case _ =>
                throw UnsupportedTagException("Tag version not supported")
        }
    }

    private static func createID3v22Tag (bytes: Array<Int8>): Option<AbstractID3v2Tag> {
        var tag: ID3v22Tag = ID3v22Tag(bytes)
        if (tag.getFrameSets().isEmpty()) {
            tag = ID3v22Tag(bytes, true)
        }
        return Option<AbstractID3v2Tag>.Some(tag)
    }

    public static func sanityCheckTag (bytes: Array<Int8>): Unit {
        if (bytes.size < Int64(AbstractID3v2Tag.HEADER_LENGTH)) {
            throw NoSuchTagException("Buffer too short")
        }
        var tempStr: String = match(BufferTools.byteBufferToStringIgnoringEncodingIssues(BufferTools.transInt8ArrayToUInt8(bytes), 0, Int32(AbstractID3v2Tag.TAG.size))) {
            case Some(x) => x
            case None => ""
        }
        if ( !AbstractID3v2Tag.TAG.equals(tempStr)) {
            throw  NoSuchTagException("")
        }
        var majorVersion: Int8 = bytes[Int64(AbstractID3v2Tag.MAJOR_VERSION_OFFSET)]
        if (majorVersion != 2 && majorVersion != 3 && majorVersion != 4) {
            var minorVersion: Int8 = bytes[Int64(AbstractID3v2Tag.MINOR_VERSION_OFFSET)]
            throw UnsupportedTagException("Unsupported version 2.${majorVersion}.${minorVersion}")
        }
    }

}


