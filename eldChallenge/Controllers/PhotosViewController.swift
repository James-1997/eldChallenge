//
//  RootViewController.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {
  
  internal var photosViewModel: PhotoViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    commonInit()
    setupPhotosViewModel()
  }
  
  func setupPhotosViewModel() {
    photosViewModel = PhotoViewModel()
    guard let photosVM = photosViewModel else {
      return
    }
    photosVM.tableVCDelegate = self
    photosVM.addObserver()
    photosVM.photoDataManagerObject.recoverData()
    photosVM.photoDataManagerObject.converteDataInObject()
    if photosVM.photoDataManagerObject.photos.isEmpty {
      photosVM.photoManager.getPhotos()
    }
    photosVM.fetchPhotos()
  }
  
  private func commonInit() {
    subviews()
    layout()
    theme()
  }
  
  private func subviews () {
  }
  private func layout () {
  }
  private func theme () {
    view.backgroundColor = StyleKit.Colors.backGroundColor
    title = StyleKit.Texts.titlePhotosView
    tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    tableView.separatorColor = .white //TODO: Change to SK
    tableView.backgroundColor = .white //TODO: Change to SK
    tableView.rowHeight = UITableView.automaticDimension
  }
}

extension PhotosViewController: tableViewActionHandle {
  func reloadDataToTableView() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
