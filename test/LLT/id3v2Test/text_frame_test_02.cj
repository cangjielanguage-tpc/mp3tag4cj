// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var frameData: ID3v2TextFrameData = ID3v2TextFrameData(false, EncodedText(1, "\u{03B3}\u{03B5}\u{03B9}\u{03AC}"))
    var res = frameData.getText().getOrThrow().toString().getOrThrow()
    if (res != "γειά") {
        return 1
    }
    0
}
