//
//  AutoLayout.swift
//  eldChallenge
//
//  Created by Robson James Junior on 15/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat, center:(NSLayoutXAxisAnchor?,NSLayoutYAxisAnchor?)?) {
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
      if let centerX = center.0 {
        centerXAnchor.constraint(equalTo: centerX).isActive = true
      }
      if let centerY = center.1  {
        centerYAnchor.constraint(equalTo: centerY).isActive = true
      }
    }
  }
  
  func fill(ofThe elememt: UIView?) {
    guard let view = elememt else {
      return
    }
    let centerY = view.centerYAnchor
    let centerX = view.centerXAnchor
    
    self.centerYAnchor.constraint(equalTo: centerY).isActive = true
    
    self.centerXAnchor.constraint(equalTo: centerX).isActive = true
    
    self.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    
    self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0).isActive = true
    
    self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0).isActive = true
    
    self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
  }
}
