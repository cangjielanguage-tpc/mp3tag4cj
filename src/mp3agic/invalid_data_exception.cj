/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * InvalidDataException
 */
package mp3agic


/**
 * The class is InvalidDataException inherited from BaseException
 * @since 0.31.4
 */
public class InvalidDataException <: BaseException {

    /* let member serialVersionUID type is Int64 */
    private static let serialVersionUID: Int64 = 1i64

    /**
     * The Function is init constructor
     *
     * @since 0.31.4
     */
    public init (){
        super()
    }

    /**
     * The Function is init constructor
     *
     * @param message of String
     * @since 0.31.4
     */
    public init (message: String){
        super(message)
    }

}


