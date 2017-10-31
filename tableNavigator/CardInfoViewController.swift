//
//  CardInfoViewController.swift
//  tableNavigator
//
//  Created by adminaccount on 10/29/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class CardInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*if let url = NSURL(string: "http://www.petsfriend.ca/media/k2/items/cache/95afb94bcb9e5971a68576edb0850e71_S.jpg") {
            if let myData = NSData(contentsOf: url as URL) {
                frontDefaultImage.image = UIImage(data: myData as Data)
            }
        }*/
        
        frontDefaultImage.image = UIImage(named: "funny.jpeg")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var frontDefaultImage: UIImageView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
