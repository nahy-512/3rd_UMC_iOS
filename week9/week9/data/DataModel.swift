//
//  DataModel.swift
//  week9
//
//  Created by 김나현 on 2022/11/21.
//

import Foundation

// MARK: - DataModel
struct DataModel: Decodable {
    let response: Response
}

// MARK: - Response
struct Response: Decodable {
    let header: Header
    let body: Body
}

// MARK: - Header
struct Header: Decodable {
    let resultCode, resultMsg: String
}

// MARK: - Body
struct Body: Decodable {
    let items: Items
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct Items: Decodable {
    let item: [Item]
}

// MARK: - Item
struct Item: Decodable {
    let subwayRouteName, subwayStationID, subwayStationName: String
}


