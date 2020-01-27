//
//  DetailViewController.swift
//  eldChallenge
//
//  Created by Robson James Junior on 20/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  internal var photoImageView = UIImageView()
  private var photo: UIImage?
  private var photoUrl: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    photoImageView.image = nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setImageInBackgroundView()
  }
  
  convenience init(image: UIImage?) {
    self.init()
    if let photo = image {
      self.photo = photo
    } else {
      photoImageView.backgroundColor = .white //TODO: change to SK
    }
    commonInit()
  }
  
  private func commonInit() {
    subviews()
    layout()
    theme()
  }
  
  private func subviews() {
    self.view.addSubview(photoImageView)
  }
  
  private func layout() {
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    photoImageView.fill(ofThe: self.view)
  }
  private func theme() {
    title = "Detalhes" //TODO: move to SK
    setImageInBackgroundView()
  }
  
  private func setImageInBackgroundView() {
    if let photo = self.photo {
      photoImageView.image = photo
    } else {
      photoImageView.backgroundColor = .white //TODO: Move to SK
    }
  }
}

