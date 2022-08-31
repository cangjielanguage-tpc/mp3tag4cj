// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from mp3agic import mp3agic.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var eight = MutableInteger(8)
    eight.setValue(5)
    if (eight.getValue() != 5) {
        return 1
    }
    eight.increment()
    if (eight.getValue() != 6) {
        return 1
    }
    var six = MutableInteger(6)
    if (eight.hashCode() != six.hashCode()){
        return 1
    }
    0
}
