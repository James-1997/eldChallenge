//
//  PhotosViewController+DataSource.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

extension PhotosViewController {
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      return UITableViewHeaderFooterView()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
      return photosViewModel.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photosViewModel.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else {
          return UITableViewCell()
      }
      return cell
  }
}
