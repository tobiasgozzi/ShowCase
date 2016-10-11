//
//  MaterialTextField.swift
//  devslopes-showcase
//
//  Created by Tobias Gozzi on 06/10/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR / 255, green: SHADOW_COLOR / 255, blue: SHADOW_COLOR / 255, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
    }
    
    //for Plaxceholder
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    //For editable Text
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}
