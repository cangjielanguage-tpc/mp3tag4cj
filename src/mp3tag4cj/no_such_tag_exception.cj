/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * NoSuchTagException
 */
package mp3tag4cj.mp3tag4cj

/**
 * The class is NoSuchTagException inherited from BaseException
 * @since 0.31.4
 */
public class NoSuchTagException <: BaseException {
    private static let serialVersionUID: Int64 = 1i64

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
