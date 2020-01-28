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

class CoreDataManagerObject {
  
  internal enum StatusInCoreData {
    case recoverError
    case recoverSucess
    case notPersistenceData
    case fetchError
    
    var description: String {
      switch self {
        case .recoverError:
          return "Error in data recover!"
        case .notPersistenceData:
          return "You don't have data in Persistence"
        case .fetchError:
          return "error in fetch operetion!"
        case .recoverSucess:
          return "Sucess in data recover! It's %d objects in persistence!"
      }
    }
  }
  
  internal let appDelegate: AppDelegate?
  internal var context: NSManagedObjectContext?
  
  public var photos = [Photo]()
  private var photosData = [NSManagedObject]()
  
  private static var privateShared: CoreDataManagerObject?
  
  class var shared: CoreDataManagerObject {
    guard let uwShared = privateShared else {
      privateShared = CoreDataManagerObject()
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
  
  private func converteDataInObject(){
    for photo in photosData {
      let photo = Photo(photo: photo)
      photos.append(photo)
    }
  }
  
  public func saveObjectInCoreData(object: Any, entity: CoreDataEntity = .Picture) {
    guard let context = context else {
      return
    }
    let coreDataObject = NSEntityDescription.insertNewObject(forEntityName: entity.name, into: context)
    
    if let photo = object as? Photo {
      coreDataObject.setValue(photo.title,
                           forKey: PhotoAttributes.title.Key)
      coreDataObject.setValue(photo.thumbnailUrl,
                           forKey:  PhotoAttributes.thumbnailUrl.Key)
      coreDataObject.setValue(photo.url,
                           forKey: PhotoAttributes.url.Key)
    } else { return }
    appDelegate?.saveContext(operationName: .save)
  }
  
  public func recoverData(entityName: CoreDataEntity) {
    guard let context = context else {
      return
    }
    let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.name)
    if entityName == .Picture {
      pictureFetch(context: context, requisition: requisition)
    }
  }
  
  private func pictureFetch(context: NSManagedObjectContext, requisition: NSFetchRequest<NSFetchRequestResult>) {
    do {
           let photosDt = try context.fetch(requisition)
           self.photosData = []
           if !photosDt.isEmpty {
             for pht in photosDt as! [NSManagedObject] {
               self.photosData.append(pht)
             }
           }
           if !self.photosData.isEmpty {
             let sucessMessage = String(format: StatusInCoreData.recoverSucess.description,
                                        photosData.count)
             statusDescription(status: sucessMessage)
             converteDataInObject()
           } else {
             statusDescription(status: StatusInCoreData.notPersistenceData.description)
           }
         } catch {
           let error = error as NSError
           statusDescription(status: StatusInCoreData.recoverError.description, error: error)
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
      statusDescription(status: StatusInCoreData.fetchError.description, error: error)
    }
    return nil
  }
}

extension CoreDataManagerObject {
  public func statusDescription(status: String, error: NSError? = nil) {
    if let error = error {
      print(String(format: .statusError, status.description, error, error.localizedDescription, error.userInfo))
    } else {
      print(String(format: .format, status.description))
    }
  }
}
