//
//  SubwayTableViewCell.swift
//  week9
//
//  Created by 김나현 on 2022/11/25.
//

import UIKit

class SubwayTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "SubwayTableViewCell"
    
    
    @IBOutlet weak var colorView: UIView!
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setInitialUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    // MARK: - Functions
    func setInitialUI() {
        colorView.layer.cornerRadius = colorView.frame.width / 2
        colorView.contentMode = .scaleAspectFill
        colorView.clipsToBounds = true
        colorView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
}
