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

class PhotoDataManagerObject {
  internal enum CoreData: String {
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
  
  internal enum CoreDataEntity: String {
    case picture
    
    var name: String {
      switch self {
        case .picture:
          return "Picture"
      }
    }
  }
  
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
  
  public func saveInCoreData(photo: Photo) {
    guard let context = context else {
      return
    }
    let pictureData = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntity.picture.name, into: context)
    pictureData.setValue(photo.title, forKey: CoreData.title.Key)
    pictureData.setValue(photo.thumbnailUrl, forKey:  CoreData.thumbnailUrl.Key)
    pictureData.setValue(photo.url, forKey:  CoreData.url.Key)
    //MARK: Download Image and Convert in Data to placeHolderImage and DetailImage
    
    do {
      try context.save()
      print("sucess to save data!")
    } catch {
      let error = error as NSError
      print("error in save operation! \n erro: \(error), description: \(error.localizedDescription), userInfo: \(error.userInfo)")
    }
  }
  
  public func recoverData() {
    let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntity.picture.name)
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
        converteDataInObject()
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
    do {
      try context.save()
      print("sucess in delete operation!")
    } catch {
      let error = error as NSError
      print("error in delete operation! \n erro: \(error), description: \(error.localizedDescription), userInfo: \(error.userInfo)")
    }
  }
  
  private func deleteByDataFilter(with filterType: FilterType, filterData: String) {
    guard let context = context else {
      return
    }
    let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntity.picture.name)
    let resultData = NSPredicate(format: filterType.value, filterData)
    requisition.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [resultData])
    do {
      let data = try context.fetch(requisition)
      if data.count != 0 {
        let result = data as! [NSManagedObject]
        context.delete(result[0])
        do {
          print("Deleted")
          try context.save()
        } catch {
          let error = error as NSError
          print("Not Deleted \n erro: \(error), description: \(error.localizedDescription), userInfo: \(error.userInfo)")
        }
      }
    } catch {
      let error = error as NSError
      print("error in delete operetion! \n erro: \(error)")
    }
  }
}
