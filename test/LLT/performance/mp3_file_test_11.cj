// EXEC: cjc -O2 %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*
from std import time.*

main() {
    var stringToCopy: String = "TAG"
    var charSet: Charset = match (Charsets.forName("ISO-8859-1")) {
        case Some(x) => x
        case None => throw BaseException("Character set not found")
    }

    var srcBytes: Array<UInt8> = charSet.newEncoder().encode(stringToCopy)
}


