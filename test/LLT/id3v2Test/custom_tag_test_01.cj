// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from mp3agic import mp3agic.*
from std import io.*
from std import collection.*
from charset import charset.*
from charset import charset.singlebyte.*
from charset import charset.encoding.*

main() {
    var exppt: Array<Int8> =  [-127, 65, 71, 84, 73, 84, 76, 69, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 48, 49, 50, 51, 52, 53, -127, 82, 84, 73, 127]
    var mp3file:Mp3File=Mp3File("../../../../test/LLT/id3v2Test/testv2File/v1andv23andcustomtags.mp3")
    mp3file.removeCustomTag()
    mp3file.save("../../../../test/LLT/id3v2Test/remove_v1andv23andcustomtags.mp3")
    var mp3file2:Mp3File=Mp3File("../../../../test/LLT/id3v2Test/remove_v1andv23andcustomtags.mp3")
    if (mp3file2.hasCustomTag()){
        return 1
    }
    mp3file2.setCustomTag(Option<Array<Int8>>.Some(exppt))
    mp3file2.save("../../../../test/LLT/id3v2Test/set_custom_tag_v1andv23andcustomtags.mp3")
    var mp3file3:Mp3File=Mp3File("../../../../test/LLT/id3v2Test/set_custom_tag_v1andv23andcustomtags.mp3")
    if (mp3file3.hasCustomTag()){
        if (mp3file3.getCustomTag().getOrThrow() != exppt){
            return 1
        }
    }
    0
}
