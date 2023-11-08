//
//  TimetableCell.swift
//  ios_notepad
//
//  Created by LXie on 24/8/2023.
//

import UIKit

class TimetableCell: UITableViewCell {

    @IBOutlet var titLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var deadlineLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
