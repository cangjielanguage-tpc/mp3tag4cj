/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * APIC Type related data
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is ID3v2PictureFrameData inherited from AbstractID3v2FrameData
 * @since 0.33.3
 */
public open class ID3v2PictureFrameData <: AbstractID3v2FrameData & Equatable<ID3v2PictureFrameData> {
    protected var mimeType: Option<String> = Option<String>.None
    protected var pictureType: Int8 = 0
    protected var description: Option<EncodedText> = Option<EncodedText>.None
    protected var imageData: Option<Array<Int8>> = Option<Array<Int8>>.None

    /**
     * The Function is init constructor
     * 
     * @param unsynchronisation of Bool Whether the file byte data format is a synchronization identifier.
     * True and False correspond to different parsing methods.
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
        super(unsynchronisation)
        this.mimeType = mimeType
        this.pictureType = pictureType
        this.description = description
        this.imageData = imageData
    }

    /**
     * The Function is initFunc
     * 
     * @param bytes of Array<Int8>
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public func initFunc(bytes: Array<Int8>): Unit {
        synchroniseAndUnpackFrameData(bytes)
    }

    protected open func unpackFrameData(bytes: Array<Int8>): Unit {
        var marker: Int32 = BufferTools.indexOfTerminator(bytes, 1, 1);
        if (marker >= 0) {
            try {
                mimeType = Option<String>.Some(BufferTools.byteBufferToString(bytes, 1, marker - 1))
            } catch (e: Exception) {
                mimeType = Option<String>.Some("image/unknown")
            }
        } else {
            mimeType = Option<String>.Some("image/unknown")
        }
        pictureType = bytes[Int64(marker) + 1]
        marker += 2
        var marker2: Int32 = BufferTools.indexOfTerminatorForEncoding(bytes, marker, Int32(bytes[0]))
        if (marker2 >= 0) {
            description = Option<EncodedText>.Some(
                EncodedText(bytes[0], BufferTools.copyBuffer(bytes, Int64(marker), Int64(marker2 - marker))))
            marker2 += Int32(description.getOrThrow().getTerminator().size)
        } else {
            description = Option<EncodedText>.Some(EncodedText(bytes[0], ""))
            marker2 = marker
        }
        imageData = Option<Array<Int8>>.Some(BufferTools.copyBuffer(bytes, Int64(marker2), bytes.size - Int64(marker2)))
    }

    public open func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(Int64(getLength()), {_ => 0})
        if (description != Option<EncodedText>.None) {
            bytes[0] = description.getOrThrow().getTextEncoding()
        } else {
            bytes[0] = 0
        }
        var mimeTypeLength: Int64 = 0
        if (mimeType != Option<String>.None) {
            if (mimeType.getOrThrow().size > 0) {
                mimeTypeLength = mimeType.getOrThrow().toArray().size
                try {
                    BufferTools.stringIntoByteBuffer(mimeType.getOrThrow(), 0, mimeType.getOrThrow().size, bytes, 1)
                } catch (e: Exception) {}
            }
        }
        var marker: Int64 = mimeTypeLength + 1
        bytes[marker] = 0
        marker++
        bytes[marker] = pictureType
        marker++
        if (description != Option<EncodedText>.None) {
            if (description.getOrThrow().toBytes().size > 0) {
                var descriptionBytes: Array<Int8> = description.getOrThrow().toBytes(true, true)
                BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.size, bytes, marker)
                marker += descriptionBytes.size
            }else {
                marker++
                bytes[marker] = 0
            }
        } else {
            marker++
            bytes[marker] = 0
        }
        if (imageData != Option<Array<Int8>>.None) {
            if (imageData.getOrThrow().size > 0) {
                BufferTools.copyIntoByteBuffer(imageData.getOrThrow(), 0, imageData.getOrThrow().size, bytes, marker)
            }
        }
        return bytes
    }

    @OverflowWrapping
    public open func getLength(): Int32 {
        var length: Int32 = 3
        if (mimeType != Option<String>.None) {
            length += Int32(mimeType.getOrThrow().toArray().size)
        }
        if (description != Option<EncodedText>.None) {
            length += Int32(description.getOrThrow().toBytes(true, true).size)
        } else {
            length++
        }
        if (imageData != Option<Array<Int8>>.None) {
            length += Int32(imageData.getOrThrow().size)
        }
        return length
    }

    /**
     * The Function is getMimeType, Mime type and subtype the image.For example: image/png, image/jpeg.
     * 
     * @return Type of Option<String>
     * @since 0.33.3
     */
    public open func getMimeType(): Option<String> {
        return mimeType
    }

    /**
     * The Function is setMimeType,Set the string, which supports the 4 encoding of id3v2. It is recommended to be
     * Mime type and subtype the image. For example: image/png, image/jpeg.
     * 
     * @param mimeType of Option<String>
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public open func setMimeType(mimeType: Option<String>): Unit {
        this.mimeType = mimeType
    }

    /**
     * The Function is getPictureType, Obtain picture types and provide 21 specified picture types.
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
     * @return Type of Int8
     * @since 0.33.3
     */
    public open func getPictureType(): Int8 {
        return pictureType
    }

    /**
     * The Function is setPictureType, Set legal values. For meaningful image types, refer to the types in the get method.
     * 
     * @param pictureType of Int8
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public open func setPictureType(pictureType: Int8): Unit {
        this.pictureType = pictureType
    }

    /**
     * The Function is getDescription
     * 
     * @return Type of Option<EncodedText>
     * @since 0.33.3
     */
    public open func getDescription(): Option<EncodedText> {
        return description
    }

    /**
     * The Function is setDescription, Set the string, which supports the 4 encoding of id3v2.
     * 
     * @param description of Option<EncodedText>
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public open func setDescription(description: Option<EncodedText>): Unit {
        this.description = description
    }

    /**
     * The Function is getImageData, Get the byte data of the picture.
     * 
     * @return Type of Option<Array<Int8>>
     * @since 0.33.3
     */
    public open func getImageData(): Option<Array<Int8>> {
        return imageData
    }

    /**
     * The Function is setImageData, Set the byte data of the picture.
     * 
     * @param imageData of Option<Array<Int8>>
     * 
     * @return Type of Unit
     * @since 0.33.3
     */
    public open func setImageData(imageData: Option<Array<Int8>>): Unit {
        this.imageData = imageData
    }

    /**
     * The Function is hashCode
     * 
     * @return Type of Int64
     * @since 0.33.3
     */
    @OverflowWrapping
    public open func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (description == Option<EncodedText>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(description.getOrThrow().hashCode())
        }
        if (imageData == Option<Array<Int8>>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(imageData.getOrThrow().toString().hashCode())
        }
        if (mimeType == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(mimeType.getOrThrow().hashCode())
        }
        result = prime * result + Int32(pictureType)
        return Int64(result)
    }

    /**
     * The Function is ==
     * 
     * @param rhs of ID3v2CommentFrameData
     * 
     * @return Type of Bool
     * @since 0.33.3
     */
    public operator func ==(rhs: ID3v2PictureFrameData): Bool {
        return refEq(this, rhs)
    }

    /**
     * The Function is !=
     * 
     * @param rhs of ID3v2CommentFrameData
     * 
     * @return Type of Bool
     * @since 0.33.3
     */
    public operator func !=(rhs: ID3v2PictureFrameData): Bool {
        return !refEq(this, rhs)
    }
}

