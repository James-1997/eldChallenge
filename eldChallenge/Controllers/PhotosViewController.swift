//
//  RootViewController.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {
  
  internal var photosViewModel = [PhotosViewModel]()
  
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
    view.backgroundColor = StyleKit.Colors.backGroundColor
    title = StyleKit.Texts.titlePhotosView
  }
}
