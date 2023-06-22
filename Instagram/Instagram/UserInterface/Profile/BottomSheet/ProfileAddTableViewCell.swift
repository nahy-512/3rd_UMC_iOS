//
//  ProfileAddTableViewCell.swift
//  Instagram
//
//  Created by 김나현 on 2022/11/06.
//

import UIKit

class ProfileAddTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "ProfileAddTableViewCell"
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellButton: UIButton!
    
//    let buttonImage : cellButton.imageView
//    let buttonTitle = cellButton.titleLabel
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    // MARK: - Functions
    func setupUI() {
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
    }
    
}
