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
    coverPhoto.anchor(top: self.topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: self.leadingAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 40, height: 40, center: nil)
  
    title.anchor(top: self.topAnchor, paddingTop: 10, bottom: self.bottomAnchor, paddingBottom: 10, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0, center: (self.centerXAnchor, self.centerYAnchor))
  }
  
  public func theme() {
    coverPhoto.translatesAutoresizingMaskIntoConstraints = false
    title.translatesAutoresizingMaskIntoConstraints = false
  }
}
