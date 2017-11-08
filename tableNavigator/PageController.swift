//
//  PageController.swift
//  tableNavigator
//
//  Created by adminaccount on 11/3/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
   
    var pageControl = UIPageControl()
    var editingCard: DiscountCard? = nil
    
    //somewhere here we should get data about barcode (is/isnt)
    private (set) lazy var orderedViewControllers: [UIViewController] = {
        if editingCard != nil {
            print("array")
            if editingCard?.barcode != nil {
                return [self.newViewController(name: "front"),
                        self.newViewController(name: "back"),
                        self.newViewController(name: "barcode")]
            }
            else{
                return [self.newViewController(name: "front"),
                        self.newViewController(name: "back")]
            }
        }
        else {
            return [self.newViewController(name: "front")]
        }
    }()
    
    private func newViewController(name: String) -> UIViewController {
        let b: ImageViewController = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(name)View") as! ImageViewController
      
        return b
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let b: ImageViewController = orderedViewControllers[orderedViewControllers.index(of: viewController)!] as! ImageViewController
        if b.backImage != nil {
            if let url = NSURL(string: (editingCard?.frontImageOfCard!)!) {
                //print(url)
                if let data = NSData(contentsOf: url as URL) {
                    b.backImage.image = UIImage(data: data as Data)
                    // backView.backImage.transform = backView.backImage.transform.rotated(by: CGFloat((Double.pi / 2)*(-1)))
                }
            }
        }
        if b.frontImage != nil {
            b.frontImage.image = UIImage(named: "britt.jpg")
           
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        /*let backView: ImageBackViewController =  orderedViewControllers[1] as! ImageBackViewController
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let backView: ImageViewController = //storyboard.instantiateViewController(withIdentifier: "backView") as! ImageViewController
        // self.present(backView, animated: true, completion: nil)
        
         let imageName = "yourImage.png"
         let image = UIImage(named: imageName)
         let imageView = UIImageView(image: image!)
 
        if let url = NSURL(string: (editingCard?.frontImageOfCard!)!) {
            //print(url)
            if let data = NSData(contentsOf: url as URL) {
                backView.back.image = UIImage(data: data as Data)
                // backView.backImage.transform = backView.backImage.transform.rotated(by: CGFloat((Double.pi / 2)*(-1)))
            }
        }*/
       
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageCount count: Int){
        pageControl.numberOfPages = count
    }
    func pageViewController(pageViewController: UIPageViewController,
                            didUpdatePageIndex index: Int){
        pageControl.currentPage = index
    }
 
    func configurePageControl() {
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 70,width: UIScreen.main.bounds.width,height: 70))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor(red: 39.0/255.0, green: 55.0/255.0, blue: 29.0/255.0, alpha: 1.0)
       // pageControl.pageIndicatorTintColor = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 39.0/255.0, green: 55.0/255.0, blue: 29.0/255.0, alpha: 1.0)
        view.addSubview(pageControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        configurePageControl()
        print("did load")
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        //orderedViewControllers: [UIViewController]
        
        if editingCard != nil{
            let frontView: ImageViewController = orderedViewControllers[0] as! ImageViewController
            frontView.frontImage.image = UIImage(named: "britt.jpg")
            /*if let url = NSURL(string: (editingCard?.frontImageOfCard!)!) {
                //print(url)
                if let data = NSData(contentsOf: url as URL) {
                    frontView.frontImage.image = UIImage(data: data as Data)
                    //frontView.frontImage.transform = frontView.frontImage.transform.rotated(by: CGFloat((Double.pi / 2)*(-1)))
               // }
            }*/
           // let backView: ImageViewController =  orderedViewControllers[0] as! ImageViewController
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let backView: ImageViewController = //storyboard.instantiateViewController(withIdentifier: "backView") as! ImageViewController
            // self.present(backView, animated: true, completion: nil)
            
            //let imageName = "yourImage.png"
            //let image = UIImage(named: imageName)
            //let imageView = UIImageView(image: image!)
            
           /* if let url = NSURL(string: (editingCard?.frontImageOfCard!)!) {
                //print(url)
                if let data = NSData(contentsOf: url as URL) {
                    backView.back.image = UIImage(data: data as Data)
                    // backView.backImage.transform = backView.backImage.transform.rotated(by: CGFloat((Double.pi / 2)*(-1)))
                }
            }
            */
            
            print(editingCard?.nameOfCard as Any)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
