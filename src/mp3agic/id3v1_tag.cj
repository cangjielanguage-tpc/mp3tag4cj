/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * ID3v1 of the label
 */
package mp3agic

from std import io.*
from std import math.*
from std import convert.*
from std import collection.*

/**
 * The class is ID3v1Tag inherited from ID3v1
 * @since 0.31.4
 */
public class ID3v1Tag <: ID3v1 {

    public static let TAG_LENGTH: Int32 = 128

    private static let VERSION_0: String = "0"
    private static let VERSION_1: String = "1"
    private static let TAG: String = "TAG"
    private static let TITLE_OFFSET: Int32 = 3
    private static let TITLE_LENGTH: Int32 = 30
    private static let ARTIST_OFFSET: Int32 = 33
    private static let ARTIST_LENGTH: Int32 = 30
    private static let ALBUM_OFFSET: Int32 = 63
    private static let ALBUM_LENGTH: Int32 = 30
    private static let YEAR_OFFSET: Int32 = 93
    private static let YEAR_LENGTH: Int32 = 4
    private static let COMMENT_OFFSET: Int32 = 97
    private static let COMMENT_LENGTH_V1_0: Int32 = 30
    private static let COMMENT_LENGTH_V1_1: Int32 = 28
    private static let TRACK_MARKER_OFFSET: Int32 = 125
    private static let TRACK_OFFSET: Int32 = 126
    private static let GENRE_OFFSET: Int32 = 127
    
    private var track: Option<String> = Option<String>.None
    private var artist: Option<String> = Option<String>.None
    private var title: Option<String> = Option<String>.None
    private var album: Option<String> = Option<String>.None
    private var year: Option<String> = Option<String>.None
    private var genre: Option<Int64> = Option<Int64>.Some(-1)
    private var comment: Option<String> = Option<String>.None

    /**
     * The Function is init constructor
     *
     * @since 0.31.4
     */
    public init (){}

    /**
     * The Function is init constructor
     *
     * @param bytes of Array<Byte>
     * @since 0.31.4
     */
    public init (bytes: Array<Byte>){
        unpackTag(bytes)
    }

    private func unpackTag (bytes: Array<Byte>): Unit {
        sanityCheckTag(bytes)
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, TITLE_OFFSET, TITLE_LENGTH)){
            case Some(x) => title = BufferTools.trimStringRight(x)
            case None => throw BaseException("title None Exception")
        }
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, ARTIST_OFFSET, ARTIST_LENGTH)){
            case Some(x) => artist = BufferTools.trimStringRight(x)
            case None => throw BaseException("artist None Exception")
        }
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, ALBUM_OFFSET, ALBUM_LENGTH)){
            case Some(x) => album = BufferTools.trimStringRight(x)
            case None => throw BaseException("album None Exception")
        }
        match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, YEAR_OFFSET, YEAR_LENGTH)){
            case Some(x) => year = BufferTools.trimStringRight(x)
            case None => throw BaseException("year None Exception")
        }
        genre = Int64(bytes[Int64(GENRE_OFFSET)]) & 255;
        if (genre == 255) {
            genre = -1
        }

        if (bytes[Int64(TRACK_MARKER_OFFSET)] != 0) {
            match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, COMMENT_OFFSET, COMMENT_LENGTH_V1_0)){
                case Some(x) => comment = BufferTools.trimStringRight(x)
                case None => throw BaseException("comment None Exception")
            }
            track = ""
        } else {
            match (BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, COMMENT_OFFSET, COMMENT_LENGTH_V1_1)){
                case Some(x) =>
                    comment = BufferTools.trimStringRight(x)
                    var trackInt: UInt8 = bytes[Int64(TRACK_OFFSET)]
                    if (trackInt == 0) {
                        track = ""
                    } else {
                        track = trackInt.toString()
                    }
                case None => throw BaseException("comment None Exception")
            }
        }
    }

    private func sanityCheckTag (bytes: Array<Byte>): Unit {
        if (bytes.size != Int64(TAG_LENGTH)){
            throw NoSuchTagException("Buffer length wrong")
        }
        match(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, 0, Int32(TAG.size))){
            case Some(x) =>
                if (!TAG.equals(x)){
                    throw NoSuchTagException("sanityCheckTag fail")
                    }
            case None => ()
        }
    }

    /**
     * The Function is toBytes, Convert to byte stream data.
     *
     * @return Type of Array<Byte>
     * @since 0.31.4
     */
    public func toBytes (): Array<Int8> {
        var bytes:Array<Byte> = Array<Byte>(Int64(TAG_LENGTH), {i => 0})
        packTag(bytes)
        return BufferTools.transUInt8ArrayToInt8(bytes)
    }

    /**
     * The Function is toBytes
     *
     * @param bytes of Array<Byte>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func toBytes (bytes: Array<Byte>): Unit {
        packTag(bytes)
    }

    /**
     * The Function is packTag, Package label data
     *
     * @param bytes of Array<Byte>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    @overflowWrapping
    public func packTag (bytes: Array<Byte>): Unit {
        try {
            BufferTools.stringIntoByteBuffer(TAG, 0, 3, bytes, 0)
        } catch (e: Exception){
            throw NoSuchTagException("TAG pack fail")
        }
        packField(bytes, title, TITLE_LENGTH, TITLE_OFFSET);
        packField(bytes, artist, ARTIST_LENGTH, ARTIST_OFFSET);
        packField(bytes, album, ALBUM_LENGTH, ALBUM_OFFSET);
        packField(bytes, year, YEAR_LENGTH, YEAR_OFFSET);
        match (genre){
            case Some(x) =>
                if (x < 128) {
                    bytes[Int64(GENRE_OFFSET)] = UInt8(x)
                } else {
                    bytes[Int64(GENRE_OFFSET)] = UInt8(x - 256)
                }
            case None => ()
        }
        match (track){
            case Some(x) =>
                   packField(bytes, comment, COMMENT_LENGTH_V1_1, COMMENT_OFFSET)
                   var trackTemp: String = numericsOnly(x)
                   if (trackTemp.size > 0) {
                       var trackInt: Int64 = Int64.parse(trackTemp)
                       if (trackInt < 128) {
                           bytes[Int64(TRACK_OFFSET)] = UInt8(trackInt)
                       } else {
                           bytes[Int64(TRACK_OFFSET)] = UInt8(trackInt - 256)
                       }
                   }
            case None =>
                packField(bytes, comment, COMMENT_LENGTH_V1_0, COMMENT_OFFSET)
        }
    }

    private func packField (bytes: Array<Byte>, value: Option<String>, maxLength: Int32, offset: Int32): Unit {
        match(value){
            case Some(x) => BufferTools.stringIntoByteBuffer(x, 0, min(x.size, Int64(maxLength)), bytes, Int64(offset))
            case None => ()
        }
    }

    private func numericsOnly (s: String): String {
        var stringBuffer:StringBuilder = StringBuilder()
        for (index in 0..s.size) {
            var ch: Char = s.charAt(index)
            if (ch >= '0' && ch <= '9') {
                stringBuffer.append(ch)
            } else {
                break
            }
        }
        return stringBuffer.toString()
    }

    /**
     * The Function is getVersion
     *
     * @return Type of String
     * @since 0.31.4
     */
    public func getVersion (): String {
        if (track == "") {
            return VERSION_0
        } else {
            return VERSION_1
        }
    }

    /**
     * The Function is getTrack
     *
     * @return Type of Option<String>
     * @since 0.31.4
     */
    public func getTrack (): Option<String> {
        return track
    }

    /**
     * The Function is setTrack
     *
     * @param track of Option<String>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setTrack (track: Option<String>): Unit {
        this.track = track;
    }

    /**
     * The Function is getArtist
     *
     * @return Type of Option<String>
     * @since 0.31.4
     */
    public func getArtist (): Option<String> {
        return artist
    }

    /**
     * The Function is setArtist
     *
     * @param artist of Option<String>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setArtist (artist: Option<String>): Unit {
        this.artist = artist
    }

    /**
     * The Function is getTitle
     *
     * @return Type of Option<String>
     * @since 0.31.4
     */
    public func getTitle (): Option<String> {
        return title;
    }

    /**
     * The Function is setTitle
     *
     * @param title of Option<String>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setTitle (title: Option<String>): Unit {
        this.title = title;
    }

    /**
     * The Function is getAlbum
     *
     * @return Type of Option<String>
     * @since 0.31.4
     */
    public func getAlbum (): Option<String> {
        return album;
    }

    /**
     * The Function is setAlbum
     *
     * @param album of Option<String>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setAlbum (album: Option<String>): Unit {
        this.album = album;
    }

    /**
     * The Function is getYear
     *
     * @return Type of Option<String>
     * @since 0.31.4
     */
    public func getYear (): Option<String> {
        return year
    }

    /**
     * The Function is setYear
     *
     * @param year of Option<String>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setYear (year: Option<String>): Unit {
        this.year = year
    }

    /**
     * The Function is getGenre
     *
     * @return Type of Option<Int64>
     * @since 0.31.4
     */
    public func getGenre (): Option<Int64> {
        return genre
    }

    /**
     * The Function is setGenre
     *
     * @param genre of Option<Int64>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setGenre (genre: Option<Int64>): Unit {
        this.genre = genre
    }

    /**
     * The Function is getGenreDescription
     *
     * @return Type of String
     * @since 0.31.4
     */
    public func getGenreDescription (): String {
        try {
            return ID3v1Genres.GENRES[this.genre.getOrThrow()]
        } catch (e: Exception) {
            return "Unknown"
        }
    }

    /**
     * The Function is getComment
     *
     * @return Type of Option<String>
     * @since 0.31.4
     */
    public func getComment (): Option<String> {
        return comment
    }
    /**
     * The Function is setComment
     *
     * @param comment of Option<String>
     *
     * @return Type of Unit
     * @since 0.31.4
     */
    public func setComment (comment: Option<String>): Unit {
        this.comment = comment
    }

}


