/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */
package mp3tag4cj.mp3tag4cj

public class ByteBufferUtils {
    private init() {}

    public static func extractNullTerminatedString(bb: ByteBuffer): String {
        var start: Int64 = bb.position()
        var buffer: Array<UInt8> = Array<UInt8>(bb.remaining(), {_ => 0})
        bb.get(buffer)
        var s: String
        unsafe { s = String.fromUtf8Unchecked(buffer) }
        var nullPos: Option<Int64> = s.indexOf(Rune(0).toString())
        s = s[..nullPos.getOrDefault({ => -1})]
        bb.position(start + s.size + 1)
        return s
    }
}
