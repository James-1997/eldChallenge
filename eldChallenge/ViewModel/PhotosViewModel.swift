//
//  PhotosViewModel.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

protocol tableViewActionHandle {
  func reloadDataToTableView()
}

class PhotoViewModel {
  
  public let photoManager = PhotoManager.shared
  internal var photos = [Photo]()
  public var tableVCDelegate = PhotosViewController()
  public let photoDataManagerObject = PhotoDataManagerObject.shared
  
  public func fetchPhotos() {
    photos = []
    if photoDataManagerObject.photos.isEmpty {
      DispatchQueue.main.async {
        let photoCollection = self.photoManager.photos
        photoCollection.forEach({ (photo) in
          self.photos.append(photo)
          self.photoDataManagerObject.saveInCoreData(photo: photo)
        })
      }
    } else {
      DispatchQueue.main.async {
        let photoCollection = self.photoDataManagerObject.photos
        photoCollection.forEach({ (photo) in
          self.photos.append(photo)
        })
      }
    }
    tableVCDelegate.reloadDataToTableView()
  }
  
  public func addObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(fetchPhotosToTableView), name: .photosSucess, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(errorFeedback), name: .photosError, object: nil)
  }
  
  @objc func errorFeedback() {
    //MARK: errors operation
  }
  
  @objc func fetchPhotosToTableView() {
    self.fetchPhotos()
  }
}
