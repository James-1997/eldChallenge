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
  }
  
  init() {
    photos = []
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    context = appDelegate?.persistentContainer.viewContext
  }
  
  public func converteDataInObject(){
    for photo in photosData {
      let photo = Photo(photo: photo)
      photos.append(photo)
    }
  }
  
  public func saveInCoreData(photo: Photo) {
    guard let context = context else {
      return
    }
    let pictureData = NSEntityDescription.insertNewObject(forEntityName: "Picture", into: context)
    pictureData.setValue(photo.title, forKey: "title")
    pictureData.setValue(photo.thumbnailUrl, forKey: "thumbnailUrl")
    pictureData.setValue(photo.url, forKey: "url")
    do {
      try context.save()
      print("sucess to save data!")
    }catch{
      print("error in save operation!")
    }
  }
  
  public func recoverData() {
    let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: "Picture")
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
        print("Sucess in data recover \n It's \(photosData.count) contities data!")
        converteDataInObject()
      }
    } catch {
      print("Error in data recover!")
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
    }catch{
      print("error in delete operation!")
    }
  }
  
  private func deleteByDataFilter(with photo: Photo){
    guard let context = context else {
      return
    }
    let requisition = NSFetchRequest<NSFetchRequestResult>(entityName: "Picture")
    let filterTitle = NSPredicate(format: "title == %@", photo.title)
    requisition.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [filterTitle])
    do {
      let data = try context.fetch(requisition)
      if data.count != 0 {
        let result = data as! [NSManagedObject]
        context.delete(result[0])
        do {
          print("Deleted")
          try context.save()
        } catch {
          print("Not Deleted")
        }
      }
    } catch  {
      print("error in delete operetion!")
    }
  }
}
