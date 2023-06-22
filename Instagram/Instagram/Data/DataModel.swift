//
//  SignupDataModel.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/30.
//

import Foundation


// MARK: - 1,2. SignupDataModel
struct SignupDataModel: Decodable {
    let isSuccess: Bool
    let code : Int
    let message : String
    let result : SignupResult
}
// MARK: - SignupResult
struct SignupResult: Decodable {
    let userIdx: Int
    let jwt: String
}


// MARK: - 3. UserInfoDataModel
struct InfoDataModel: Decodable {
    let isSuccess: Bool
    let code : Int
    let message : String
    let result: String
}


// MARK: - 4. HomeFeedDataModel
struct HomeFeedDataModel: Decodable {
    let isSuccess: Bool
    let code : Int
    let message : String
    let result : [PostResult]
}
struct PostResult: Decodable {
    let postIdx : Int
    let userID : String
    let userProfileImg : String?
    let postContent : String
    let commentNum : Int
    let uploadTime : String
    let imgList : [ImgList]
    let commentList : [CommentList]
}
struct ImgList : Decodable {
    let postImgIdx : Int
    let postImgUrl : String
}
struct CommentList : Decodable {
    let commentIdx : Int
    let userID : String
    let commentContents : String
}


// MARK: - 5. MyPageDataModel
struct MyPageDataModel: Codable {
    let isSuccess: Bool
    let code : Int
    let message : String
    let result : MyInfo
}
struct MyInfo : Codable {
    let userIdx : Int
    let userID : String
    let userName : String
    let userIntro : String?
    let userWebsite : String?
    let userProfileImg : String?
    let postNum : Int
    let followerNum : Int
    let followingNum : Int
}
