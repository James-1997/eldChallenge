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
  private var emptyLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    photoImageView.image = nil
    emptyLabel = nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.photoImageView.backgroundColor = .white
    setImageInBackgroundView()
  }
  
  convenience init(image: UIImage?) {
    self.init()
    if let photo = image {
      self.photo = photo
    } else {
      photoImageView.backgroundColor = .white //TODO: change to SK
      emptyLabel = UILabel()
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
    if let emptyLabel = self.emptyLabel {
      self.view.addSubview(emptyLabel)
    }
  }
  
  private func layout() {
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    photoImageView.fill(ofThe: self.view)
    if let emptyLabel = self.emptyLabel {
      emptyLabel.anchor(top: nil, paddingTop: 0, bottom: self.view.bottomAnchor, paddingBottom: 150, left: self.view.leftAnchor, paddingLeft: 16, right: self.view.rightAnchor, paddingRight: 16, width: 0, height: 0, center: (self.view.centerXAnchor, nil))
    }
  }
  private func theme() {
    title = "Detalhes" //TODO: move to SK
    setImageInBackgroundView()
    if let emptyLabel = self.emptyLabel {
      emptyLabel.text = "Error, sem Imagem!" //TODO: move to SK
      emptyLabel.textAlignment = .center
      emptyLabel.font = UIFont.boldSystemFont(ofSize: 35)
    }
  }
  
  private func setImageInBackgroundView() {
    if let photo = self.photo {
      photoImageView.image = photo
    } else {
      photoImageView.image = UIImage(named: "ErrorDetailPhoto") //TODO: Move to SK
    }
  }
}

