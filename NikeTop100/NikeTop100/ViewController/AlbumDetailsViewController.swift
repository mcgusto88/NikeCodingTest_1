//
//  AlbumDetailsViewController.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/28/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    
    private let album : Album?
    private let detailView : AlbumDetailUI?
    
    init(album:Album,detailView:AlbumDetailUI) {
        self.album = album
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        album = nil
        detailView = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album Details"
        self.edgesForExtendedLayout = []
        if let detailView = detailView {
            setupUI(albumDetailView: detailView);
        }
    }
        
    private func setupUI(albumDetailView:AlbumDetailUI) {
        view.backgroundColor = .white
        view.addSubview(albumDetailView)
        
        NSLayoutConstraint.activate([
            albumDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            albumDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let album = album {
            albumDetailView.imageView.loadImageUsingCache(withUrl: album.imageUrl)
            albumDetailView.albumName.text = album.name
            albumDetailView.artistName.text = album.artistName
            albumDetailView.genre.text = album.genresDisplay
            albumDetailView.releaseDate.text = album.releaseDate
            albumDetailView.copyright.text = album.copyright
            albumDetailView.iTunesButton.setTitle("View in iTunes", for: .normal)
            albumDetailView.iTunesButton.addTarget(self, action: #selector(viewInItunes), for: .touchUpInside)
        }
    }
        
    @objc func viewInItunes(button:UIButton) {
        if let album = album , let url = URL(string: album.url) {
            UIApplication.shared.open(url)
        }
    }
}


