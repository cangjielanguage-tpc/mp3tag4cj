// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var frameData: ID3v2TextFrameData = ID3v2TextFrameData(true)
    var text: EncodedText = EncodedText("我是谁")
    frameData.setText(text)
    var res: String = frameData.getText().getOrThrow().toString().getOrThrow()
    println("res ===> ${res}")
    if (res != "我是谁") {
        return 1
    }
    0
}
