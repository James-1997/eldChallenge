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
  
  enum CodingKeys: String, CodingKey {
    case title, url, thumbnailUrl
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    url = try container.decode(String.self, forKey: .url)
    thumbnailUrl = try container.decode(String.self, forKey: .thumbnailUrl)
  }
  
  required init (photo: NSManagedObject) {
    title = (photo.value(forKey: "title") as! String)
    thumbnailUrl = (photo.value(forKey: "thumbnailUrl") as! String)
    url = (photo.value(forKey: "url") as! String)
  }
}
