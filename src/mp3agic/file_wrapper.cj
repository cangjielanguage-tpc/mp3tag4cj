/* 
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Package type of the file, and obtain the basic information of the file.
 */
package mp3agic

from std import io.*
from std import fs.*

/**
 * The class is FileWrapper
 * @since 0.31.4
 */
public open class FileWrapper {
    protected var path: String = ""

    protected var length: Int64 = 0

    protected init() {}

    /**
     * The Function is init constructor
     * 
     * @param filename of String
     * @since 0.31.4
     */
    public init(filename: String) {
        this.path = FileInfo(filename).path.toCanonical().toString()
        var size = initSizeFunc(this.path)
        this.length = size
    }

    /**
     * The Function is init constructor
     * 
     * @param file of FileInfo
     * @since 0.31.4
     */
    public init(file: FileInfo) {
        try {
            this.path = file.path.toCanonical().toString()
        } catch (e: Exception) {
            throw IllegalArgumentException("File path exception")
        }
        var size = initSizeFunc(this.path)
        this.length = size
    }

    private static func initSizeFunc(path: String): Int64 {
        var file: File = File(FileInfo(path).path.toCanonical().toString(), OpenOption.Open(true, true))
        if (!file.canRead()) {
            throw BaseException("File not readable")
        }
        var byteaArray: Array<Byte> = file.readToEnd()
        file.close()
        return byteaArray.size
    }

    /**
     * The Function is getFilename
     * 
     * @return Type of String
     * @since 0.31.4
     */
    public open func getFilename(): String {
        return this.path
    }

    /**
     * The Function is getLength
     * 
     * @return Type of Int64
     * @since 0.31.4
     */
    public open func getLength(): Int64 {
        return this.length;
    }
}
