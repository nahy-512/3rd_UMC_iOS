//
//  UserToken.swift
//  Instagram
//
//  Created by 김나현 on 2022/12/04.
//

import Foundation

class UserToken {
    static let shared = UserToken()
    
    var jwt : String?
    
    private init() { }
}
