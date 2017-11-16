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
        imageCell.layer.cornerRadius = imageCell.frame.width/13.0
        nameCell.layer.cornerRadius = nameCell.frame.width/14.0
        imageCell.isUserInteractionEnabled = true
    
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(sender:)))
        imageCell.addGestureRecognizer(pinch)
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
    
    @objc func pinch(sender:UIPinchGestureRecognizer) {
        
        //const.isActive = false
        if sender.state == .changed {
            let currentScale = self.imageCell.frame.size.width / self.imageCell.bounds.size.width
            var newScale = currentScale*sender.scale
            if newScale < 1 {
                newScale = 0.1
            }
            if newScale > 1 {
                newScale = 1
            }
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            self.imageCell.transform = transform
            sender.scale = 1
        } /*else if sender.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                self.imageCell.transform = CGAffineTransform.identity
            })

        } */
        //const.isActive = true
    }

}
