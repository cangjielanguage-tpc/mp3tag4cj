// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v24tagswithalbumimage.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import os.posix.*


func call_fuzz(string:String){
    var mp3File: Mp3File = Mp3File("../../HLT/v24tagswithalbumimage.mp3")
    var id3V2Tag: AbstractID3v2Tag = ((mp3File.getId3v2Tag().getOrThrow()) as AbstractID3v2Tag).getOrThrow()
    println(string)
    id3V2Tag.clearFrameSet(string)
}

func unboundTest():Unit{
    var case_name=CString("Fuzz_abstractID3v2Tag.clearFrameSet")
    unsafe{
        DT_FUZZ_Int64(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}
