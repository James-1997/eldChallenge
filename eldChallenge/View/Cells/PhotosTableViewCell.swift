//
//  PhotosTableViewCell.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
  
  private let title = UILabel()
  internal let coverPhoto = UIImageView()
  public var photoViewModel: PhotosViewModel?
  
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
    title.text = ""
    coverPhoto.image = nil
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
  }
  
  public func commonInit() {
      subviews()
      layout()
      theme()
  }
  
  public func subviews() {
    self.addSubview(title)
    self.addSubview(coverPhoto)
  }
  
  public func layout() {
    coverPhoto.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: self.leftAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 40, height: 40, center: (nil, self.centerYAnchor))
  
    title.anchor(top: self.topAnchor, paddingTop: 3, bottom: self.bottomAnchor, paddingBottom: 3, left: self.coverPhoto.rightAnchor, paddingLeft: 6, right: nil, paddingRight: 0, width: 0, height: 0, center: (self.centerXAnchor, self.centerYAnchor))
  }
  
  public func theme() {
    self.backgroundColor = .orange
    title.text = "test Label"
    title.textColor = .blue
    coverPhoto.backgroundColor = .yellow
    coverPhoto.translatesAutoresizingMaskIntoConstraints = false
    title.translatesAutoresizingMaskIntoConstraints = false
//    title.text = photoViewModel?.title
  }
}
