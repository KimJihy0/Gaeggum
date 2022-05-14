//
//  ContentCell.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/12.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var contentTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
