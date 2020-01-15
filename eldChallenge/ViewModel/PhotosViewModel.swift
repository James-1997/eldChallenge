//
//  PhotosViewModel.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class PhotosViewModel {
  
  private let title: String
  private let url: String
  private let thumbnailUrl: String
  
  init(photo: Photo) {
    self.title = photo.title
    self.url = photo.url
    self.thumbnailUrl = photo.thumbnailUrl
  }
}
