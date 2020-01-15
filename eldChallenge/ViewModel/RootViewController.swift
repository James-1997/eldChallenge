//
//  RootViewController.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    commonInit()
  }
  
  private func commonInit() {
      subviews()
      layout()
      theme()
  }
  
  private func subviews () {
    
  }
  private func layout () {
    
  }
  private func theme () {
    view.backgroundColor = .red
    title = "Jamess"
  }
}
