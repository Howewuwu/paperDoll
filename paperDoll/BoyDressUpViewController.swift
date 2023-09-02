//
//  BoyDressUpViewController.swift
//  paperDoll
//
//  Created by Howe on 2023/8/25.
//

import UIKit

// 擴展BoyDressUpViewController以實現UIScrollViewDelegate的功能
extension BoyDressUpViewController: UIScrollViewDelegate {
    // 當滾動視圖停止滾動後，此方法將被調用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 通過滾動視圖的水平偏移量和其寬度計算當前頁碼
        let pageNumber = itemScrollView.contentOffset.x / itemScrollView.bounds.width
        // 更新頁面控制器的當前頁
        itemScrollViewPageControl.currentPage = Int(pageNumber)
        // 打印滾動視圖的水平偏移量和寬度，用於調試
        print(itemScrollView.contentOffset.x)
        print(itemScrollView.bounds.width)
        // scrollview 內的 view 寬為：750，照理來說在滑動時應該會是跑一半，數值應該是 375 / 375，但不知道為何數值是跑 360 / 390，在把裡面的 view 約束設為 780 時 page control 才能成功的動起來，難以理解。
        // 後來發現是 Xcode 的 Bug，因為 iphone 12 的實際的寬是 390，但是 Xcode 顯示的是 375，所以 pageControll 才會無法正確顯示。
    }
}

// 主要的ViewController，用於男孩的換裝功能
class BoyDressUpViewController: UIViewController {
    // 從Storyboard連接的IBOutlet，代表界面上的各種UI元素
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
    
    // 用於追踪當前選擇的項目類別
    var index = 0
    
    // 當視圖加載完成後，此方法將被調用
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置滾動視圖的代理為自己，以便接收滾動事件
        itemScrollView.delegate = self
        // 初始化屏幕上的UI元素
        initialScreen()
    }
    
    // 當頁面控制器的值改變時，此方法將被調用
    @IBAction func pageControlValueChange(_ sender: UIPageControl) {
        // 計算滾動視圖應該滾動到的位置，並將其滾動到該位置
        let point = CGPoint(x: itemScrollView.bounds.width * CGFloat(sender.currentPage), y: 0)
        itemScrollView.setContentOffset(point, animated: true)
    }
    
    // 當項目類別按鈕被點擊時，此方法將被調用
    @IBAction func itemCategoryButtonCheck(_ sender: UIButton) {
        // 根據被點擊的按鈕的tag值來決定要顯示哪一類的項目
        itemCategoryColorChange(sender.tag % 60)
        
        switch sender.tag {
        case 60 :
            for i in 0...1{
                itemButtons[i].configuration?.image = UIImage(named: "BoyHat-"+"\(i+1)")
            }
            for e in 2...4{
                itemButtons[e].configuration?.image = UIImage(systemName: "nosign")
            }
            index = 60
        case 61 :
            itemButtons[0].configuration?.image = UIImage(named: "BoyBag-1")
            for e in 1...4{
                itemButtons[e].configuration?.image = UIImage(systemName: "nosign")
            }
            index = 61
        case 62 :
            for i in 0...4{
                itemButtons[i].configuration?.image = UIImage(named: "BoyClothes-"+"\(i+1)")
            }
            index = 62
        case 63 :
            for i in 0...2{
                itemButtons[i].configuration?.image = UIImage(named: "BoyPants-"+"\(i+1)")
            }
            for e in 3...4{
                itemButtons[e].configuration?.image = UIImage(systemName: "nosign")
            }
            index = 63
        case 64 :
            for i in 0...2{
                itemButtons[i].configuration?.image = UIImage(named: "BoyShoes-"+"\(i+1)")
            }
            index = 64
        case 65 :
            itemButtons[0].configuration?.image = UIImage(named: "BoySunglass-1")
            for e in 1...4{
                itemButtons[e].configuration?.image = UIImage(systemName: "nosign")
            }
            index = 65
        default :
            print("OK")
        }
    }
    
    // 用於更新項目類別按鈕和視圖的顏色
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
    
    // 當換裝按鈕被點擊時，此方法將被調用
    @IBAction func dressUpOnBoyButton(_ sender: UIButton) {
        // 根據當前選擇的項目類別來決定要更換哪一部分的服裝
        switch index {
        case 60 :
            hatImageView.image = UIImage(named: "BoyHat-"+"\(sender.tag + 1)")
        case 61 :
            bagImageView.image = UIImage(named: "BoyBag-"+"\(sender.tag + 1)")
        case 62 :
            clothesImageView.image = UIImage(named: "BoyClothes-"+"\(sender.tag + 1)")
        case 63 :
            pantsImageView.image = UIImage(named: "BoyPants-"+"\(sender.tag + 1)")
        case 64 :
            shoesImageView.image = UIImage(named: "BoyShoes-"+"\(sender.tag + 1)")
        case 65 :
            sunglassImageView.image = UIImage(named: "BoySunglass-"+"\(sender.tag + 1)")
        default :
            print("oh")
        }
    }
    
    // 當隨機按鈕被點擊時，此方法將被調用
    @IBAction func randomButton(_ sender: UIButton) {
        // 隨機選擇服裝圖片並更新到對應的ImageView
        hatImageView.image = UIImage(named: "BoyHat-\(Int.random(in: 1...9))")
        sunglassImageView.image = UIImage(named: "BoySunglass-\(Int.random(in: 1...9))")
        clothesImageView.image = UIImage(named: "BoyClothes-\(Int.random(in: 1...3))")
        pantsImageView.image = UIImage(named: "BoyPants-\(Int.random(in: 1...3))")
        bagImageView.image = UIImage(named: "BoyBag-\(Int.random(in: 1...9))")
        shoesImageView.image = UIImage(named: "BoyShoes-\(Int.random(in: 1...3))")
    }
    
    // 用於初始化屏幕上的UI元素
    func initialScreen () {
        // 設置初始的服裝圖片
        hatImageView.image = UIImage(named: "null")
        sunglassImageView.image = UIImage(named: "null")
        clothesImageView.image = UIImage(named: "BoyClothes-1")
        bagImageView.image = UIImage(named: "null")
        pantsImageView.image = UIImage(named: "BoyPants-1")
        shoesImageView.image = UIImage(named: "null")
        
        itemCategoryButtons[0].isSelected = true
        itemCategoryColorChange(0)
        
        // 顯示body選項
        for i in 0...1{
            itemButtons[i].configuration?.image = UIImage(named: "BoyHat-"+"\(i+1)")
        }
        for e in 2...4{
            itemButtons[e].configuration?.image = UIImage(systemName: "nosign")
        }
        index = 60
    }
}
