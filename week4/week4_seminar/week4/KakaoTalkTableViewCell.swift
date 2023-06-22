//
//  KakaoTalkTableViewCell.swift
//  week4
//
//  Created by 김나현 on 2022/10/11.
//

import UIKit

class KakaoTalkTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageCountButton: UIButton!
    
    // MARK: - Life Cycle
    override func awakeFromNib() { // viewDidLoad()
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 17.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
