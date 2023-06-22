//
//  ProfilePostCollectionViewCell.swift
//  Instagram
//
//  Created by 김나현 on 2022/10/17.
//

import UIKit

class ProfilePostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var postImageView: UIImageView!
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postImageView.clipsToBounds = true

    }
    
}
