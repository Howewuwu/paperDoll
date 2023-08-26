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
    @IBOutlet var itemCatagoryButtons: [UIButton]!
    
    
    
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet var itemButtons: [UIButton]!
    
    
    @IBOutlet weak var itemScrollViewPageControl: UIPageControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        itemScrollView.delegate = self
        itemScrollView.contentSize = CGSize(width: 750, height: 196)
        itemScrollView.isPagingEnabled = true
        itemScrollViewPageControl.numberOfPages = 2
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
