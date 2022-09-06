// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

main() {
	var original: String = "1234567890QWERTYUIOP";
	var buffer: Array<Byte> = BufferTools.stringToByteBuffer(original, 2, (original.size - 5))
	var converted: String = BufferTools.byteBufferToString(buffer, 0, Int32(buffer.size))
    if (converted != "34567890QWERTYU"){
        return 1
    }
    0
}
