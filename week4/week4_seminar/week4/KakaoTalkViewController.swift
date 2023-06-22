//
//  KakaoTalkViewController.swift
//  week4
//
//  Created by 김나현 on 2022/10/11.
//

import UIKit

class KakaoTalkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var kakaoTalkTableView: UITableView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        kakaoTalkTableView.delegate = self
        kakaoTalkTableView.dataSource = self
    }
    
    // MARK: - Functions
    
    let chattingRoomData: [ChattingRoomDataModel] = [
        ChattingRoomDataModel(
            profileImage: UIImage(named: "swiftIcon"),
            name: "iOS 단톡방",
            lastMessage: "사진을 보냈습니다.",
            memberCount: "200",
            time: "오전 1:05",
            messageCount: "61"
        ),
        ChattingRoomDataModel(
            profileImage: UIImage(named: "umcIcon"),
            name: "UMC 3기 가천대 단톡방",
            lastMessage: "다들 미션 다 끝내셨나요?",
            memberCount: "200",
            time: "오전 12:31",
            messageCount: "61"
        ),
        ChattingRoomDataModel(
            profileImage: UIImage(named: "swiftIcon"),
            name: "iOS 단톡방",
            lastMessage: "사진을 보냈습니다.",
            memberCount: "200",
            time: "오전 1:05",
            messageCount: "61"
        ),
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 한 섹션에 몇 행? -> Cell의 개수
        return chattingRoomData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 테이블뷰에 넣을 Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "KakaoTalkTableViweCell", for: indexPath) as?
             KakaoTalkTableViewCell else { return UITableViewCell() }
        cell.profileImageView.image = chattingRoomData[indexPath.row].profileImage
        cell.nameLabel.text = chattingRoomData[indexPath.row].name
        cell.lastMessageLabel.text = chattingRoomData[indexPath.row].lastMessage
        if let memberCount = chattingRoomData[indexPath.row].memberCount { // nil값이 아니라면
            cell.memberCountLabel.text = memberCount
        } else { // nil이라면
            cell.memberCountLabel.isHidden = true
        }
        cell.memberCountLabel.text = chattingRoomData[indexPath.row].memberCount
        
        return cell
    }
}

struct ChattingRoomDataModel {
    let profileImage: UIImage?
    let name: String
    let lastMessage: String
    let memberCount: String? // 갠톡에는 없기 때문에
    let time: String
    let messageCount: String
}
