// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v23tagwithchapters.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import os.posix.*


func call_fuzz(int32:Int32){
    var mp3File: Mp3File = Mp3File("v23tagwithchapters.mp3")
    var id3V22Tag: ID3v2 = mp3File.getId3v2Tag().getOrThrow()
    var chapters: ArrayList<ID3v2ChapterFrameData> = id3V22Tag.getChapters().getOrThrow()
    var id3v2ChapterFrameData: ID3v2ChapterFrameData = chapters[0]
    println(int32)
    id3v2ChapterFrameData.setEndTime(int32)
}

func unboundTest():Unit{
    var case_name=CString("Fuzz_id3v2ChapterFrameData.setEndTime")
    unsafe{
        DT_FUZZ_Int32(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}



