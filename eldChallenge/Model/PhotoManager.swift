//
//  PhotoManager.swift
//  eldChallenge
//
//  Created by Robson James Junior on 15/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation

class PhotoManager {
  private static var privateShared: PhotoManager?
  private(set) var photos: [Photo]
  
  class var shared: PhotoManager {
    guard let uwShared = privateShared else {
      privateShared = PhotoManager()
      return privateShared!
    }
    return uwShared
  }
  
  class func destroy() {
    privateShared = nil
  }
  
  private init() {
    photos = []
  }
  
  public func getPhotos() {
    RestUtils.getPhotos { (photos, err) in
      if err != nil {
        NotificationCenter.default.post(name: .photosError, object: nil)
      } else {
        self.photos.removeAll()
        guard let photos = photos else {
          self.photos = []
          return
        }
        self.photos = photos
        NotificationCenter.default.post(name: .photosSucess, object: photos)
      }
    }
  }
}
