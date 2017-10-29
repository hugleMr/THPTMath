//
//  MView.swift
//  THPTMath
//
//  Created by hung le on 10/28/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

@IBDesignable class MView: UIView {
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func setup() {
        self.layer.cornerRadius = cornerRadius
    }
}
