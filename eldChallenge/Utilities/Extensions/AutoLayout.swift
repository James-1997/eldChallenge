//
//  AutoLayout.swift
//  eldChallenge
//
//  Created by Robson James Junior on 15/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat, center:(NSLayoutXAxisAnchor,NSLayoutYAxisAnchor)?) {
    translatesAutoresizingMaskIntoConstraints = false
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    if width != 0 {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    if height != 0 {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    if let center = center {
      centerXAnchor.constraint(equalTo: center.0).isActive = true
      centerYAnchor.constraint(equalTo: center.1).isActive = true
    }
  }
}
