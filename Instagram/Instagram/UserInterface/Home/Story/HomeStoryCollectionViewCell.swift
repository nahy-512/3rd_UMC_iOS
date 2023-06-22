//
//  HomeStoryCollectionViewCell.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/04.
//

import UIKit

class HomeStoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let cellId = "HomeStoryCollectionViewCell"
    static let className = "HomeStoryCollectionViewCell"
    
    let storyColor = UIColor(named: "storyDefault")
    
    @IBOutlet weak var storyProfileImageView: UIImageView!
    @IBOutlet weak var storyProfileBackgroundView: UIView!
    @IBOutlet weak var storyPlusImageView: UIImageView! // Boolean
    @IBOutlet weak var storyProfileNameLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 내스토리 특별대우 보장
        storyPlusImageView.isHidden = true
        storyProfileBackgroundView.layer.borderColor = storyColor?.cgColor
    }
    
    // MARK: - Functions
    func setUI() {
        
        // 프로필 이미지
        storyProfileImageView.contentMode = .scaleAspectFill
        storyProfileImageView.clipsToBounds = true
        storyProfileImageView.layer.cornerRadius = 31
        
        // 스토리 활성화 유무 표시
        storyProfileBackgroundView.layer.cornerRadius = 35
        storyProfileBackgroundView.layer.borderWidth = 2.0
        storyProfileBackgroundView.layer.borderColor = storyColor?.cgColor
        storyProfileBackgroundView.contentMode = .scaleAspectFill
        storyProfileBackgroundView.clipsToBounds = true
//        storyProfileBackgroundView.backgroundColor = storyColor
        
        // 내스토리 추가 버튼
        storyPlusImageView.isHidden = true
        storyPlusImageView.layer.cornerRadius = 12.5
        storyPlusImageView.contentMode = .scaleAspectFill
        storyPlusImageView.clipsToBounds = true
        storyPlusImageView.layer.borderWidth = 3.5
        storyPlusImageView.layer.borderColor = UIColor.white.cgColor
    }
}
