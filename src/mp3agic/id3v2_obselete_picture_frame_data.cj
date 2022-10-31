/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * PIC Type related data
 */
package mp3agic

from std import io.*
from std import collection.*

/**
 * The class is ID3v2ObseletePictureFrameData inherited from ID3v2PictureFrameData
 * @since 0.33.3
 */
public class ID3v2ObseletePictureFrameData <: ID3v2PictureFrameData {
    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @since 0.33.3
     */
    public init(unsynchronisation: Bool) {
        super(unsynchronisation)
    }

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @param mimeType of Option<String> Mime type and subtype the image.For example: image/png, image/jpeg.
     * @param pictureType of Int8 Image usage type
     * Picture type:  $00  Other
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
     * @param description of Option<EncodedText> Short description of the picture
     * @param imageData of Option<Array<Int8>> Byte data of picture
     * @since 0.33.3
     */
    public init(
        unsynchronisation: Bool,
        mimeType: Option<String>,
        pictureType: Int8,
        description: Option<EncodedText>,
        imageData: Option<Array<Int8>>
    ) {
        super(unsynchronisation, mimeType, pictureType, description, imageData)
    }

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool
     * @param bytes of Array<Int8>
     * @since 0.33.3
     */
    public init(unsynchronisation: Bool, bytes: Array<Int8>) {
        super(unsynchronisation)
        super.initFunc(bytes)
    }

    protected override func unpackFrameData(bytes: Array<Int8>): Unit {
        var filetype: String
        try {
            filetype = BufferTools.byteBufferToString(bytes, 1, 3)
        } catch (e: Exception) {
            filetype = "unknown"
        }
        mimeType = Option<String>.Some("image/${filetype.toAsciiLower()}")
        pictureType = bytes[4]
        var marker: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, 5, Int32(bytes[0]))
        if (marker >= 0) {
            description = Option<EncodedText>.Some(
                EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 5, Int64(marker) - 5)))
            marker += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = Option<EncodedText>.Some(EncodedText(bytes[0], ""))
            marker = 1
        }
        imageData = BufferTools.copyBuffer(bytes, Int64(marker), bytes.size - Int64(marker))
    }
}
