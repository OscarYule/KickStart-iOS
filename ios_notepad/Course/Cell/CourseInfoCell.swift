//
//  CourseInfoCell.swift
//  ios_notepad
//
//  Created by LXie on 23/8/2023.
//

import UIKit

class CourseInfoCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
