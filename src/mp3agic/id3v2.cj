/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * ID3v2 of the label
 */
package mp3agic

from std import collection.*

public interface ID3v2 <: ID3v1 {

    func getPadding (): Bool

    func hasFooter (): Bool

    func setFooter (footer: Bool): Unit

    func hasUnsynchronisation (): Bool

    func setUnsynchronisation (unsynchronisation: Bool): Unit

    func getBPM (): Option<Int32>

    func setBPM (bpm: Int32): Unit

    func getGrouping (): Option<String>

    func setGrouping (grouping: Option<String>): Unit

    func getKey (): Option<String>

    func setKey (key: Option<String>): Unit

    func getDate (): Option<String>

    func setDate (date: Option<String>): Unit

    func getComposer (): Option<String>

    func setComposer (composer: Option<String>): Unit

    func getPublisher (): Option<String>

    func setPublisher (publisher: Option<String>): Unit

    func getOriginalArtist (): Option<String>

    func setOriginalArtist (originalArtist: Option<String>): Unit

    func getAlbumArtist (): Option<String>

    func setAlbumArtist (albumArtist: Option<String>): Unit

    func getCopyright (): Option<String>

    func setCopyright (copyright: Option<String>): Unit

    func getPartOfSet (): Option<String>

    func setPartOfSet (partOfSet: Option<String>): Unit

    func isCompilation (): Bool

    func setCompilation (compilation: Bool): Unit

    func getEncoder (): Option<String>

    func setEncoder (encoder: Option<String>): Unit

    func setGenreDescription (text: Option<String>): Unit

    func getDataLength (): Int32

    func getLength (): Int32

    func getObseleteFormat (): Bool

    func getFrameSets (): HashMap<String, ID3v2FrameSet>

}


