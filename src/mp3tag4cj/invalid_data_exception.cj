/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * InvalidDataException
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is InvalidDataException inherited from BaseException
 * @since 0.31.4
 */
public class InvalidDataException <: BaseException {
    /* let member serialVersionUID type is Int64 */

    /**
     * The Function is init constructor
     * 
     * @since 0.31.4
     */
    public init() {
        super()
    }

    /**
     * The Function is init constructor
     * 
     * @param message of String
     * @since 0.31.4
     */
    public init(message: String) {
        super(message)
    }
}
