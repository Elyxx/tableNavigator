//
//  CardTableViewCell.swift
//  tableNavigator
//
//  Created by adminaccount on 10/28/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @objc func handleSwipes(sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.8, delay: 0.4,
                       options: [],
                       animations: {
                        if self.imageCell.image != self.backImage {
                            self.imageCell.image = self.backImage
                        }
                        else {
                            self.imageCell.image = self.frontImage
                        }
        },
                       completion: nil
        )
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCell.layer.cornerRadius = imageCell.frame.width/20.0
        nameCell.layer.cornerRadius = nameCell.frame.width/14.0
        imageCell.isUserInteractionEnabled = true
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        imageCell.addGestureRecognizer(rightSwipe)
    }

    var applyPinch = false
    
    @IBOutlet weak var nameCell: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var filterCell: UIImageView!
    
    @IBOutlet weak var descripCell: UITextView!
    
    @IBOutlet weak var dataCell: UILabel!
    
    var backImage: UIImage?
    
    var frontImage: UIImage?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func pinch(senderScale: CGFloat) {
        //var newSenderScale = senderScale
        let currentScale = imageCell.frame.size.width / imageCell.bounds.size.width
        var newScale = currentScale * senderScale
        if newScale > 1 {
             newScale = 1
        }
        let transform = CGAffineTransform(scaleX: newScale, y: newScale)
        imageCell.transform = transform
        print("current \(currentScale)")
        print("sender \(senderScale)")
    }
    
}
