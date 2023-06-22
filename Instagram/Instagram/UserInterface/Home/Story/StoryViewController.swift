//
//  StoryViewController.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/15.
//

import UIKit

class StoryViewController: UIViewController {
    
    // MARK: - Properties
    static let identifier = "StoryVC"
    
    var cellNum : String = "" // 이전 화면에서 cellNum 받기
    
    
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    
    
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet var heartTapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var sendMessageContainerView: UIView!
    @IBOutlet weak var sendMessageTextField: UITextField!
    
    var userName : String = ""
    var isHearted : Bool = false
    
    var time: Float = 0.0
    var timer: Timer?
    
    let storyDataDict : [String : [String]] = [
        "yeonHyun" : ["yeonHyun", "study", "3분"],
        "gogh" : ["gogh", "food1", "2시간"],
        "seori" : ["tori", "food2", "3시간"],
        "bori" : ["bori", "sky2", "30분"],
        "cocohaha" : ["cocohaha", "food3", "5시간"]
    ]
    
    var storyHeartData : [String : Bool] = [
        "yeonHyun" : false,
        "gogh" : false,
        "seori" : true,
        "bori" : false,
        "cocohaha" : false
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        userNameLabel.text = userName
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 스토리 데이터 설정
        userProfileImageView.image = UIImage(named: storyDataDict[userName]![0])
        storyImageView.image = UIImage(named: storyDataDict[userName]![1])
        postTimeLabel.text = storyDataDict[userName]![2]
        
        // 저장된 좋아요 정보 확인
        let saveIsHearted = UserDefaults.standard.bool(forKey: userName)
        isHearted = saveIsHearted
        if ( saveIsHearted == true) {
            heartImageView.image = UIImage(named: "RedHeart")
        }
        print("[viewWillAppear] userName:\(userName), savedIsHearted:\(saveIsHearted)")

    }
    
    override func viewDidLayoutSubviews() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
        
        heartTapGestureRecognizer.addTarget(self, action: #selector(heartViewDidTap))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UserDefaults.standard.set(isHearted, forKey: userName) // 하트 정보 저장
        storyHeartData[userName] = isHearted // 정보 업데이트
        print("[viewWillDisappear] userName:\(userName), isHearted:\(isHearted)")
    }
    
    
    // MARK: - Functions
    @IBAction func closeButton(_ sender: Any) {
        timer!.invalidate() // progressBar 타이머 종료
        self.dismiss(animated: true)
    }
    
    @IBAction func shareButtonDidTap(_ sender: Any) {
        timer!.invalidate() // progressBar 타이머 종료
        self.dismiss(animated: true)
    }
    
    
    @objc func setProgress() { // 타이머 설정
        
        time += 0.1
        let progress = time / 5
        
        DispatchQueue.main.async {
            
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    self.progressView.setProgress(progress, animated: true)
                    self.view.layoutIfNeeded()
                }
            )
        }
        
        if time >= 5 {
            timer!.invalidate()
            self.dismiss(animated: true)
            
        }
//        if (timer?.isValid == false) {
//            print("타이머 종료")
//        }
    }
    
    @objc func heartViewDidTap() {
        print("하트 이미지 클릭")
        checkIsHearted()
        timer!.invalidate()
        timer = nil
    }
    
    func setUI() {
        // 사용자 프로필
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
        userProfileImageView.contentMode = .scaleAspectFill
        userProfileImageView.clipsToBounds = true
        // 스토리 이미지
        storyImageView.contentMode = .scaleAspectFit
        storyImageView.clipsToBounds = true
        // 메시지 보내기
        sendMessageContainerView.layer.borderWidth = 0.8
        sendMessageContainerView.layer.borderColor = UIColor.systemGray6.cgColor
        sendMessageContainerView.layer.cornerRadius = 15
        sendMessageTextField.attributedPlaceholder = NSAttributedString(string: "메시지 보내기", attributes: [.foregroundColor: UIColor.white])
        // progressBar
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 0.5)
    }
    
    func checkIsHearted() {
        // 스토리 하트 여부 체크
        if (isHearted == false) {
            heartImageView.image = UIImage(named: "RedHeart")
            isHearted = true
        }
        else {
            heartImageView.image = UIImage(named: "ReelsHeart")
            isHearted = false
        }
        print("isHearted:\(isHearted)")
    }
}
