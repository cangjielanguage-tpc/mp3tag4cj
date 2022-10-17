package mp3agic

from okio import okio.*
from okio import nio.ByteBuffer

public class ByteBufferUtils {
    private init() {}

    public static func extractNullTerminatedString(bb: ByteBuffer): String {
        var start: Int64 = bb.position()
        var buffer: Array<UInt8> = Array<UInt8>(bb.remaining(), {i => 0})
        bb.get(buffer)
        var s: String = String.fromUtf8(buffer)
        var nullPos: Option<Int64> = s.indexOf(Char(0))
        s = s.substring(0, nullPos.getOrDefault({ => -1}))
        bb.position(start + s.size + 1)
        return s
    }
}
