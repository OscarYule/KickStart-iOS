//
//  CoursesCell.swift
//  ios_notepad
//
//  Created by LXie on 24/8/2023.
//

import UIKit

class CoursesCell: UITableViewCell {

    @IBOutlet var titLabel: UILabel!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var courseTimeLabel: UILabel!
    @IBOutlet var classroomLabel: UILabel!
    @IBOutlet var instructorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
