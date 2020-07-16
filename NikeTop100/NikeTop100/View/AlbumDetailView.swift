//
//  AlbumDetailView.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/28/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import UIKit

protocol AlbumDetailUI : UIView {
    var imageView: UIImageView { get }
    var placeholderView : UIView { get }
    var albumName: UILabel { get }
    var artistName : UILabel { get }
    var genre : UILabel { get }
    var releaseDate : UILabel { get }
    var copyright : UILabel { get }
    var iTunesButton : UIButton { get }
    
    func setupContraints()
}

class AlbumDetailView : UIView,AlbumDetailUI {
    let imageView : UIImageView = {
        let imageView =  UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "Album Image"
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.backgroundColor = .lightGray;
        return imageView;
    }()
    
    let placeholderView : UIView =   {
        let view =  UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }()
    
    let albumName : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Album Name"
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 20.0)
        label.numberOfLines = 0
        return label;
    }()
    
    let artistName : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Artist Name"
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 16.0)
        label.textColor = .blue
        return label;
    }()
    
    let genre : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.accessibilityIdentifier = "Genre"
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 14.0)
        return label;
    }()
    
    let releaseDate : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.accessibilityIdentifier = "Release Date"
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 14.0)
        return label;
    }()
    
    let copyright : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.accessibilityIdentifier = "Copyright"
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.init(name: "AvenirNext-DemiBold", size: 12.0)
        label.textColor = .gray
        label.numberOfLines = 0
        return label;
    }()
    
    let iTunesButton : UIButton  = {
        let button  =  UIButton(frame: .zero)
        button.accessibilityIdentifier = "View In iTunes"
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.titleLabel?.font = UIFont.init(name: "AvenirNext-DemiBold", size: 18.0)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        return button;
    }()
    
    internal func setupContraints() {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(imageView)
        self.addSubview(placeholderView)
        placeholderView.addSubview(iTunesButton)
        placeholderView.addSubview(albumName)
        placeholderView.addSubview(artistName)
        placeholderView.addSubview(genre)
        placeholderView.addSubview(releaseDate)
        placeholderView.addSubview(copyright)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo:imageView.bottomAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            albumName.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor,constant: 8),
            albumName.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor,constant: -8),
            albumName.topAnchor.constraint(equalTo: placeholderView.topAnchor, constant:8),
        ])
        
        NSLayoutConstraint.activate([
            artistName.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor,constant: 8),
            artistName.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor,constant: -8),
            artistName.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant:8),
        ])
        
        NSLayoutConstraint.activate([
            genre.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor,constant: 8),
            genre.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor,constant: -8),
            genre.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant:8),
        ])
        
        NSLayoutConstraint.activate([
            releaseDate.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor,constant: 8),
            releaseDate.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor,constant: -8),
            releaseDate.topAnchor.constraint(equalTo: genre.bottomAnchor, constant:8),
        ])
        
        
        NSLayoutConstraint.activate([
            copyright.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor,constant: 8),
            copyright.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor,constant: -8),
            copyright.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant:8),
        ])
        
        
        NSLayoutConstraint.activate([
            iTunesButton.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant:20),
            iTunesButton.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant:-20),
            iTunesButton.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor, constant:-20),
            iTunesButton.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor)
        ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContraints();
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
