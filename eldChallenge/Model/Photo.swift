//
//  Photo.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit
import CoreData

class Photo: Decodable {
  public let title: String
  public let url: String
  public let thumbnailUrl: String
  public var detailImage: UIImage?
  public var placeHolderImage: UIImage?
  
  enum CodingKeys: String, CodingKey {
    case title, url, thumbnailUrl
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    url = try container.decode(String.self, forKey: .url)
    thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
    downloadDetailImage()
    downloadPlaceHolder()
  }
  
  required init (photo: NSManagedObject) {
    title = (photo.value(forKey: "title") as! String)
    thumbnailUrl = (photo.value(forKey: "thumbnailUrl") as! String)
    url = (photo.value(forKey: "url") as! String)
    downloadDetailImage()
    downloadPlaceHolder()
  }
  
  private func downloadDetailImage() {
    RestUtils.getImageData(from: url, completion: { data, error, _ in
      if let data = data {
        guard let image = UIImage(data: data) else { return }
        self.detailImage = image
      } else if let err = error {
        print("error in DetailImage Download:\(err.description)")
      }
    })
  }
  
  private func downloadPlaceHolder() {
    RestUtils.getImageData(from: thumbnailUrl, completion: { data, error, _ in
      if let data = data {
        guard let image = UIImage(data: data) else { return }
        self.placeHolderImage = image
      } else if let err = error {
        print("error in PlaceHolder Download:\(err.description)")
      }
    })
  }
}

//class Photo: NSManagedObject, Decodable {
//  @NSManaged public var title: String?
//  @NSManaged public var url: String?
//  @NSManaged public var thumbnailUrl: String?
//  @NSManaged public var detailImageData: NSData?
//  @NSManaged public var placeHolderImageData: NSData?
//  public var detailImage: UIImage?
//  public var placeHolderImage: UIImage?
//
//  @NSManaged var id: UUID
//
//  enum CodingKeys: String, CodingKey {
//    case title, url, thumbnailUrl
//  }
//
//  required convenience init(from decoder: Decoder) throws {
//    guard let context = PhotoDataManagerObject.shared.context else { fatalError() }
//    guard let entity = NSEntityDescription.entity(forEntityName: CoreDataEntity.Picture.name, in: context) else { fatalError() }
//
//    self.init(entity: entity, insertInto: nil)
//
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    title = try container.decode(String.self, forKey: .title)
//    url = try container.decode(String.self, forKey: .url)
//    thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
//    downloadDetailImage()
//    downloadPlaceHolder()
//  }
//
//  private func downloadDetailImage() {
//    guard let url = url else {
//      return
//    }
//    RestUtils.getImageData(from: url, completion: { data, error, _ in
//      if let data = data {
//        guard let image = UIImage(data: data) else {
//          return
//        }
//        self.detailImage = image
//      } else if let err = error {
//        print("error in DetailImage Download:\(err.description)")
//      }
//    })
//  }
//
//  private func downloadPlaceHolder() {
//    guard let thumbnailUrl = thumbnailUrl else {
//      return
//    }
//    RestUtils.getImageData(from: thumbnailUrl, completion: { data, error, _ in
//      if let data = data {
//        guard let image = UIImage(data: data) else {
//          return
//        }
//        self.placeHolderImage = image
//      } else if let err = error {
//        print("error in PlaceHolder Download:\(err.description)")
//      }
//    })
//  }
//}
