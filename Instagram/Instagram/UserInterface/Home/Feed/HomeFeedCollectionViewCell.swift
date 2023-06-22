//
//  HomeFeedCollectionViewCell.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/04.
//

import UIKit
import Foundation


protocol NotifyHeartTapDelegate {
    func onClickHeart(index: Int, isHearted: Bool)
}

class HomeFeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellId = "HomeFeedCollectionViewCell"
    static let className = "HomeFeedCollectionViewCell"
    
    // Data
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var heartNumLabel: UILabel!
    @IBOutlet weak var userName2Label: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // Button
    @IBOutlet weak var heartImageView: UIImageView!
    
    @IBOutlet weak var heartAnimationImageView: UIImageView!
    
    var delegate : NotifyHeartTapDelegate?
    
    var cellIndex : Int = 0
    var isHearted = false
    var heartNum : Int = 0
    var commentNum : Int = 0
    
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        
        tapGesture()
        
    }
    
    
    // MARK: - Function
    func tapGesture() {
        // 하트 이미지 틀릭
        let heartTapGesture = UITapGestureRecognizer(target: self, action: #selector(heartViewDidTap))
        heartImageView.addGestureRecognizer(heartTapGesture)
        //heartImageView.isUserInteractionEnabled = true
        
        // 게시물 이미지 더블 클릭
        let postImgDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(postImgDidDoubleTap))
        postImgDoubleTapGesture.numberOfTapsRequired = 2 // 두 번 탭할시
        postImageView.addGestureRecognizer(postImgDoubleTapGesture)
        postImageView.isUserInteractionEnabled = true
        
        // 좋아요수 레이블 클릭
        let heartNumLableTapGesture = UITapGestureRecognizer(target: self, action: #selector(heartNumLabelDidTap))
        heartNumLabel.addGestureRecognizer(heartNumLableTapGesture)
        heartNumLabel.isUserInteractionEnabled = true
    }
    
    
    @objc func heartViewDidTap() {
        print("하트 이미지 클릭")
        self.heartImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        if (isHearted == false) {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                usingSpringWithDamping: 0.5, // 튕기는 정도
                initialSpringVelocity: 0.6,  // 튕기는 속도
                options: .curveLinear,
                animations: {
                    self.heartImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.heartImageView.image = UIImage(named: "RedHeart")
                    
                },
                completion: { _ in  // 애니메이션이 끝난 뒤 실행
                    self.isHearted = true
                    self.heartNum += 1
                    self.updateHeartNum(likeNum : self.heartNum) // 바뀐 좋아요 수 반영
                    self.delegate?.onClickHeart(index: self.cellIndex, isHearted: self.isHearted)
                    //print("index: \(self.cellIndex)") // index 찍어보기
                }
            )
        } else {
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.7,
                animations: {
                    self.heartImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.heartImageView.image = UIImage(named: "Heart")
                    
                },
                completion: { _ in
                    self.isHearted = false
                    self.heartNum -= 1
                    self.updateHeartNum(likeNum: self.heartNum)
                    self.delegate?.onClickHeart(index: self.cellIndex, isHearted: self.isHearted)
                    //print("index: \(self.cellIndex)")
                }
            )
        }
        checkIsHearted()
    }
    
    @objc func postImgDidDoubleTap() {
        print("게시물 이미지 더블 클릭")
        heartAnimationImageView.isHidden = false
        self.heartAnimationImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        if (isHearted == false) {
            heartViewDidTap() // 하트 채워짐 + 좋아요 수 증가
        }
        
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.3, // 튕기는 정도
            initialSpringVelocity: 0.6,  // 튕기는 속도
            options: .curveLinear,
            animations: {
                self.heartAnimationImageView.transform = CGAffineTransform(scaleX: 1, y: 1) // 피드 위 흰색 하트
                if (self.isHearted) {
                    self.heartImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    UIView.animate( // 빨간 하트 애니메이션
                        withDuration: 0.2,
                        delay: 0,
                        usingSpringWithDamping: 0.5,
                        initialSpringVelocity: 0.6,
                        animations: {
                            self.heartImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                            self.heartImageView.image = UIImage(named: "RedHeart")
                        }
                    )
                }
            },
            completion: { _ in  // 애니메이션이 끝난 뒤
                self.heartAnimationImageView.isHidden = true
            }
        )
        
        isHearted = true
        
    }
    
    @objc func heartNumLabelDidTap() {
        print(heartNumLabel.text!) // 좋아요 수 출력
    }
    
    func setUI() {
        
        // 프로필 이미지
        profileImageView.layer.cornerRadius = 18
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        // 게시물 사진
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        // 애니메이션으로 나올 하트
        heartAnimationImageView.isHidden = true
    
    }
    
    
    func updateHeartNum(likeNum : Int) { // int형 좋아요 수 전달받아 구두점 찍기
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: likeNum)!
                
        heartNumLabel.text = "좋아요 \(result)개"
    }
    
    func checkIsHearted() {
        // 스토리 하트 여부 체크
        if (isHearted == false) {
            heartImageView.image = UIImage(named: "RedHeart")
            isHearted = true
        }
        else {
            heartImageView.image = UIImage(named: "Heart")
            isHearted = false
        }
        //print("isHearted:\(isHearted)")
    }
}
