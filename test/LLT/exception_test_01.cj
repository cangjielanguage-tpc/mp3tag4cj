// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*

main() {
    var exc1 = BaseException()
    var exc2 = BaseException("baseExceptin")
    if (exc2.toString() != "Exception: baseExceptin"){
        return 1
    }
    var exc3 = NoSuchTagException()
    var exc4 = NoSuchTagException("NoSuchTagException")
    if (exc4.toString() != "Exception: NoSuchTagException"){
        return 1
    }
    var exc5 = NotSupportedException()
    var exc6 = NotSupportedException("NotSupportedException")
    if (exc6.toString() != "Exception: NotSupportedException"){
        return 1
    }
    var exc7 = UnsupportedTagException()
    var exc8 = UnsupportedTagException("UnsupportedTagException")
    if (exc8.toString() != "Exception: UnsupportedTagException"){
        return 1
    }
    var exc9 = InvalidDataException()
    var exc10 = InvalidDataException("InvalidDataException")
    if (exc10.toString() != "Exception: InvalidDataException"){
        return 1
    }
    0
}


