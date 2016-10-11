//
//  MaterialButton.swift
//  devslopes-showcase
//
//  Created by Tobias Gozzi on 06/10/2016.
//  Copyright © 2016 Tobias Gozzi. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 2
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
    }

}
