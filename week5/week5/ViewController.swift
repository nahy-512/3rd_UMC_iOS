//
//  ViewController.swift
//  week5
//
//  Created by 김나현 on 2022/10/18.
//

import UIKit
import Lottie

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Properties
    @IBOutlet weak var kakaoTalkTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    lazy var lottieView: LottieAnimationView = { // lottie
        let animationView = LottieAnimationView(name: "refreshLottie")
        animationView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let centerX = UIScreen.main.bounds.width / 2
        animationView.center = CGPoint(x: centerX, y: 40)
        animationView.contentMode = .scaleAspectFit
        animationView.stop()
        animationView.isHidden = true
        return animationView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initRefreshControl()
    }
    
    
    // MARK: - Functions
    
    func setupTableView() {
        // TableView에 Cell 등록
        let nibName = UINib(nibName: "KakaoTalkTableViewCell", bundle: nil)
        kakaoTalkTableView.register(nibName, forCellReuseIdentifier: "kakaoTalkTableViewCell")
        kakaoTalkTableView.delegate = self
        kakaoTalkTableView.dataSource = self
    }
    
    // indicator
    func initRefreshControl() {
        refreshControl.addSubview(lottieView)
        refreshControl.tintColor = .clear
        refreshControl.addTarget(
            self,
            action: #selector(refreshTableView(refreshControl:)),
            for: .valueChanged
        )
        kakaoTalkTableView.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        print("새로고침!!")
        lottieView.isHidden = false
        lottieView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.lottieView.isHidden = true
            self.lottieView.stop()
            self.kakaoTalkTableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
//    @objc func handleRefreshControl() { // 콘텐츠를 업데이트 했을 때 작업
//        print("새로고침 됨!!!")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // delay
//            self.refreshControl.endRefreshing() // 새로고침을 종료
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chattingRoomData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoTalkTableViewCell", for: indexPath) as? KakaoTalkTableViewCell else { return UITableViewCell() }
        
        cell.profileImageView.contentMode = .scaleToFill
        cell.profileImageView.clipsToBounds = true
        
        if let profileImage = chattingRoomData[indexPath.row].profileImage {
            cell.profileImageView.image = profileImage
        } else {
            cell.profileImageView.image = UIImage(systemName: "person")
        }
        cell.nameLabel.text = chattingRoomData[indexPath.row].name
        cell.lastMessageLabel.text = chattingRoomData[indexPath.row].lastMessage
        if let memberCount = chattingRoomData[indexPath.row].memberCount {
            cell.memberCntLabel.text = String(memberCount)
        }
        else {
            cell.memberCntLabel.isHidden = true
        }
        cell.timeLabel.text = chattingRoomData[indexPath.row].time
        if let messageCount = chattingRoomData[indexPath.row].messageCount {
            cell.messageCntButton.setTitle(String(messageCount), for: .normal)
        }
        else {
            cell.messageCntButton.isHidden = true
        }
        
//        if indexPath.row == 0 { // 특정 인덱스 특징
//            cell.backgroundColor = .red
//        }
        
        return cell
    }
    
    
    let chattingRoomData : [ChattingRoomDataModel] = [
        ChattingRoomDataModel(
            profileImage: UIImage(named: "swiftIcon"),
            name: "iOS 단톡방",
            lastMessage: "사진을 보냈습니다.",
            memberCount: 200,
            time: "오전 1:05",
            messageCount: 8
        ),
        ChattingRoomDataModel(
            profileImage: UIImage(named: "umcIcon"),
            name: "UMC 3기 가천대 단톡방",
            lastMessage: "다들 미션 다 끝내셨나요?",
            memberCount: 4,
            time: "오전 12:31",
            messageCount: 3
        ),
        ChattingRoomDataModel(
            profileImage: UIImage(named: "namo"),
            name: "나모 단체 채팅방",
            lastMessage: "나모는 몽몽 울어..",
            memberCount: 7,
            time: "오전 12:28",
            messageCount: 5
        ),
        ChattingRoomDataModel(
            profileImage: UIImage(systemName: "person.fill"),
            name: "익명",
            lastMessage: "하위~!👋🏻",
            memberCount: nil,
            time: "오전 12:02",
            messageCount: 3
        ),
        ChattingRoomDataModel(
            profileImage: nil,
            name: "익명2",
            lastMessage: "화이팅 해봐요!!",
            memberCount: nil,
            time: "어제",
            messageCount: 1
        ),
        ChattingRoomDataModel(
            profileImage: nil,
            name: "익명3",
            lastMessage: "화이팅 해봐요!!",
            memberCount: nil,
            time: "어제",
            messageCount: nil
        ),
        ChattingRoomDataModel(
            profileImage: nil,
            name: "익명4",
            lastMessage: "화이팅 해봐요!!",
            memberCount: nil,
            time: "어제",
            messageCount: 1
        ),
        ChattingRoomDataModel(
            profileImage: nil,
            name: "익명5",
            lastMessage: "화이팅 해봐요!!",
            memberCount: nil,
            time: "월요일",
            messageCount: 1
        ),
    ]
}

struct ChattingRoomDataModel {
    let profileImage : UIImage?
    let name : String
    let lastMessage : String
    let memberCount : Int? // 갠톡은 멤버수 표시 안함
    let time : String
    let messageCount : Int?
}
