//
//  KakaoTalkTableViewCell.swift
//  week5
//
//  Created by 김나현 on 2022/10/19.
//

import UIKit

class KakaoTalkTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var memberCntLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageCntButton: UIButton!
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        backgroundColor = .white
//    }
    
}
