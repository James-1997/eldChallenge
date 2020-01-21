//
//  PhotosViewModel.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class PhotosViewModel {
  
  public let title: String
  public let url: String
  public let thumbnailUrl: String
  public var detailImage: UIImage? //TODO: To use in cache with CoreData
  
  init(photo: Photo) {
    self.title = photo.title
    self.url = photo.url
    self.thumbnailUrl = photo.thumbnailUrl
  }
}
