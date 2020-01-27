//
//  PhotoDataManagerObject.swift
//  eldChallenge
//
//  Created by Robson James Junior on 24/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum FilterType: String {
  case title
  case url
  case thumbnailUrl
  
  var value: String {
    switch self {
      case .title:
        return "title == %@"
      case .url:
        return "url == %@"
      case .thumbnailUrl:
        return "thumbnailUrl == %@"
    }
  }
}

enum CoreDataEntity: String {
  case Picture
  
  var name: String {
    switch self {
      case .Picture:
        return "Picture"
    }
  }
}

enum PhotoAttributes: String {
  case title
  case url
  case thumbnailUrl
  case placeHolderImage
  case detailImage
  
  var Key: String {
    switch self {
      case .title:
        return "title"
      case .url:
        return "url"
      case .thumbnailUrl:
        return "thumbnailUrl"
      case .placeHolderImage:
        return "smallImage"
      case .detailImage:
        return "detailImage"
    }
  }
}

class PhotoDataManagerObject {
  
  internal let appDelegate: AppDelegate?
  internal var context: NSManagedObjectContext?
  
  public var photos = [Photo]()
  private var photosData = [NSManagedObject]()
  
  private static var privateShared: PhotoDataManagerObject?
  
  class var shared: PhotoDataManagerObject {
    guard let uwShared = privateShared else {
      privateShared = PhotoDataManagerObject()
      return privateShared!
    }
    return uwShared
  }
  
  class func destroy() {
    privateShared = nil
    privateShared?.context?.reset()
  }
  
  init() {
    photos = []
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    context = appDelegate?.persistentContainer.viewContext
  }
  
  public func converteDataInObject(){
    for photo in photosData {
      let photo = Photo(photo: photo)
      //MARK: Convert Data in Image to placeHolderImage and DetailImage
      photos.append(photo)
    }
  }
  
  public func savePhotoInCoreData(photo: Photo, entity: CoreDataEntity = .Picture) {
    guard let context = context else {
      return
    }
    let pictureData = NSEntityDescription.insertNewObject(forEntityName: entity.name, into: context)
    
    pictureData.setValue(photo.title,
                         forKey: PhotoAttributes.title.Key)
    pictureData.setValue(photo.thumbnailUrl,
                         forKey:  PhotoAttributes.thumbnailUrl.Key)
    pictureData.setValue(photo.url,
                         forKey: PhotoAttributes.url.Key)
    appDelegate?.saveContext(operationName: .save)
  }
  
  public func recoverData(entityName: CoreDataEntity) {
    let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.name)
    do {
      guard let context = context else {
        return
      }
      let photosDt = try context.fetch(requisition)
      self.photosData = []
      if !photosDt.isEmpty {
        for pht in photosDt as! [NSManagedObject] {
          self.photosData.append(pht)
        }
      }
      if !self.photosData.isEmpty {
        print("Sucess in data recover! \n It's \(photosData.count) objects in persistence!")
//        converteDataInObject()
      } else {
        print("You don't have data in Persistence")
      }
    } catch {
      let error = error as NSError
      print("Error in data recover! \n erro: \(error), description: \(error.localizedDescription), userInfo: \(error.userInfo)")
    }
  }
  
  private func deleteByObject(element: NSManagedObject) {
    guard let context = context else {
      return
    }
    context.delete(element)
    appDelegate?.saveContext(operationName: .delete)
  }
  
  private func deleteByDataFilter(with filterType: FilterType, filterData: String, entityName: CoreDataEntity) {
    guard let context = context else {
      return
    }
    guard let element = filterInCoreData(entityName: entityName, with: filterType, the: filterData, context: context) else { return }
    context.delete(element)
    appDelegate?.saveContext(operationName: .delete)
  }
  
  private func filterInCoreData(entityName: CoreDataEntity, with filterType: FilterType,the attributeKey: String, context: NSManagedObjectContext) -> NSManagedObject? {
    let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.name)
    let resultData = NSPredicate(format: filterType.value, attributeKey)
    requisition.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [resultData])
    do {
      let data = try context.fetch(requisition)
      if data.count != 0 {
        let result = data as! [NSManagedObject]
        return result.first
      }
    } catch {
      let error = error as NSError
      print("error in fetch to delete operetion! \n erro: \(error)")
      return nil
    }
    return nil
  }
}
