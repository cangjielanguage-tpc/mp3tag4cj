// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from okio import okio.*
from okio import nio.ByteBuffer

main() {
    var bytes: Array<Int8> = [99, 104, 49, 0, 0, 0, 0, 0, 0, 0, 19, -120, -1, -1, -1, -1, -1, -1, -1, -1, 84, 73, 84,
    50, 0, 0, 0, 6, 0, 0, 0, 115, 116, 97, 114, 116]
    var bb: ByteBuffer = ByteBuffer.wrap(BufferTools.transInt8ArrayToUInt8(bytes))
    var id: String = ByteBufferUtils.extractNullTerminatedString(bb)
    println(id)
    if (id != "ch1") {
        return 1
    }
    0
}
