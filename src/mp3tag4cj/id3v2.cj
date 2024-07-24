/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * ID3v2 of the label
 */
package mp3tag4cj.mp3tag4cj

public interface ID3v2 <: ID3v1 {
    func getPadding(): Bool

    func setPadding(padding: Bool): Unit

    func hasFooter(): Bool

    func setFooter(footer: Bool): Unit

    func hasUnsynchronisation(): Bool

    func setUnsynchronisation(unsynchronisation: Bool): Unit

    func getBPM(): Option<Int32>

    func setBPM(bpm: Int32): Unit

    func getGrouping(): Option<String>

    func setGrouping(grouping: Option<String>): Unit

    func getKey(): Option<String>

    func setKey(key: Option<String>): Unit

    func getDate(): Option<String>

    func setDate(date: Option<String>): Unit

    func getComposer(): Option<String>

    func setComposer(composer: Option<String>): Unit

    func getPublisher(): Option<String>

    func setPublisher(publisher: Option<String>): Unit

    func getOriginalArtist(): Option<String>

    func setOriginalArtist(originalArtist: Option<String>): Unit

    func getAlbumArtist(): Option<String>

    func setAlbumArtist(albumArtist: Option<String>): Unit

    func getCopyright(): Option<String>

    func setCopyright(copyright: Option<String>): Unit

    func getPartOfSet(): Option<String>

    func setPartOfSet(partOfSet: Option<String>): Unit

    func isCompilation(): Bool

    func setCompilation(compilation: Bool): Unit

    func getEncoder(): Option<String>

    func setEncoder(encoder: Option<String>): Unit

    func setGenreDescription(text: Option<String>): Unit

    func getDataLength(): Int32

    func getLength(): Int32

    func getObseleteFormat(): Bool

    func getFrameSets(): HashMap<String, ID3v2FrameSet>

    func getItunesComment(): Option<String>

    func setItunesComment(itunesComment: Option<String>): Unit

    func getLyrics(): Option<String>

    func setLyrics(lyrics: Option<String>): Unit

    func getArtistUrl(): Option<String>

    func setArtistUrl(url: Option<String>): Unit

    func getCommercialUrl(): Option<String>

    func setCommercialUrl(url: Option<String>): Unit

    func getCopyrightUrl(): Option<String>

    func setCopyrightUrl(url: Option<String>): Unit

    func getAudiofileUrl(): Option<String>

    func setAudiofileUrl(url: Option<String>): Unit

    func getAudioSourceUrl(): Option<String>

    func setAudioSourceUrl(url: Option<String>): Unit

    func getRadiostationUrl(): Option<String>

    func setRadiostationUrl(url: Option<String>): Unit

    func getPaymentUrl(): Option<String>

    func setPaymentUrl(url: Option<String>): Unit

    func getPublisherUrl(): Option<String>

    func setPublisherUrl(url: Option<String>): Unit

    func getUrl(): Option<String>

    func setUrl(url: Option<String>): Unit

    func clearFrameSet(id: String): Unit

    func getChapters(): Option<ArrayList<ID3v2ChapterFrameData>>

    func setChapters(chapters: Option<ArrayList<ID3v2ChapterFrameData>>): Unit

    func getChapterTOC(): Option<ArrayList<ID3v2ChapterTOCFrameData>>

    func setChapterTOC(toc: Option<ArrayList<ID3v2ChapterTOCFrameData>>): Unit

    func getWmpRating(): Int32

    func setWmpRating(rating: Int32): Unit

    func getAlbumImage(): Option<Array<Int8>>

    func setAlbumImage(albumImage: Option<Array<Int8>>, mimeType: Option<String>): Unit

    func setAlbumImage(albumImage: Option<Array<Int8>>, mimeType: Option<String>, imageType: Int8, 
        imageDescription: Option<String>): Unit

    func getAlbumImageMimeType(): Option<String>

    func clearAlbumImage(): Unit
}

