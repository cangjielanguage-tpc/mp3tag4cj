/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Audio data frame type
 */
package mp3agic

/**
 * The class is MpegFrame
 * @since 0.32.5
 */
public class MpegFrame {
    public static let MPEG_VERSION_1_0: String = "1.0"
    public static let MPEG_VERSION_2_0: String = "2.0"
    public static let MPEG_VERSION_2_5: String = "2.5"
    public static let MPEG_LAYER_1: String = "I"
    public static let MPEG_LAYER_2: String = "II"
    public static let MPEG_LAYER_3: String = "III"
    public static let MPEG_LAYERS: Array<Option<String>> = [
        Option<String>.None,
        Option<String>.Some(MPEG_LAYER_1),
        Option<String>.Some(MPEG_LAYER_2),
        Option<String>.Some(MPEG_LAYER_3)
    ]
    public static let CHANNEL_MODE_MONO: String = "Mono"
    public static let CHANNEL_MODE_DUAL_MONO: String = "Dual mono"
    public static let CHANNEL_MODE_JOINT_STEREO: String = "Joint stereo"
    public static let CHANNEL_MODE_STEREO: String = "Stereo"
    public static let MODE_EXTENSION_BANDS_4_31: String = "Bands 4-31"
    public static let MODE_EXTENSION_BANDS_8_31: String = "Bands 8-31"
    public static let MODE_EXTENSION_BANDS_12_31: String = "Bands 12-31"
    public static let MODE_EXTENSION_BANDS_16_31: String = "Bands 16-31"
    public static let MODE_EXTENSION_NONE: String = "None"
    public static let MODE_EXTENSION_INTENSITY_STEREO: String = "Intensity stereo"
    public static let MODE_EXTENSION_M_S_STEREO: String = "M/S stereo"
    public static let MODE_EXTENSION_INTENSITY_M_S_STEREO: String = "Intensity & M/S stereo"
    public static let MODE_EXTENSION_NA: String = "n/a"
    public static let EMPHASIS_NONE: String = "None"
    public static let EMPHASIS__50_15_MS: String = "50/15 ms"
    public static let EMPHASIS_CCITT_J_17: String = "CCITT J.17"

    private static let FRAME_DATA_LENGTH: Int32 = 4
    private static let FRAME_SYNC: Int32 = 2047
    private static let BITMASK_FRAME_SYNC: Int64 = 4292870144i64
    private static let BITMASK_VERSION: Int64 = 1572864i64
    private static let BITMASK_LAYER: Int64 = 393216i64
    private static let BITMASK_PROTECTION: Int64 = 65536i64
    private static let BITMASK_BITRATE: Int64 = 61440i64
    private static let BITMASK_SAMPLE_RATE: Int64 = 3072i64
    private static let BITMASK_PADDING: Int64 = 512i64
    private static let BITMASK_PRIVATE: Int64 = 256i64
    private static let BITMASK_CHANNEL_MODE: Int64 = 192i64
    private static let BITMASK_MODE_EXTENSION: Int64 = 48i64
    private static let BITMASK_COPYRIGHT: Int64 = 8i64
    private static let BITMASK_ORIGINAL: Int64 = 4i64
    private static let BITMASK_EMPHASIS: Int64 = 3i64

    public var version: String = ""
    public var layer: Int32 = 0
    public var protection: Bool = false
    public var bitrate: Int32 = 0
    public var sampleRate: Int32 = 0
    public var padding: Bool = false
    public var privat: Bool = false
    public var channelMode: String = ""
    public var modeExtension: String = ""
    public var copyright: Bool = false
    public var original: Bool = false
    public var emphasis: String = ""

    /**
     * The Function is init constructor
     * 
     * @param frameData of Array<Int8>
     * @since 0.32.5
     */
    public init(frameData: Array<Int8>) {
        if (frameData.size < Int64(FRAME_DATA_LENGTH)) {
            throw InvalidDataException("Mpeg frame too short")
        }
        var frameHeader: Int64 = Int64(BufferTools.unpackInteger(frameData[0], frameData[1], frameData[2], frameData[3]))
        setFields(frameHeader)
    }

    /**
     * The Function is init constructor
     * 
     * @param frameData1 of Int8
     * @param frameData2 of Int8
     * @param frameData3 of Int8
     * @param frameData4 of Int8
     * @since 0.32.5
     */
    public init(frameData1: Int8, frameData2: Int8, frameData3: Int8, frameData4: Int8) {
        var frameHeader: Int64 = Int64(BufferTools.unpackInteger(frameData1, frameData2, frameData3, frameData4))
        setFields(frameHeader)
    }

    /**
     * The Function is init constructor
     * 
     * @since 0.32.5
     */
    public init() {}

    private func setFields(frameHeader: Int64): Unit {
        var frameSync: Int64 = Int64(extractField(frameHeader, BITMASK_FRAME_SYNC))
        if (frameSync != Int64(FRAME_SYNC)) {
            throw InvalidDataException("Frame sync missing")
        }
        setVersion(extractField(frameHeader, BITMASK_VERSION))
        setLayer(extractField(frameHeader, BITMASK_LAYER))
        setProtection(extractField(frameHeader, BITMASK_PROTECTION))
        setBitRate(extractField(frameHeader, BITMASK_BITRATE))
        setSampleRate(extractField(frameHeader, BITMASK_SAMPLE_RATE))
        setPadding(extractField(frameHeader, BITMASK_PADDING))
        setPrivate(extractField(frameHeader, BITMASK_PRIVATE))
        setChannelMode(extractField(frameHeader, BITMASK_CHANNEL_MODE))
        setModeExtension(extractField(frameHeader, BITMASK_MODE_EXTENSION))
        setCopyright(extractField(frameHeader, BITMASK_COPYRIGHT))
        setOriginal(extractField(frameHeader, BITMASK_ORIGINAL))
        setEmphasis(extractField(frameHeader, BITMASK_EMPHASIS))
    }

    protected func extractField(frameHeader: Int64, bitMask: Int64): Int32 {
        var shiftBy: Int64 = 0
        for (i in 0..32) {
            if (((bitMask >> i) & 1) != 0) {
                shiftBy = i
                break
            }
        }
        return Int32(((frameHeader >> shiftBy) & (bitMask >> shiftBy)))
    }

    /**
     * The Function is setVersion
     * 
     * @param version of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setVersion(version: Int32): Unit {
        match (version) {
            case 0 => this.version = MPEG_VERSION_2_5
            case 2 => this.version = MPEG_VERSION_2_0
            case 3 => this.version = MPEG_VERSION_1_0
            case _ => throw InvalidDataException("Invalid mpeg audio version in frame header")
        }
    }

    /**
     * The Function is setLayer
     * 
     * @param layer of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setLayer(layer: Int32): Unit {
        match (layer) {
            case 1 => this.layer = 3
            case 2 => this.layer = 2
            case 3 => this.layer = 1
            case _ => throw InvalidDataException("Invalid mpeg layer description in frame header")
        }
    }

    /**
     * The Function is setProtection
     * 
     * @param protectionBit of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setProtection(protectionBit: Int32): Unit {
        this.protection = (protectionBit == 1)
    }

    /**
     * The Function is setBitRate
     * 
     * @param bitrate of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setBitRate(bitrate: Int32): Unit {
        if (MPEG_VERSION_1_0.equals(this.version)) {
            if (this.layer == 1) {
                matchSetBitRateV1L1(bitrate)
                return
            } else if (layer == 2) {
                matchSetBitRateV1L2(bitrate)
                return
            } else if (layer == 3) {
                matchSetBitRateV1L3(bitrate)
                return
            }
        } else if (MPEG_VERSION_2_0.equals(version) || MPEG_VERSION_2_5.equals(version)) {
            if (layer == 1) {
                matchSetBitRateV2xL1(bitrate)
                return
            } else if (layer == 2 || layer == 3) {
                matchSetBitRateV2xL23(bitrate)
                return
            }
        }
        throw InvalidDataException("Invalid bitrate in frame header")
    }
    private func matchSetBitRateV1L1(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 32
                return
            case 2 =>
                this.bitrate = 64
                return
            case 3 =>
                this.bitrate = 96
                return
            case 4 =>
                this.bitrate = 128
                return
            case 5 =>
                this.bitrate = 160
                return
            case 6 =>
                this.bitrate = 192
                return
            case 7 =>
                this.bitrate = 224
                return
            case 8 =>
                this.bitrate = 256
                return
            case 9 =>
                this.bitrate = 288
                return
            case 10 =>
                this.bitrate = 320
                return
            case 11 =>
                this.bitrate = 352
                return
            case 12 =>
                this.bitrate = 384
                return
            case 13 =>
                this.bitrate = 416
                return
            case 14 =>
                this.bitrate = 448
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV1L2(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 32
                return
            case 2 =>
                this.bitrate = 48
                return
            case 3 =>
                this.bitrate = 56
                return
            case 4 =>
                this.bitrate = 64
                return
            case 5 =>
                this.bitrate = 80
                return
            case 6 =>
                this.bitrate = 96
                return
            case 7 =>
                this.bitrate = 112
                return
            case 8 =>
                this.bitrate = 128
                return
            case 9 =>
                this.bitrate = 160
                return
            case 10 =>
                this.bitrate = 192
                return
            case 11 =>
                this.bitrate = 224
                return
            case 12 =>
                this.bitrate = 256
                return
            case 13 =>
                this.bitrate = 320
                return
            case 14 =>
                this.bitrate = 384
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV1L3(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 32
                return
            case 2 =>
                this.bitrate = 40
                return
            case 3 =>
                this.bitrate = 48
                return
            case 4 =>
                this.bitrate = 56
                return
            case 5 =>
                this.bitrate = 64
                return
            case 6 =>
                this.bitrate = 80
                return
            case 7 =>
                this.bitrate = 96
                return
            case 8 =>
                this.bitrate = 112
                return
            case 9 =>
                this.bitrate = 128
                return
            case 10 =>
                this.bitrate = 160
                return
            case 11 =>
                this.bitrate = 192
                return
            case 12 =>
                this.bitrate = 224
                return
            case 13 =>
                this.bitrate = 256
                return
            case 14 =>
                this.bitrate = 320
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV2xL1(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 32
                return
            case 2 =>
                this.bitrate = 48
                return
            case 3 =>
                this.bitrate = 56
                return
            case 4 =>
                this.bitrate = 64
                return
            case 5 =>
                this.bitrate = 80
                return
            case 6 =>
                this.bitrate = 96
                return
            case 7 =>
                this.bitrate = 112
                return
            case 8 =>
                this.bitrate = 128
                return
            case 9 =>
                this.bitrate = 144
                return
            case 10 =>
                this.bitrate = 160
                return
            case 11 =>
                this.bitrate = 176
                return
            case 12 =>
                this.bitrate = 192
                return
            case 13 =>
                this.bitrate = 224
                return
            case 14 =>
                this.bitrate = 256
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    private func matchSetBitRateV2xL23(bitrate: Int32): Unit {
        match (bitrate) {
            case 1 =>
                this.bitrate = 8
                return
            case 2 =>
                this.bitrate = 16
                return
            case 3 =>
                this.bitrate = 24
                return
            case 4 =>
                this.bitrate = 32
                return
            case 5 =>
                this.bitrate = 40
                return
            case 6 =>
                this.bitrate = 48
                return
            case 7 =>
                this.bitrate = 56
                return
            case 8 =>
                this.bitrate = 64
                return
            case 9 =>
                this.bitrate = 80
                return
            case 10 =>
                this.bitrate = 96
                return
            case 11 =>
                this.bitrate = 112
                return
            case 12 =>
                this.bitrate = 128
                return
            case 13 =>
                this.bitrate = 144
                return
            case 14 =>
                this.bitrate = 160
                return
            case _ => throw InvalidDataException("Invalid bitrate in frame header")
        }
    }

    /**
     * The Function is setSampleRate
     * 
     * @param sampleRate of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setSampleRate(sampleRate: Int32): Unit {
        if (MPEG_VERSION_1_0.equals(version)) {
            match (sampleRate) {
                case 0 =>
                    this.sampleRate = 44100
                    return
                case 1 =>
                    this.sampleRate = 48000
                    return
                case 2 =>
                    this.sampleRate = 32000
                    return
                case _ => throw InvalidDataException("Invalid sample rate in frame header")
            }
        } else if (MPEG_VERSION_2_0.equals(version)) {
            match (sampleRate) {
                case 0 =>
                    this.sampleRate = 22050
                    return
                case 1 =>
                    this.sampleRate = 24000
                    return
                case 2 =>
                    this.sampleRate = 16000
                    return
                case _ => throw InvalidDataException("Invalid sample rate in frame header")
            }
        } else if (MPEG_VERSION_2_5.equals(version)) {
            match (sampleRate) {
                case 0 =>
                    this.sampleRate = 11025
                    return
                case 1 =>
                    this.sampleRate = 12000
                    return
                case 2 =>
                    this.sampleRate = 8000
                    return
                case _ => throw InvalidDataException("Invalid sample rate in frame header")
            }
        }
        throw InvalidDataException("Invalid sample rate in frame header")
    }

    /**
     * The Function is setPadding
     * 
     * @param paddingBit of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setPadding(paddingBit: Int32): Unit {
        this.padding = (paddingBit == 1)
    }

    /**
     * The Function is setPrivate
     * 
     * @param privateBit of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setPrivate(privateBit: Int32): Unit {
        this.privat = (privateBit == 1)
    }

    /**
     * The Function is setChannelMode
     * 
     * @param channelMode of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setChannelMode(channelMode: Int32): Unit {
        match (channelMode) {
            case 0 => this.channelMode = CHANNEL_MODE_STEREO
            case 1 => this.channelMode = CHANNEL_MODE_JOINT_STEREO
            case 2 => this.channelMode = CHANNEL_MODE_DUAL_MONO
            case 3 => this.channelMode = CHANNEL_MODE_MONO
            case _ => throw InvalidDataException("Invalid channel mode in frame header")
        }
    }

    /**
     * The Function is setModeExtension
     * 
     * @param modeExtension of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setModeExtension(modeExtension: Int32): Unit {
        if (!CHANNEL_MODE_JOINT_STEREO.equals(channelMode)) {
            this.modeExtension = MODE_EXTENSION_NA
        } else {
            if (layer == 1 || layer == 2) {
                match (modeExtension) {
                    case 0 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_4_31
                        return
                    case 1 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_8_31
                        return
                    case 2 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_12_31
                        return
                    case 3 =>
                        this.modeExtension = MODE_EXTENSION_BANDS_16_31
                        return
                    case _ => throw InvalidDataException("Invalid mode extension in frame header")
                }
            } else if (layer == 3) {
                match (modeExtension) {
                    case 0 =>
                        this.modeExtension = MODE_EXTENSION_NONE
                        return
                    case 1 =>
                        this.modeExtension = MODE_EXTENSION_INTENSITY_STEREO
                        return
                    case 2 =>
                        this.modeExtension = MODE_EXTENSION_M_S_STEREO
                        return
                    case 3 =>
                        this.modeExtension = MODE_EXTENSION_INTENSITY_M_S_STEREO
                        return
                    case _ => throw InvalidDataException("Invalid mode extension in frame header")
                }
            }
            throw InvalidDataException("Invalid mode extension in frame header")
        }
    }

    /**
     * The Function is setCopyright
     * 
     * @param copyrightBit of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setCopyright(copyrightBit: Int32): Unit {
        this.copyright = (copyrightBit == 1)
    }

    /**
     * The Function is setOriginal
     * 
     * @param originalBit of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setOriginal(originalBit: Int32): Unit {
        this.original = (originalBit == 1)
    }

    /**
     * The Function is setEmphasis
     * 
     * @param emphasis of Int32
     * 
     * @return Type of Unit
     * @since 0.32.5
     */
    public func setEmphasis(emphasis: Int32): Unit {
        match (emphasis) {
            case 0 => this.emphasis = EMPHASIS_NONE
            case 1 => this.emphasis = EMPHASIS__50_15_MS
            case 3 => this.emphasis = EMPHASIS_CCITT_J_17
            case _ => throw InvalidDataException("Invalid emphasis in frame header")
        }
    }

    /**
     * The Function is getBitrate
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public func getBitrate(): Int32 {
        return bitrate
    }

    /**
     * The Function is getChannelMode
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public func getChannelMode(): String {
        return channelMode
    }

    /**
     * The Function is isCopyright
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public func isCopyright(): Bool {
        return copyright
    }

    /**
     * The Function is getEmphasis
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public func getEmphasis(): String {
        return emphasis
    }

    /**
     * The Function is getLayer
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public func getLayer(): String {
        return MPEG_LAYERS[Int64(layer)].getOrDefault({ => "None"})
    }

    /**
     * The Function is getModeExtension
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public func getModeExtension(): String {
        return modeExtension
    }

    /**
     * The Function is isOriginal
     * 
     * @return Type of Bool
     * @since 0.32.5
     */
    public func isOriginal(): Bool {
        return original
    }

    /**
     * The Function is getSampleRate
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public func getSampleRate(): Int32 {
        return sampleRate
    }

    /**
     * The Function is getVersion
     * 
     * @return Type of String
     * @since 0.32.5
     */
    public func getVersion(): String {
        return version
    }

    /**
     * The Function is getLengthInBytes
     * 
     * @return Type of Int32
     * @since 0.32.5
     */
    public func getLengthInBytes(): Int32 {
        var length: Int64
        var pad: Int32
        if (padding) {
            pad = 1
        } else {
            pad = 0
        }
        if (layer == 1) {
            length = Int64(((48000 * bitrate) / sampleRate) + (pad * 4))
        } else {
            length = Int64(((144000 * bitrate) / sampleRate) + pad)
        }
        return Int32(length)
    }
}
