/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * NotSupportedException
 */
package mp3agic


/**
 * The class is NotSupportedException inherited from BaseException
 * @since 0.31.4
 */
public class NotSupportedException <: BaseException {

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


