// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*
from std import convert.*



let BYTE_FF: Int8 = -0x01
let BYTE_FB: Int8 = -0x05

main() {
   var res1 = BufferTools.sizeUnsynchronisationWouldAdd(Array<Int8>())
    if (res1 != 0){
        return 1
    }
   var array2:Array<Int8> = [BYTE_FF, 1, BYTE_FB]
   var res2 = BufferTools.sizeUnsynchronisationWouldAdd(array2)
   if (res2 != 0){
       return 1
   }
   var array3:Array<Int8> = [BYTE_FF, BYTE_FB]
   var res3 = BufferTools.sizeUnsynchronisationWouldAdd(array3)
   if (res3 != 1){
       return 1
   }
   var array4:Array<Int8> = [0, BYTE_FF, BYTE_FB, 0]
   var res4 = BufferTools.sizeUnsynchronisationWouldAdd(array4)
   if (res4 != 1){
       return 1
   }
   var array5:Array<Int8> = [0, BYTE_FF]
   var res5 = BufferTools.sizeUnsynchronisationWouldAdd(array5)
   if (res5 != 1){
       return 1
   }
   var array6:Array<Int8> = [BYTE_FF, BYTE_FB, 0, BYTE_FF, BYTE_FB]
   var res6 = BufferTools.sizeUnsynchronisationWouldAdd(array6)
   if (res6 != 2){
       return 1
   }
   var array7:Array<Int8> = [BYTE_FF, BYTE_FF, BYTE_FF]
   var res7 = BufferTools.sizeUnsynchronisationWouldAdd(array7)
   if (res7 != 3){
       return 1
   }
   0
}


