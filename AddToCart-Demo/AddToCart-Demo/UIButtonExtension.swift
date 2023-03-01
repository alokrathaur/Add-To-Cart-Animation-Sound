//
//  UIButtonExtension.swift
//  AddToCart-Demo
//
//  Created by Alok Rathaur on 01/03/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func shakeButton() {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -8.0, 8.0, -5.0, 5.0, 0.0]
        //button.layer.add(animation, forKey: "position")
        self.layer.add(animation, forKey: "position")
    }
}
