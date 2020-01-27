//
//  PhotosTableViewCell.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
  
  private let titleLabel = UILabel()
  internal let coverPhoto = UIImageView()
  public var photo: Photo? {
    didSet {
      if let title = photo?.title {
        self.titleLabel.text = title
      }
      if let detailImage = photo?.detailImage {
        self.coverPhoto.image = detailImage
      }
    }
  }
  
  public static let identifier: String = "PhotosTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: PhotosTableViewCell.identifier)
    commonInit()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
    coverPhoto.image = nil
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func commonInit() {
    subviews()
    layout()
    theme()
  }
  
  private func subviews() {
    self.addSubview(titleLabel)
    self.addSubview(coverPhoto)
  }
  
  private func layout() {
    coverPhoto.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.leftAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 60, height: 60, center: (nil, self.centerYAnchor))
    
    titleLabel.anchor(top: self.topAnchor, paddingTop: 3, bottom: self.bottomAnchor, paddingBottom: 3, left: self.coverPhoto.rightAnchor, paddingLeft: 6, right: nil, paddingRight: 0, width: 0, height: 0, center: (self.centerXAnchor, self.centerYAnchor))
  }
  
  private func theme() {
    self.backgroundColor = .white //TODO: Change to SK
    titleLabel.textColor = .black //TODO: Change to SK
    titleLabel.font = .boldSystemFont(ofSize: 16) //TODO: Change to SK
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    coverPhoto.translatesAutoresizingMaskIntoConstraints = false
    coverPhoto.layer.masksToBounds = true
    coverPhoto.layer.cornerRadius = 8 //TODO: Change to SK
  }
}
