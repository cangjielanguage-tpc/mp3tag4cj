// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from mp3agic import mp3agic.*
from std import io.*
from std import math.*

main() {
    var bytes: Array<Int8> = [0]
    var iD3v2PopmFrameData: ID3v2PopmFrameData = ID3v2PopmFrameData(false, bytes)
    iD3v2PopmFrameData.setRating(1)
    var rating = iD3v2PopmFrameData.getRating()
    println(rating)
    if (rating != 1){
        return 1
    }
    iD3v2PopmFrameData.setAddress("New Address")
    var address: Option<String> = iD3v2PopmFrameData.getAddress()
    println(address)
    if (address != "New Address"){
        return 1
    }
    var iD3v2PopmFrameData1: ID3v2PopmFrameData = ID3v2PopmFrameData(false, 0)
    iD3v2PopmFrameData1.setAddress("Address")
    var expectedLength = "Address".size + 2
    var len = iD3v2PopmFrameData1.getLength()
    println(len)
    if (len != 9){
        return 1
    }
    0
}

