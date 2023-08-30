//
//  BoyDressUpViewController.swift
//  paperDoll
//
//  Created by Howe on 2023/8/25.
//

import UIKit


extension BoyDressUpViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageNumber = itemScrollView.contentOffset.x / itemScrollView.bounds.width
        itemScrollViewPageControl.currentPage = Int(pageNumber)
        print(itemScrollView.contentOffset.x)
        print(itemScrollView.bounds.width)
        // scrollview 內的 view 寬為：750，照理來說在滑動時應該會是跑一半，數值應該是 375 / 375，但不知道為何數值是跑 360 / 390，在把裡面的 view 約束設為 780 時 page control 才能成功的動起來，難以理解。
    }
}





class BoyDressUpViewController: UIViewController {

    
    @IBOutlet weak var hatImageView: UIImageView!
    @IBOutlet weak var sunglassImageView: UIImageView!
    @IBOutlet weak var clothesImageView: UIImageView!
    @IBOutlet weak var bagImageView: UIImageView!
    @IBOutlet weak var pantsImageView: UIImageView!
    @IBOutlet weak var shoesImageView: UIImageView!
    
    
    
    
    
    
    @IBOutlet weak var itemCategoryScrollView: UIScrollView!
    @IBOutlet var itemCategoryViews: [UIView]!
    @IBOutlet var itemCategoryButtons: [UIButton]!
    
    
    
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet var itemButtons: [UIButton]!
    
    
    @IBOutlet weak var itemScrollViewPageControl: UIPageControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        itemScrollView.delegate = self
        initialScreen()
        
        
    }
    
    
    @IBAction func pageControlValueChange(_ sender: UIPageControl) {
        let point = CGPoint(x: itemScrollView.bounds.width * CGFloat(sender.currentPage), y: 0)
        itemScrollView.setContentOffset(point, animated: true)
    }
    
    
    
    @IBAction func itemCategoryButtonCheck(_ sender: UIButton) {
        itemCategoryColorChange(sender.tag % 60)
        
        switch sender.tag {
        case 60 :
            for i in 0...1{
                itemButtons[i].configuration?.image = UIImage(named: "BoyHat-"+"\(i+1)")
            }
            for e in 2...4{
                itemButtons[e].configuration?.image = UIImage(named: "null")
            }
        case 61 :
            itemButtons[0].configuration?.image = UIImage(named: "BoyBag")
            for e in 1...4{
                itemButtons[e].configuration?.image = UIImage(named: "null")
            }
        case 62 :
            for i in 0...4{
                itemButtons[i].configuration?.image = UIImage(named: "BoyClothes-"+"\(i+1)")
            }
        case 63 :
            for i in 0...2{
                itemButtons[i].configuration?.image = UIImage(named: "BoyPants-"+"\(i+1)")
            }
            for e in 3...4{
                itemButtons[e].configuration?.image = UIImage(named: "null")
            }
        case 64 :
            for i in 0...2{
                itemButtons[i].configuration?.image = UIImage(named: "BoyShoes-"+"\(i+1)")
            }
        case 65 :
            itemButtons[0].configuration?.image = UIImage(named: "BoySunglass")
            for e in 1...4{
                itemButtons[e].configuration?.image = UIImage(named: "null")
            }
        default :
            print("OK")
        }
        
        
    }
    
    
    func itemCategoryColorChange (_ senderTag: Int) {
        for view in itemCategoryViews {
            if view.tag % 50 == senderTag {
                view.backgroundColor = .systemPurple
            } else {
                view.backgroundColor = .white
            }
        }
        
        for button in itemCategoryButtons {
            if button.tag % 60 == senderTag {
                button.tintColor = .systemPurple
            } else {
                button.tintColor = .white
            }
        }
    }
    
    
    
    
    @IBAction func dressUpOnBoyButton(_ sender: UIButton) {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func initialScreen () {
        hatImageView.image = UIImage(named: "null")
        sunglassImageView.image = UIImage(named: "null")
        clothesImageView.image = UIImage(named: "BoyClothes-1")
        bagImageView.image = UIImage(named: "null")
        pantsImageView.image = UIImage(named: "BoyPants-1")
        shoesImageView.image = UIImage(named: "null")
        
        itemCategoryButtons[0].isSelected = true
        itemCategoryColorChange(0)
        
        //顯示body選項
        for i in 0...1{
            itemButtons[i].configuration?.image = UIImage(named: "BoyHat-"+"\(i+1)")
        }
        
    }
    
    
    
    
    
    
}
