//
//  TableViewCell.swift
//  week4_mission
//
//  Created by 김나현 on 2022/10/14.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var memoTitleLabel: UILabel!
    @IBOutlet weak var memoDateLabel: UILabel!
    @IBOutlet weak var memoContentLabel: UILabel!
    @IBOutlet weak var memoCategoryLabel: UILabel!
    @IBOutlet weak var memoContentImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
