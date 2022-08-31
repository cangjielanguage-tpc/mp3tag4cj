package mp3agic
from std import unittest.*
from std import unittest.testmacro.*
from mp3agic import mp3agic.*

@Test
public class MutableIntegerTest {

    @TestCase
    public func incrementTest (): Unit {
        var ints = MutableInteger(5)
        ints.increment()
        if (ints.getValue() != 6) {
            return 1
        }
    }

    @TestCase
    public func getValueTest (): Unit {
        var ints = MutableInteger(5)
        if (ints.getValue() != 5) {
            return 1
        }
    }

    @TestCase
    public func setValueTest (): Unit {
        var ints = MutableInteger(5)
        ints.setValue(7)
        if (ints.getValue() != 7) {
            return 1
        }
    }
}
