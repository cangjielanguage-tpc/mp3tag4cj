// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mpeg: MpegFrame = MpegFrame()
    mpeg.setVersion(0)
    var version: String = mpeg.getVersion()
    if (version != "2.5") {
        return 1
    }
    mpeg.setVersion(2)
    version = mpeg.getVersion()
    if (version != "2.0") {
        return 1
    }
    mpeg.setLayer(2)
    var layer: String = mpeg.getLayer()
    if (layer != "II") {
        return 1
    }
    mpeg.setLayer(1)
    layer = mpeg.getLayer()
    if (layer != "III") {
        return 1
    }
    mpeg.setVersion(3)
    mpeg.setLayer(3)
    mpeg.setBitRate(14)
    var bit = mpeg.getBitrate()
    if (bit != 448) {
        return 1
    }
    mpeg.setLayer(2)
    mpeg.setBitRate(14)
    bit = mpeg.getBitrate()
    if (bit != 384) {
        return 1
    }
    mpeg.setLayer(1)
    mpeg.setBitRate(14)
    bit = mpeg.getBitrate()
    if (bit != 320) {
        return 1
    }
    mpeg.setVersion(2)
    mpeg.setLayer(3)
    mpeg.setBitRate(14)
    var bit2 = mpeg.getBitrate()
    if (bit2 != 256) {
        return 1
    }
    mpeg.setLayer(2)
    mpeg.setBitRate(14)
    bit2 = mpeg.getBitrate()
    if (bit2 != 160) {
        return 1
    }

    mpeg.setVersion(2)
    mpeg.setSampleRate(2)
    var sampleRate = mpeg.getSampleRate()
    if (sampleRate != 16000) {
        println("3")
        return 1
    }
    mpeg.setVersion(0)
    mpeg.setSampleRate(2)
    sampleRate = mpeg.getSampleRate()
    if (sampleRate != 8000) {
        println("2")
        return 1
    }
    mpeg.setLayer(2)
    mpeg.setChannelMode(3)
    mpeg.setChannelMode(1)
    mpeg.setModeExtension(3)
    var modeExt = mpeg.getModeExtension()
    if (modeExt != "Bands 16-31") {
        return 1
    }
    0
}
