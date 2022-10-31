package mp3agic

from std import io.*
from std import collection.*

public class ID3v2PopmFrameData <: AbstractID3v2FrameData & Equatable<ID3v2PopmFrameData> {
    protected static let WMP9_ADDRESS: Option<String> = "Windows Media Player 9 Series"
    protected var address: Option<String> = Option<String>.Some("")
    protected var rating: Int32 = -1
    private static let byteToRating: HashMap<Int8, Int32> = HashMap<Int8, Int32>(
        [(0, 0), (64, 2), (-1, 5), (1, 1), (-60, 4), (-128, 3)])
    private static let wmp9encodedRatings: Array<Int8> = [0, 1, 64, -128, -60, -1]

    public init(unsynchronisation: Bool, bytes: Array<Int8>) {
        super(unsynchronisation)
        synchroniseAndUnpackFrameData(bytes)
    }

    public init(unsynchronisation: Bool, rating: Int32) {
        super(unsynchronisation)
        this.address = WMP9_ADDRESS
        this.rating = rating
    }

    protected func unpackFrameData(bytes: Array<Int8>): Unit {
        try {
            address = BufferTools.byteBufferToString(bytes, Int32(0), Int32(bytes.size - 2))
        } catch (e: Exception) {
            address = ""
        }
        var ratingByte: Int8 = bytes[bytes.size - 1]
        rating = byteToRating.get(ratingByte).getOrDefault({ => -1})
    }

    public func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(address.getOrThrow().toUtf8Array())
        var newBytes: Array<Int8> = Array<Int8>(bytes.size + 2, {i => 0})
        for (index in 0..bytes.size) {
            newBytes[index] = bytes[index]
        }
        newBytes[newBytes.size - 2] = 0
        newBytes[newBytes.size - 1] = wmp9encodedRatings[Int64(rating)]
        return newBytes
    }

    public func getAddress(): Option<String> {
        return address
    }

    public func setAddress(address: Option<String>): Unit {
        this.address = address
    }

    public func getRating(): Int32 {
        return rating
    }

    public func setRating(rating: Int32): Unit {
        this.rating = rating
    }

    public func getLength(): Int32 {
        return Int32(address.getOrThrow().size + 2)
    }

    @overflowWrapping
    public override func hashCode(): Int64 {
        let prime: Int32 = 31
        var result: Int32 = Int32(super.hashCode())
        if (address == Option<String>.None) {
            result = prime * result + 0
        } else {
            result = prime * result + Int32(address.getOrThrow().hashCode())
        }
        result = prime * result + rating
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
    public operator func ==(rhs: ID3v2PopmFrameData): Bool {
        return match (rhs as ID3v2PopmFrameData) {
            case Some(x) => refEq(this, x)
            case None => false
        }
    }

    /**
     * The Function is !=
     * 
     * @param rhs of ID3v2CommentFrameData
     * 
     * @return Type of Bool
     * @since 0.33.3
     */
    public operator func !=(rhs: ID3v2PopmFrameData): Bool {
        return match (rhs as ID3v2PopmFrameData) {
            case Some(x) => !refEq(this, x)
            case None => false
        }
    }
}

