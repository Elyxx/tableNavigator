//
//  CardTableViewCell.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var nameCell: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var filterCell: UILabel!
    
    @IBOutlet weak var descripCell: UITextView!
    
    @IBOutlet weak var dataCell: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
