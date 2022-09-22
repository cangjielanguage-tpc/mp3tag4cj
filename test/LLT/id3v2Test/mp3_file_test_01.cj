// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var mp3File: Mp3File = Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23tagswithalbumimage-utf16le.mp3")
    var startOffset:Int32 = mp3File.getStartOffset()
    var xingOffset:Int32 = mp3File.getXingOffset()
    var endOffset:Int32 = mp3File.getEndOffset()
    var frameCount:Int32 = mp3File.getFrameCount()
    var bitrate:Int32 = mp3File.getBitrate()
    var xingBitrate:Int32 = mp3File.getXingBitrate()
    var bitrates: Map<Int32, MutableInteger> = mp3File.getBitrates()
    var channelMode: String = mp3File.getChannelMode()
    var emphasis: String = mp3File.getEmphasis()
    var layer: String = mp3File.getLayer()
    var lengthInMilliseconds: Int64 = mp3File.getLengthInMilliseconds()
    var lengthInSeconds: Int64 = mp3File.getLengthInSeconds()
    var modeExtension: String = mp3File.getModeExtension()
    var sampleRate: Int32 = mp3File.getSampleRate()
    var version: String = mp3File.getVersion()
    var copyright: Bool = mp3File.isCopyright()
    var original: Bool = mp3File.isOriginal()
    var vbr: Bool = mp3File.isVbr()
    if (startOffset != 3564){
        return 1
    }
    if (xingOffset != 3147){
        return 1
    }
    if (endOffset != 6015){
        return 1
    }
    if (frameCount != 6){
        return 1
    }
    if (bitrate != 125){
        return 1
    }
    if (xingBitrate != 128){
        return 1
    }
    if (channelMode != "Joint stereo"){
        return 1
    }
    if (emphasis != "None"){
        return 1
    }
    if (layer != "III"){
        return 1
    }
    if (lengthInMilliseconds != 156){
        return 1
    }
    if (lengthInSeconds != 0){
        return 1
    }
    if (modeExtension != "None"){
        return 1
    }
    if (sampleRate != 44100){
        return 1
    }
    if (version != "1.0"){
        return 1
    }
    if (copyright != false){
        return 1
    }
    if (original != true){
        return 1
    }
    if (vbr != true){
        return 1
    }
    if (bitrates.size != 5){
        return 1
    }
    if (bitrates.get(224).getOrThrow().getValue() != 1){
        return 1
    }
    if (bitrates.get(112).getOrThrow().getValue() != 1){
        return 1
    }
    if (bitrates.get(96).getOrThrow().getValue() != 2){
        return 1
    }
    if (bitrates.get(192).getOrThrow().getValue() != 1){
        return 1
    }
    if (bitrates.get(32).getOrThrow().getValue() != 1){
        return 1
    }
    0
}





