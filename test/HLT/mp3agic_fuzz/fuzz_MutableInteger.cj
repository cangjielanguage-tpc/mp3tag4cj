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
    let mutableInteger: MutableInteger = MutableInteger(2147483646)
    println(int32)
    mutableInteger.setValue(int32)
}

func unboundTest():Unit{
    var case_name=CString("Fuzz_mutableInteger.setValue")
    unsafe{
        DT_FUZZ_Int32(0,100000,case_name,0,call_fuzz)
        case_name.free()
    }
}

main(){
    unboundTest()
    return
}



