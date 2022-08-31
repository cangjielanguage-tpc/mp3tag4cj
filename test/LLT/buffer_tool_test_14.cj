// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*

main() {
    var source: String = "%1-%2 something %1-%3"
    var res1 = BufferTools.substitute(source, "%1", Option<String>.Some("ONE"))
    var res2 = BufferTools.substitute(source, "%2", Option<String>.Some("TWO"))
    var res3 = BufferTools.substitute(source, "%3", Option<String>.Some("THREE"))
    var res4 = BufferTools.substitute(source, "%X", Option<String>.Some("XXXXX"))
    var res5 = BufferTools.substitute(source, "", Option<String>.Some("WHATEVER"))
    var res6 = BufferTools.substitute(source, "%1", Option<String>.None)
    if (res1 != "ONE-%2 something ONE-%3"){
        return 1
    }
    if (res2 != "%1-TWO something %1-%3"){
        return 1
    }
    if (res3 != "%1-%2 something %1-THREE"){
        return 1
    }
    if (res4 != "%1-%2 something %1-%3"){
        return 1
    }
    if (res5 != "%1-%2 something %1-%3"){
        return 1
    }
    if (res6 != "-%2 something -%3"){
        return 1
    }
    0
}


