// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var frameData: ID3v2WWWFrameData = ID3v2WWWFrameData(false)
    frameData.setUrl(Option<String>.Some("My URL"))
    var url: Option<String> = frameData.getUrl()
    if (url != "My URL"){
        return 1
    }
    0
}




