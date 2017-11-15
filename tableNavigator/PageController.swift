//
//  PageController.swift
//  tableNavigator
//
//  Created by adminaccount on 11/3/17.
//  Copyright © 2017 adminaccount. All rights reserved.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
   
    var imageManager = FileManaging()
    var pageControl = UIPageControl()
    var editingCard: DiscountCard? = nil
    var segueToEdit = "returnToEdit"
    
    private (set) lazy var orderedViewControllers: [UIViewController] = {
        if editingCard != nil {
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
    
    private (set) lazy var images: [UIImageView] = {
        var first: UIImage?
        var secnd: UIImage?
        var third: UIImage?
        if editingCard != nil {
            if editingCard?.frontImageOfCard != nil {
                first = imageManager.getImage(nameOfImage: (editingCard?.frontImageOfCard)!)
            }
            else {
                first = UIImage(named: "flag.jpeg")
            }
            if editingCard?.backImageOfCard != nil {
                secnd = imageManager.getImage(nameOfImage: (editingCard?.backImageOfCard)!)
            }
            else {
                secnd = UIImage(named: "flag.jpeg")
            }
            if editingCard?.barcode != nil {
                if let tmpImage = imageManager.getImage(nameOfImage: (editingCard?.barcode)!){
                    third = tmpImage
                }
                else {
                    third = UIImage(named: "flag.jpeg")
                }
            }
            else {
                third = UIImage(named: "flag.jpeg")
            }
            if editingCard?.barcode != nil {
                return [createImage(currentImage: first!),
                        createImage(currentImage: secnd!),
                        createImage(currentImage: third!)]
            }
            else {
                return [createImage(currentImage: first!), createImage(currentImage: secnd!)]
            }
        }
        else {
            return [createImage(currentImage: UIImage(named: "flag.jpeg")!)]
        }
    }()
    
    private func newViewController(name: String) -> UIViewController {
         return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(name)View")// as! ImageViewController
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
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
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
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 70))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        //pageControl.tintColor = .red //UIColor(red: 39.0/255.0, green: 55.0/255.0, blue: 29.0/255.0, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor(red: 239.0/255.0, green: 255.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 139.0/255.0, green: 155.0/255.0, blue: 129.0/255.0, alpha: 1.0)
        view.addSubview(pageControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for index in 0...orderedViewControllers.count - 1
        {
            orderedViewControllers[index].view.addSubview(images[index])
        }
    }
    
    func createImage(currentImage: UIImage)->UIImageView{
        let imageView = UIImageView(image: currentImage)
        imageView.transform = imageView.transform.rotated(by: CGFloat(-Double.pi / 2))
        let newWidth = UIScreen.main.bounds.width - 20
        let newHeight = newWidth/0.63
        imageView.frame = CGRect(x: 10, y: 80, width: newWidth, height: newHeight)
        imageView.layer.cornerRadius = imageView.frame.width/13.0
        imageView.clipsToBounds = true
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        configurePageControl()
        
        let logo = UIImage(named: "flag.jpeg")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        navigationItem.titleView?.sizeToFit()
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToEdit  {
            let editController = segue.destination as? EditViewController
            //pageController?.delegate = self as? PageController
            editController?.editingCard = sender as? DiscountCard
        }
    }
    
    @IBAction func goToEdit(_ sender: Any) {
        performSegue(withIdentifier: segueToEdit, sender: editingCard)
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
