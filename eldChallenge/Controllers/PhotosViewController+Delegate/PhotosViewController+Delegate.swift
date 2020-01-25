//
//  PhotosViewController+Delegate.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

extension PhotosViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailViewController: DetailViewController?
    if let image = photosViewModel?.photos[indexPath.row].detailImage {
      detailViewController = DetailViewController(image: image)
    } else {
      guard let imageUrl = photosViewModel?.photos[indexPath.row].url else {
        return
      }
      detailViewController = DetailViewController(imageUrl: imageUrl)
    }
    guard let detailVC = detailViewController else {
      return
    }
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80 //TODO: Move to SK
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60 //TODO: Move to SK
  }
}
