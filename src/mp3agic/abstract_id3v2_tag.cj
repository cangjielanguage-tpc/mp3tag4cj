/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Id3v2 version implementation class
 */
package mp3agic

from std import io.*
from std import convert.*
from std import unicode.*

/**
 * The class is AbstractID3v2Tag inherited from ID3v2
 * @since 0.32.5
 */
public open class AbstractID3v2Tag <: ID3v2 {
    public static let ID_IMAGE: String = "APIC"
    public static let ID_ENCODER: String = "TENC"
    public static let ID_URL: String = "WXXX"
    public static let ID_ARTIST_URL: String = "WOAR"
    public static let ID_COMMERCIAL_URL: String = "WCOM"
    public static let ID_COPYRIGHT_URL: String = "WCOP"
    public static let ID_AUDIOFILE_URL: String = "WOAF"
    public static let ID_AUDIOSOURCE_URL: String = "WOAS"
    public static let ID_RADIOSTATION_URL: String = "WORS"
    public static let ID_PAYMENT_URL: String = "WPAY"
    public static let ID_PUBLISHER_URL: String = "WPUB"
    public static let ID_COPYRIGHT: String = "TCOP"
    public static let ID_ORIGINAL_ARTIST: String = "TOPE"
    public static let ID_BPM: String = "TBPM"
    public static let ID_COMPOSER: String = "TCOM"
    public static let ID_PUBLISHER: String = "TPUB"
    public static let ID_COMMENT: String = "COMM"
    public static let ID_TEXT_LYRICS: String = "USLT"
    public static let ID_GENRE: String = "TCON"
    public static let ID_YEAR: String = "TYER"
    public static let ID_DATE: String = "TDAT"
    public static let ID_ALBUM: String = "TALB"
    public static let ID_TITLE: String = "TIT2"
    public static let ID_KEY: String = "TKEY"
    public static let ID_ARTIST: String = "TPE1"
    public static let ID_ALBUM_ARTIST: String = "TPE2"
    public static let ID_TRACK: String = "TRCK"
    public static let ID_PART_OF_SET: String = "TPOS"
    public static let ID_COMPILATION: String = "TCMP"
    public static let ID_CHAPTER_TOC: String = "CTOC"
    public static let ID_CHAPTER: String = "CHAP"
    public static let ID_GROUPING: String = "TIT1"
    public static let ID_RATING: String = "POPM"
    public static let ID_IMAGE_OBSELETE: String = "PIC"
    public static let ID_ENCODER_OBSELETE: String = "TEN"
    public static let ID_URL_OBSELETE: String = "WXX"
    public static let ID_COPYRIGHT_OBSELETE: String = "TCR"
    public static let ID_ORIGINAL_ARTIST_OBSELETE: String = "TOA"
    public static let ID_BPM_OBSELETE: String = "TBP"
    public static let ID_COMPOSER_OBSELETE: String = "TCM"
    public static let ID_PUBLISHER_OBSELETE: String = "TBP"
    public static let ID_COMMENT_OBSELETE: String = "COM"
    public static let ID_GENRE_OBSELETE: String = "TCO"
    public static let ID_YEAR_OBSELETE: String = "TYE"
    public static let ID_DATE_OBSELETE: String = "TDA"
    public static let ID_ALBUM_OBSELETE: String = "TAL"
    public static let ID_TITLE_OBSELETE: String = "TT2"
    public static let ID_KEY_OBSELETE: String = "TKE"
    public static let ID_ARTIST_OBSELETE: String = "TP1"
    public static let ID_ALBUM_ARTIST_OBSELETE: String = "TP2"
    public static let ID_TRACK_OBSELETE: String = "TRK"
    public static let ID_PART_OF_SET_OBSELETE: String = "TPA"
    public static let ID_COMPILATION_OBSELETE: String = "TCP"
    public static let ID_GROUPING_OBSELETE: String = "TT1"

    public static let PICTURETYPE_OTHER: Int8 = 0
    public static let PICTURETYPE_32PXICON: Int8 = 1
    public static let PICTURETYPE_OTHERICON: Int8 = 2
    public static let PICTURETYPE_FRONTCOVER: Int8 = 3
    public static let PICTURETYPE_BACKCOVER: Int8 = 4
    public static let PICTURETYPE_LEAFLET: Int8 = 5
    public static let PICTURETYPE_MEDIA: Int8 = 6
    public static let PICTURETYPE_LEADARTIST: Int8 = 7
    public static let PICTURETYPE_ARTIST: Int8 = 8
    public static let PICTURETYPE_CONDUCTOR: Int8 = 9
    public static let PICTURETYPE_BAND: Int8 = 10
    public static let PICTURETYPE_COMPOSER: Int8 = 11
    public static let PICTURETYPE_LYRICIST: Int8 = 12
    public static let PICTURETYPE_RECORDINGLOCATION: Int8 = 13
    public static let PICTURETYPE_DURING_RECORDING: Int8 = 14
    public static let PICTURETYPE_DURING_PERFORMANCE: Int8 = 15
    public static let PICTURETYPE_SCREEN_CAPTURE: Int8 = 16
    public static let PICTURETYPE_ILLUSTRATION: Int8 = 18
    public static let PICTURETYPE_BAND_LOGOTYPE: Int8 = 19
    public static let PICTURETYPE_PUBLISHER_LOGOTYPE: Int8 = 20

    protected static let TAG: String = "ID3"
    protected static let FOOTER_TAG: String = "3DI"
    protected static let HEADER_LENGTH: Int32 = 10
    protected static let FOOTER_LENGTH: Int32 = 10
    protected static let MAJOR_VERSION_OFFSET: Int32 = 3
    protected static let MINOR_VERSION_OFFSET: Int32 = 4
    protected static let FLAGS_OFFSET: Int32 = 5
    protected static let DATA_LENGTH_OFFSET: Int32 = 6
    protected static let FOOTER_BIT: Int32 = 4
    protected static let EXPERIMENTAL_BIT: Int32 = 5
    protected static let EXTENDED_HEADER_BIT: Int32 = 6
    protected static let COMPRESSION_BIT: Int32 = 6
    protected static let UNSYNCHRONISATION_BIT: Int32 = 7
    protected static let PADDING_LENGTH: Int32 = 256
    private static let ITUNES_COMMENT_DESCRIPTION: String = "iTunNORM"

    protected var unsynchronisation: Bool = false
    protected var extendedHeader: Bool = false
    protected var experimental: Bool = false
    protected var footer: Bool = false
    protected var compression: Bool = false
    protected var padding: Bool = false
    protected var version: String = ""
    private var dataLength: Int32 = 0
    private var extendedHeaderLength: Int32 = 0
    private var extendedHeaderData: Array<Int8> = Array<Int8>()
    private var obseleteFormat: Bool = false

    private var frameSets: HashMap<String, ID3v2FrameSet> = HashMap<String, ID3v2FrameSet>()

    /**
     * The Function is init constructor.
     * 
     * @since 0.32.5
     */
    public init() {
        frameSets = HashMap<String, ID3v2FrameSet>()
    }

    /**
     * The Function is init constructor.
     * 
     * @param bytes of Array<Int8>
     * @since 0.32.5
     */
    public init(bytes: Array<Int8>) {
        this(bytes, false)
    }

    /**
     * The Function is init constructor.
     * 
     * @param bytes of Array<Int8>
     * @param obseleteFormat of Bool
     * @since 0.32.5
     */
    public init(bytes: Array<Int8>, obseleteFormat: Bool) {
        var buffet = bytes
        frameSets = HashMap<String, ID3v2FrameSet>()
        this.obseleteFormat = obseleteFormat
        //unpackTag(bytes)
    }

    protected func unpackTag(bytes: Array<Int8>): Unit {
        ID3v2TagFactory.sanityCheckTag(bytes)
        var offset: Int32 = unpackHeader(bytes)
        try {
            if (extendedHeader) {
                offset = unpackExtendedHeader(bytes, offset)
            }
            var framesLength: Int32 = dataLength
            if (footer) {
                framesLength -= 10
            }
            offset = unpackFrames(bytes, offset, framesLength)
            if (footer) {
                offset = unpackFooter(bytes, dataLength)
            }
        } catch (e: Exception) {
            throw InvalidDataException("Premature end of tag ${e}")
        }
    }

    private func unpackHeader(bytes: Array<Int8>): Int32 {
        var majorVersion: Int8 = bytes[Int64(MAJOR_VERSION_OFFSET)]
        var minorVersion: Int8 = bytes[Int64(MINOR_VERSION_OFFSET)]
        version = majorVersion.toString() + "." + minorVersion.toString()
        if (majorVersion != 2 && majorVersion != 3 && majorVersion != 4) {
            throw UnsupportedTagException("Unsupported version ${version}")
        }
        unpackFlags(bytes)
        if ((bytes[Int64(FLAGS_OFFSET)] & 15) != 0) {
            throw UnsupportedTagException("Unrecognised bits in header")
        }
        dataLength = BufferTools.unpackSynchsafeInteger(
            bytes[Int64(DATA_LENGTH_OFFSET)],
            bytes[Int64(DATA_LENGTH_OFFSET) + 1],
            bytes[Int64(DATA_LENGTH_OFFSET) + 2],
            bytes[Int64(DATA_LENGTH_OFFSET) + 3]
        )
        if (Int64(dataLength) < 1) {
            throw InvalidDataException("Zero size tag")
        }
        return HEADER_LENGTH
    }

    protected open func unpackFlags(bytes: Array<Int8>): Unit {
        var buffer = bytes
    }
    protected open func packFlags(bytes: Array<Int8>, i: Int32): Unit {
        var byte = bytes[Int64(i)]
    }

    private func unpackExtendedHeader(bytes: Array<Int8>, offset: Int32): Int32 {
        extendedHeaderLength = BufferTools.unpackSynchsafeInteger(
            bytes[Int64(offset)],
            bytes[Int64(offset) + 1],
            bytes[Int64(offset) + 2],
            bytes[Int64(offset) + 3]
        ) + 4
        extendedHeaderData = BufferTools.transUInt8ArrayToInt8(
            BufferTools.copyBuffer(
                BufferTools.transInt8ArrayToUInt8(bytes),
                Int64(offset) + 4,
                Int64(extendedHeaderLength)
            )
        )
        return extendedHeaderLength
    }

    protected open func unpackFrames(bytesIn: Array<Int8>, offset: Int32, framesLength: Int32): Int32 {
        var currentOffsetTmp: Int32 = offset
        while (Int64(currentOffsetTmp) <= Int64(framesLength)) {
            var frameTmp: ID3v2Frame
            try {
                frameTmp = createFrame(bytesIn, currentOffsetTmp)
                addFrame(frameTmp, false)
                currentOffsetTmp += frameTmp.getLength()
            } catch (e: Exception) {
                break
            }
        }
        return currentOffsetTmp
    }

    protected open func addFrame(frame: ID3v2Frame, replace: Bool): Unit {
        var frameSetVar: ID3v2FrameSet = ID3v2FrameSet("")
        var isNone: Bool = false
        match (frameSets.get(frame.getId())) {
            case Some(x) => frameSetVar = x
            case None => isNone = true
        }
        if (isNone) {
            frameSetVar = ID3v2FrameSet(frame.getId())
            frameSetVar.addFrame(frame)
            frameSets.put(frame.getId(), frameSetVar)
            ()
        } else if (replace) {
            frameSetVar.clear()
            frameSetVar.addFrame(frame)
        } else {
            frameSetVar.addFrame(frame)
        }
    }

    protected open func createFrame(bytes: Array<Int8>, currentOffset: Int32): ID3v2Frame {
        if (obseleteFormat) {
            return ID3v2ObseleteFrame(bytes, currentOffset)
        }
        var id3v2Frame: ID3v2Frame = ID3v2Frame(bytes, currentOffset)
        id3v2Frame.unpackFrame(bytes, currentOffset)
        return id3v2Frame
    }

    protected open func createFrame(id: String, data: Array<Int8>): ID3v2Frame {
        if (obseleteFormat) {
            return ID3v2ObseleteFrame(id, data)
        } else {
            return ID3v2Frame(id, data)
        }
    }

    private func unpackFooter(bytes: Array<Int8>, offset: Int32): Int32 {
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(
            BufferTools.transInt8ArrayToUInt8(bytes),
            offset,
            Int32(FOOTER_TAG.size)
        )) {
            case Some(x) =>
                if (!FOOTER_TAG.equals(x)) {
                    throw InvalidDataException("Invalid footer")
                }
            case None => throw InvalidDataException("Invalid footer")
        }
        return FOOTER_LENGTH
    }

    /**
     * The Function is toBytes, Convert object data to byte data.
     * 
     * @return Type of Array<Int8>
     * @since 0.32.5
     */
    public open func toBytes(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {i => 0})
        packTag(bytes)
        return bytes
    }

    /**
     * The Function is packTag, Convert object data into byte data and put it into parameter bytes.
     * 
     * @param bytes of Array<Int8>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func packTag(bytes: Array<Int8>): Unit {
        var offset: Int32 = packHeader(bytes, 0)
        if (extendedHeader) {
            offset = packExtendedHeader(bytes, offset)
        }
        offset = packFrames(bytes, offset)
        if (footer) {
            offset = packFooter(bytes, dataLength)
        }
    }

    @overflowWrapping
    private func packHeader(bytes: Array<Int8>, offset: Int32): Int32 {
        try {
            BufferTools.stringIntoByteBuffer(TAG, 0, TAG.size, bytes, Int64(offset))
        } catch (e: Exception) {}
        var s: Array<String> = version.split(".")
        if (s.size > 0) {
            var majorVersion: Int8 = Int8(Int64.parse(s[0]))
            bytes[Int64(offset) + Int64(MAJOR_VERSION_OFFSET)] = majorVersion
        }
        if (s.size > 1) {
            var minorVersion: Int8 = Int8(Int64.parse(s[1]))
            bytes[Int64(offset) + Int64(MINOR_VERSION_OFFSET)] = minorVersion
        }
        packFlags(bytes, offset)
        BufferTools.packSynchsafeInteger(getDataLength(), bytes, offset + DATA_LENGTH_OFFSET)
        return offset + HEADER_LENGTH
    }

    private func packExtendedHeader(bytes: Array<Int8>, offset: Int32): Int32 {
        BufferTools.packSynchsafeInteger(extendedHeaderLength, bytes, offset)
        BufferTools.copyIntoByteBuffer(extendedHeaderData, 0, extendedHeaderData.size, bytes, Int64(offset) + 4)
        return offset + 4 + Int32(extendedHeaderData.size)
    }

    /**
     * The Function is packFrames, Convert tag frame data into byte data and store it in bytes.
     * 
     * @param bytes of Array<Int8>, Container for storing data
     * @param offset of Int32, Offset to start storing label frame data.
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public open func packFrames(bytes: Array<Int8>, offset: Int32): Int32 {
        var newOffset: Int32 = packSpecifiedFrames(bytes, offset, Option<String>.None, "APIC")
        newOffset = packSpecifiedFrames(bytes, newOffset, "APIC", Option<String>.None)
        return newOffset
    }

    private func packSpecifiedFrames(bytes: Array<Int8>, offset: Int32, onlyId: Option<String>, notId: Option<String>): Int32 {
        var offsetNew = offset
        var sortFrameSets: HashMap<String, ID3v2FrameSet> = sortMap(frameSets)
        for ((key, frameSet) in sortFrameSets) {
            if ((onlyId == Option<String>.None || onlyId.getOrDefault({ => ""}).equals(frameSet.getId())) && (notId ==
                Option<String>.None || !notId.getOrDefault({ => ""}).equals(frameSet.getId()))) {
                for (frame in frameSet.getFrames()) {
                    if (frame.getDataLength() > 0) {
                        var frameData: Array<Int8> = frame.toBytes()
                        BufferTools.copyIntoByteBuffer(frameData, 0, frameData.size, bytes, Int64(offsetNew))
                        offsetNew += Int32(frameData.size)
                    }
                }
            }
        }
        return offsetNew
    }

    private func sortMap(map: HashMap<String, ID3v2FrameSet>): HashMap<String, ID3v2FrameSet> {
        var sortMap: HashMap<String, ID3v2FrameSet> = HashMap<String, ID3v2FrameSet>()
        var keyList: ArrayList<String> = ArrayList<String>()
        for ((key, frameSet) in frameSets) {
            keyList.append(key)
        }
        if (keyList.size > 0) {
            keyList.sortBy(
                {
                    rht: String, lht: String =>
                    if (rht < lht) {
                        return Ordering.LT
                    }
                    if (rht > lht) {
                        return Ordering.GT
                    }
                    return Ordering.EQ
                },
                stable: true
            )
        } else {
            return map
        }
        for (key in keyList) {
            match (map.get(key)) {
                case Some(x) => sortMap.put(key, x)
                case None => return map
            }
        }
        return sortMap
    }

    @overflowWrapping
    private func packFooter(bytes: Array<Int8>, offset: Int32): Int32 {
        try {
            BufferTools.stringIntoByteBuffer(FOOTER_TAG, 0, FOOTER_TAG.size, bytes, Int64(offset))
        } catch (e: Exception) {}
        var s: Array<String> = version.split(".")
        if (s.size > 0) {
            var majorVersion: Int8 = Int8(Int64.parse(s[0]))
            bytes[Int64(offset) + Int64(MAJOR_VERSION_OFFSET)] = majorVersion
        }
        if (s.size > 1) {
            var minorVersion: Int8 = Int8(Int64.parse(s[1]))
            bytes[Int64(offset) + Int64(MINOR_VERSION_OFFSET)] = minorVersion
        }
        packFlags(bytes, offset)
        BufferTools.packSynchsafeInteger(getDataLength(), bytes, offset + DATA_LENGTH_OFFSET)
        return offset + FOOTER_LENGTH
    }

    private func calculateDataLength(): Int32 {
        var length: Int32 = 0
        if (extendedHeader) {
            length += extendedHeaderLength
        }
        if (footer) {
            length += FOOTER_LENGTH
        } else if (padding) {
            length += PADDING_LENGTH
        }
        for (frameSet in frameSets.values()) {
            for (frame in frameSet.getFrames()) {
                length += frame.getLength()
            }
        }
        return length
    }

    protected open func useFrameUnsynchronisation(): Bool {
        return false
    }

    /**
     * The Function is getVersion, Get the version of id3v2 tag, including 2.0, 3.0 and 4.0.
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public open func getVersion(): String {
        return version
    }

    protected open func invalidateDataLength(): Unit {
        dataLength = 0
    }

    /**
     * The Function is getDataLength, Get the data length of the entire id3v2 tag, excluding the header.
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public open func getDataLength(): Int32 {
        if (Int64(dataLength) == 0) {
            dataLength = calculateDataLength()
        }
        return dataLength
    }

    /**
     * The Function is getLength, Get the length of a real id3v2 tag
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public open func getLength(): Int32 {
        return getDataLength() + HEADER_LENGTH
    }

    /**
     * The Function is getFrameSets, Get a map of tag frames, The tag frame set is obtained. Key is the tag frame identifier,
     * and value is the tag frame data set
     * 
     * @return Type of HashMap<String, ID3v2FrameSet>
     * @since 0.32.5
     */
    public open func getFrameSets(): HashMap<String, ID3v2FrameSet> {
        return frameSets
    }

    /**
     * The Function is getPadding
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func getPadding(): Bool {
        return padding
    }

    /**
     * The Function is hasFooter, Whether there is a label foot.
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasFooter(): Bool {
        return footer
    }

    /**
     * The Function is setFooter, Only the id3v24 version supports setting label footers. Other version settings are invalid.
     * 
     * @param footer of Bool
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setFooter(footer: Bool): Unit {
        if (this.footer != footer) {
            invalidateDataLength()
            this.footer = footer
        }
    }

    /**
     * The Function is hasUnsynchronisation
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func hasUnsynchronisation(): Bool {
        return unsynchronisation
    }

    /**
     * The Function is setUnsynchronisation
     * 
     * @param unsynchronisation of Bool
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setUnsynchronisation(unsynchronisation: Bool): Unit {
        if (this.unsynchronisation != unsynchronisation) {
            invalidateDataLength()
            this.unsynchronisation = unsynchronisation
        }
    }

    /**
     * The Function is getObseleteFormat, Is it observer mode.
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func getObseleteFormat(): Bool {
        return obseleteFormat
    }

    /**
     * The Function is getTrack, TRCK or TRK Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getTrack(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_TRACK_OBSELETE
            } else {
                ID_TRACK
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setTrack
     * 
     * @param track of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setTrack(track: Option<String>): Unit {
        if (track != Option<String>.None && track.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(track.getOrThrow())
            )
            addFrame(createFrame(ID_TRACK, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getPartOfSet, TPOS or TPA Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getPartOfSet(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_PART_OF_SET_OBSELETE
            } else {
                ID_PART_OF_SET
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setPartOfSet
     * 
     * @param partOfSet of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setPartOfSet(partOfSet: Option<String>): Unit {
        if (partOfSet != Option<String>.None && partOfSet.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(partOfSet.getOrThrow())
            )
            addFrame(createFrame(ID_PART_OF_SET, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is isCompilation,TCMP or TCP Identify the corresponding data.
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public open func isCompilation(): Bool {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_COMPILATION_OBSELETE
            } else {
                ID_COMPILATION
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return "1".equals(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return false;
    }

    /**
     * The Function is setCompilation
     * 
     * @param compilation of Bool
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setCompilation(compilation: Bool): Unit {
        invalidateDataLength()
        var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
            useFrameUnsynchronisation(),
            EncodedText(
                if (compilation) {
                    "1"
                } else {
                    "0"
                }
            )
        );
        addFrame(createFrame(ID_COMPILATION, frameData.toBytes()), true)
    }

    /**
     * The Function is getGrouping, TIT1 or TT1 Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getGrouping(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_GROUPING_OBSELETE
            } else {
                ID_GROUPING
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setGrouping
     * 
     * @param grouping of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setGrouping(grouping: Option<String>): Unit {
        if (grouping != Option<String>.None && grouping.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(grouping.getOrThrow())
            )
            addFrame(createFrame(ID_GROUPING, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getArtist, TPE1 or TP1 Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getArtist(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ARTIST_OBSELETE
            } else {
                ID_ARTIST
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setArtist
     * 
     * @param artist of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setArtist(artist: Option<String>): Unit {
        if (artist != Option<String>.None && artist.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(artist.getOrThrow())
            )
            addFrame(createFrame(ID_ARTIST, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getAlbumArtist, TPE2 or TP2 Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getAlbumArtist(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ALBUM_ARTIST_OBSELETE
            } else {
                ID_ALBUM_ARTIST
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setAlbumArtist
     * 
     * @param albumArtist of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setAlbumArtist(albumArtist: Option<String>): Unit {
        if (albumArtist != Option<String>.None && albumArtist.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(albumArtist.getOrThrow())
            )
            addFrame(createFrame(ID_ALBUM_ARTIST, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getTitle, TIT2 or TT2 Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getTitle(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_TITLE_OBSELETE
            } else {
                ID_TITLE
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setTitle
     * 
     * @param title of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setTitle(title: Option<String>): Unit {
        if (title != Option<String>.None && title.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(title.getOrThrow())
            )
            addFrame(createFrame(ID_TITLE, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getAlbum, TALB or TAL Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getAlbum(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ALBUM_OBSELETE
            } else {
                ID_ALBUM
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setAlbum
     * 
     * @param album of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setAlbum(album: Option<String>): Unit {
        if (album != Option<String>.None && album.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(album.getOrThrow())
            )
            addFrame(createFrame(ID_ALBUM, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getYear, TYER or TYE Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getYear(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_YEAR_OBSELETE
            } else {
                ID_YEAR
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setYear
     * 
     * @param year of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setYear(year: Option<String>): Unit {
        if (year != Option<String>.None && year.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(year.getOrThrow())
            )
            addFrame(createFrame(ID_YEAR, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getDate, TDAT or TDA Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getDate(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_DATE_OBSELETE
            } else {
                ID_DATE
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            match (frameData.getOrThrow().getText()) {
                case Some(x) => return Option<String>.Some(x.toString().getOrDefault({ => ""}))
                case None => ()
            }
        }
        return Option<String>.None
    }

    /**
     * The Function is setDate
     * 
     * @param date of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setDate(date: Option<String>): Unit {
        if (date != Option<String>.None && date.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(date.getOrThrow())
            )
            addFrame(createFrame(ID_DATE, frameData.toBytes()), true)
        }
    }

    private func getGenre(text: Option<String>): Option<Int64> {
        if (text != Option<String>.None && text.getOrThrow().size > 0) {
            try {
                return extractGenreNumber(text.getOrThrow())
            } catch (e: Exception) {
                var description: Option<String> = extractGenreDescription(text.getOrThrow())
                return Option<Int64>.Some(Int64(ID3v1Genres.matchGenreDescription(description)))
            }
        }
        return -1
    }

    /**
     * The Function is getGenre, TCON or TCO Identify the corresponding data.
     * 
     * @return Type of Option<Int64>
     * @since 0.32.5
     */
    public func getGenre(): Option<Int64> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_GENRE_OBSELETE
            } else {
                ID_GENRE
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return Option<Int64>.Some(-1)
        }
        return getGenre(frameData.getOrThrow().getText().getOrThrow().toString())
    }

    /**
     * The Function is setGenre
     * 
     * @param genre of Option<Int64>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setGenre(genre: Option<Int64>): Unit {
        if (genre != Option<Int64>.None && genre.getOrThrow() >= 0) {
            invalidateDataLength()
            var genreDescription: String = ""
            if (genre.getOrThrow() < ID3v1Genres.GENRES.size) {
                genreDescription = ID3v1Genres.GENRES[genre.getOrThrow()]
            }
            var combinedGenre: String = "(${genre.getOrThrow()})${genreDescription}"
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(combinedGenre)
            )
            addFrame(createFrame(ID_GENRE, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getBPM, TBPM or TBP Identify the corresponding data.
     * 
     * @return Type of Option<Int32>
     * @since 0.32.5
     */
    public open func getBPM(): Option<Int32> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_BPM_OBSELETE
            } else {
                ID_BPM
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return Option<Int32>.Some(-1)
        }
        var bpmStr: Option<String> = frameData.getOrThrow().getText().getOrThrow().toString()
        try {
            match (bpmStr) {
                case Some(x) => return Option<Int32>.Some(Int32.parse(x))
                case None => return Option<Int32>.Some(-1)
            }
        } catch (e: Exception) {
            // try float as some utilities add BPM like 67.8, or 67,8
            match (bpmStr) {
                case Some(x) => return Option<Int32>.Some(Int32(Float32.parse(x.trim().replace(",", "."))))
                case None => return Option<Int32>.Some(-1)
            }
        }
    }

    /**
     * The Function is setBPM
     * 
     * @param bpm of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setBPM(bpm: Int32): Unit {
        if (bpm >= 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(bpm.toString())
            )
            addFrame(createFrame(ID_BPM.toString(), frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getKey, TKEY or TKE Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getKey(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_KEY_OBSELETE
            } else {
                ID_KEY
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return Option<String>.None
        }
        return frameData.getOrThrow().getText().getOrThrow().toString()
    }

    /**
     * The Function is setKey
     * 
     * @param key of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setKey(key: Option<String>): Unit {
        if (key != Option<String>.None && key.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(key.getOrThrow())
            )
            addFrame(createFrame(ID_KEY, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getGenreDescription
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public open func getGenreDescription(): String {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_GENRE_OBSELETE
            } else {
                ID_GENRE
            }
        )
        if (frameData == Option<ID3v2TextFrameData>.None || frameData.getOrThrow().getText() == Option<EncodedText>.None) {
            return ""
        }
        var text: Option<String> = frameData.getOrThrow().getText().getOrThrow().toString();
        if (text != Option<String>.None) {
            var genreNumOp: Option<Int64> = getGenre(text)
            var genreNum: Int64
            match (genreNumOp) {
                case Some(x) => genreNum = x
                case None => genreNum = -1
            }
            if (genreNum >= 0 && genreNum < ID3v1Genres.GENRES.size) {
                return ID3v1Genres.GENRES[genreNum]
            } else {
                var description: Option<String> = extractGenreDescription(text.getOrThrow())
                if (description != Option<String>.None && description.getOrThrow().size > 0) {
                    return description.getOrThrow()
                }
            }
        }
        return ""
    }

    /**
     * The Function is setGenreDescription
     * 
     * @param text of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setGenreDescription(text: Option<String>): Unit {
        var genreNum: Int32 = ID3v1Genres.matchGenreDescription(text)
        if (genreNum < 0) {
            throw IllegalArgumentException("Unknown genre: ${text.getOrDefault({=>""})}")
        }
        setGenre(Option<Int64>.Some(Int64(genreNum)))
    }

    protected open func extractGenreNumber(genreValue: String): Option<Int64> {
        var value: String = genreValue.trim()
        if (value.size > 0) {
            if (value.charAt(0) == '(') {
                var pos: Option<Int64> = value.indexOf(')')
                match (pos) {
                    case Some(x) =>
                        if (x > 0) {
                            return Option<Int64>.Some(Int64.parse(value.substring(1, x - "(".size)))
                        }
                    case None => ()
                }
            }
        }
        return Option<Int64>.Some(Int64.parse(value))
    }

    /*
     * The Function is extractGenreDescription
     *
     * @param genreValue of String
     *
     * @return Type of Option<String>
     * @since 0.32.5
     */
    protected open func extractGenreDescription(genreValue: String): Option<String> {
        var value: String = genreValue.trim();
        if (value.size > 0) {
            if (value.charAt(0) == '(') {
                var pos: Option<Int64> = value.indexOf(')')
                match (pos) {
                    case Some(x) =>
                        if (x > 0) {
                            return Option<String>.Some(value.substring(x + 1))
                        }
                    case None => ()
                }
            }
            return Option<String>.Some(value)
        }
        return Option<String>.None
    }

    /**
     * The Function is getComposer, TCOM or TCM Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getComposer(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_COMPOSER_OBSELETE
            } else {
                ID_COMPOSER
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            return frameData.getOrThrow().getText().getOrThrow().toString().getOrDefault({ => ""})
        }
        return Option<String>.None
    }

    /**
     * The Function is setComposer
     * 
     * @param composer of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setComposer(composer: Option<String>): Unit {
        if (composer != Option<String>.None && composer.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(composer.getOrThrow())
            )
            addFrame(createFrame(ID_COMPOSER, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getPublisher, TPUB or TBP Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getPublisher(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_PUBLISHER_OBSELETE
            } else {
                ID_PUBLISHER
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            return frameData.getOrThrow().getText().getOrThrow().toString().getOrDefault({ => ""})
        }
        return Option<String>.None
    }

    /**
     * The Function is setPublisher
     * 
     * @param publisher of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setPublisher(publisher: Option<String>): Unit {
        if (publisher != Option<String>.None && publisher.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(publisher.getOrThrow())
            )
            addFrame(createFrame(ID_PUBLISHER, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getOriginalArtist, TOPE or TOA Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getOriginalArtist(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ORIGINAL_ARTIST_OBSELETE
            } else {
                ID_ORIGINAL_ARTIST
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            return frameData.getOrThrow().getText().getOrThrow().toString().getOrDefault({ => ""})
        }
        return Option<String>.None
    }

    /**
     * The Function is setOriginalArtist
     * 
     * @param originalArtist of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setOriginalArtist(originalArtist: Option<String>): Unit {
        if (originalArtist != Option<String>.None && originalArtist.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(originalArtist.getOrThrow())
            )
            addFrame(createFrame(ID_ORIGINAL_ARTIST, frameData.toBytes()), true)
        }
    }

    public open func getComment(): Option<String> {
        return ""
    }
    public open func setComment(comment: Option<String>): Unit {
        var comment = comment ?? ""
    }

    /**
     * The Function is getCopyright, TCOP or TCR Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getCopyright(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_COPYRIGHT_OBSELETE
            } else {
                ID_COPYRIGHT
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            return frameData.getOrThrow().getText().getOrThrow().toString().getOrDefault({ => ""})
        }
        return Option<String>.None
    }

    /**
     * The Function is setCopyright
     * 
     * @param copyright of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setCopyright(copyright: Option<String>): Unit {
        if (copyright != Option<String>.None && copyright.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(copyright.getOrThrow())
            )
            addFrame(createFrame(ID_COPYRIGHT, frameData.toBytes()), true)
        }
    }

    /**
     * The Function is getEncoder, TENC or TEN Identify the corresponding data.
     * 
     * @return Type of Option<String>
     * @since 0.32.5
     */
    public open func getEncoder(): Option<String> {
        var frameData: Option<ID3v2TextFrameData> = extractTextFrameData(
            if (obseleteFormat) {
                ID_ENCODER_OBSELETE
            } else {
                ID_ENCODER
            }
        )
        if (frameData != Option<ID3v2TextFrameData>.None && frameData.getOrThrow().getText() != Option<EncodedText>.None) {
            return frameData.getOrThrow().getText().getOrThrow().toString().getOrDefault({ => ""})
        }
        return Option<String>.None
    }

    /**
     * The Function is setEncoder
     * 
     * @param encoder of Option<String>
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public open func setEncoder(encoder: Option<String>): Unit {
        if (encoder != Option<String>.None && encoder.getOrThrow().size > 0) {
            invalidateDataLength()
            var frameData: ID3v2TextFrameData = ID3v2TextFrameData(
                useFrameUnsynchronisation(),
                EncodedText(encoder.getOrThrow())
            )
            addFrame(createFrame(ID_ENCODER, frameData.toBytes()), true)
        }
    }

    protected open func extractTextFrameData(id: String): Option<ID3v2TextFrameData> {
        var frameSet: Option<ID3v2FrameSet> = frameSets.get(id)
        match (frameSet) {
            case Some(x) =>
                var frame: ID3v2Frame = x.getFrames()[0]
                var frameData: ID3v2TextFrameData
                try {
                    frameData = ID3v2TextFrameData(useFrameUnsynchronisation(), frame.getData())
                    return frameData
                } catch (e: InvalidDataException) {}
            case None => ()
        }
        return Option<ID3v2TextFrameData>.None
    }
}
