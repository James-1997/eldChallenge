//
//  RootViewController.swift
//  eldChallenge
//
//  Created by Robson James Junior on 14/01/20.
//  Copyright © 2020 robsonJames. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {
  
  internal var photosViewModel = [PhotosViewModel]()
  private let photoManager = PhotoManager.shared
  override func viewDidLoad() {
    super.viewDidLoad()
    commonInit()
    photoManager.getPhotos()
    fetchPhotos()
    addObsercer()
  }
  
  private func addObsercer() {
    NotificationCenter.default.addObserver(self, selector: #selector(fetchPhotosToTableView), name: .photosSucess, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(error), name: .photosError, object: nil)
  }
  
  @objc func error() {
    //MARK: errors operation
  }
  private func fetchPhotos() {
    photosViewModel = []
    let photos = photoManager.photos
    photos.forEach({ (photo) in
      let photoVM = PhotosViewModel(photo: photo)
      photosViewModel.append(photoVM)
    })
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  @objc func fetchPhotosToTableView() {
    fetchPhotos()
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
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    tableView.separatorColor = .white
    tableView.backgroundColor = .systemGray
    tableView.rowHeight = UITableView.automaticDimension
  }
}
