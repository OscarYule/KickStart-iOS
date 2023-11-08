//
//  HomeworkInfoCell.swift
//  ios_notepad
//
//  Created by xl12 on 2023/8/24.
//

import UIKit

class ExamsInfoCell: UITableViewCell {
    
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
