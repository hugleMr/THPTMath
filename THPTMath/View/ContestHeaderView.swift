//
//  ContestHeaderView.swift
//  THPTMath
//
//  Created by hung le on 11/5/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

class ContestHeaderView: UIView {
    @IBOutlet weak var pageControl: UIPageControl!
}

extension ContestHeaderView : ContestPageViewControllerDelegate
{
    func setupPageController(numberOfPages: Int)
    {
        pageControl.numberOfPages = numberOfPages
        pageControl.isHidden = true
    }
    
    func turnPageController(to index: Int)
    {
        pageControl.currentPage = index
    }
}
