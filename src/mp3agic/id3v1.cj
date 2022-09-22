/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Interface type of the label.
 */
package mp3agic

/**
 * The interface is ID3v1
 * @since 0.31.4
 */
public interface ID3v1 {
    /* 
     * The Function is getVersion, Get subversion
     * 
     * @return Type of String
     * @since 0.31.4
     */
    func getVersion(): String

    /* 
     * The Function is getTrack, Get member track
     * 
     * @return Type of Option<String>
     * @since 0.31.4
     */
    func getTrack(): Option<String>

    /* 
     * The Function is setTrack, Set member track
     * 
     * @param track of Option<String>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    func setTrack(track: Option<String>): Unit

    /* 
     * The Function is getArtist, Get author
     * 
     * @return Type of Option<String>
     * @since 0.31.4
     */
    func getArtist(): Option<String>

    /* 
     * The Function is setArtist, Set author
     * 
     * @param artist of Option<String>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    func setArtist(artist: Option<String>): Unit

    /* 
     * The Function is getTitle, Get title
     * 
     * @return Type of Option<String>
     * @since 0.31.4
     */
    func getTitle(): Option<String>

    /* 
     * The Function is setTitle, Set title
     * 
     * @param title of Option<String>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    func setTitle(title: Option<String>): Unit

    /* 
     * The Function is getAlbum
     * 
     * @return Type of Option<String>
     * @since 0.31.4
     */
    func getAlbum(): Option<String>

    /* 
     * The Function is setAlbum
     * 
     * @param album of Option<String>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    func setAlbum(album: Option<String>): Unit

    /* 
     * The Function is getYear
     * 
     * @return Type of Option<String>
     * @since 0.31.4
     */
    func getYear(): Option<String>

    /* 
     * The Function is setYear
     * 
     * @param year of Option<String>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    func setYear(year: Option<String>): Unit

    /* 
     * The Function is getGenre
     * 
     * @return Type of Option<Int64>
     * @since 0.31.4
     */
    func getGenre(): Option<Int64>

    /* 
     * The Function is setGenre
     * 
     * @param genre of Option<Int64>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    func setGenre(genre: Option<Int64>): Unit

    /* 
     * The Function is getGenreDescription
     * 
     * @return Type of String
     * @since 0.31.4
     */
    func getGenreDescription(): String

    /* 
     * The Function is getComment
     * 
     * @return Type of Option<String>
     * @since 0.31.4
     */
    func getComment(): Option<String>

    /* 
     * The Function is setComment
     * 
     * @param comment of Option<String>
     * 
     * @return Type of Unit
     * @since 0.31.4
     */
    func setComment(comment: Option<String>): Unit

    /* 
     * The Function is toBytes, Convert to byte stream data
     * 
     * @return Type of Array<Byte>
     * @since 0.31.4
     */
    func toBytes(): Array<Int8>
}
