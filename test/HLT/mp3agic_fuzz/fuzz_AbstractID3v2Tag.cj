// 3rd_party_lib:mp3agic/build/mp3agic
// 3rd_party_lib:mp3agic/ci_lib/charset
// 3rd_party_lib:mp3agic/ci_lib/okio
// 3rd_party_lib:mp3agic/ci_lib/cryptocj
// data_file:./v1tag.mp3
from std import collection.*
from std import unittest.*
from mp3agic import mp3agic.*
from std import io.*
from std import os.posix.*


func call_fuzz(int32:Int32){
    var str = "ID3 some track"
    var sb = BufferTools.stringToByteBuffer(str, 0, str.size)
    var sb2 = BufferTools.transUInt8ArrayToInt8(sb)
    var tag = ID3v22Tag(sb2, false)
    println(int32)
    tag3.setBPM(int32)
}

func unboundTest():Unit{
    var case_name=CString("Fuzz_tag3.setBPM")
    unsafe{
        DT_FUZZ_Int32(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}



