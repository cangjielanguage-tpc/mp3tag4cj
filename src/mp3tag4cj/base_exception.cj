/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * Basic exception
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is BaseException inherited from Exception
 * @since 0.31.4
 */
public open class BaseException <: Exception {

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
