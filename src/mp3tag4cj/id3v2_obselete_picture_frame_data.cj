/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * PIC Type related data
 */
package mp3tag4cj.mp3tag4cj

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
     * @param pictureType of Int8 Image usage type, @link ID3v2PictureFrameData
     * @param description of Option<EncodedText> Short description of the picture
     * @param imageData of Option<Array<Int8>> Byte data of picture
     * @since 0.33.3
     */
    public init(
        unsynchronisationOb: Bool,
        mimeTypeOb: Option<String>,
        pictureTypeOb: Int8,
        descriptionOb: Option<EncodedText>,
        imageDataOb: Option<Array<Int8>>
    ) {
        super(unsynchronisationOb, mimeTypeOb, pictureTypeOb, descriptionOb, imageDataOb)
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
