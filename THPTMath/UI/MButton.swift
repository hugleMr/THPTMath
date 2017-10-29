//
//  MButton.swift
//  THPTMath
//
//  Created by hung le on 10/28/17.
//  Copyright © 2017 HungLe. All rights reserved.
//

import UIKit

@IBDesignable class MButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor;
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius;
        }
    }
}
