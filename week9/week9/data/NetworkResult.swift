//
//  NetworkResult.swift
//  week9
//
//  Created by 김나현 on 2022/11/26.
//

import Foundation
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
