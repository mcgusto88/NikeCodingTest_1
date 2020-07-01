//
//  AlbumCell.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/28/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import UIKit

protocol AlbumSummaryUICell : UIView {
    var albumImage: UIImageView { get }
    var albumName: UILabel { get }
    var artistName : UILabel { get }

    func setupContraints()
    func refreshWith(album:Album)
}


class AlbumTableViewCell: UITableViewCell , AlbumSummaryUICell   {
    
    internal let albumImage : UIImageView = {
        let imageView =  UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "Album Image"
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.backgroundColor = .lightGray;
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView;
    }()
    
    internal let albumName : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Album Name"
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 18.0)
        label.numberOfLines = 0
        return label;
    }()
    
    internal let artistName : UILabel  = {
        let label  =  UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.accessibilityIdentifier = "Artist Name"
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 16.0)
        label.textColor = .gray
        return label;
    }()
    
    private var placeholderView : UIStackView =   {
        let view =  UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupContraints();
        accessoryType = .disclosureIndicator
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupContraints();
        accessoryType = .disclosureIndicator
    }
        
    internal func setupContraints() {
        addSubview(albumImage)
        addSubview(placeholderView)
        placeholderView.addArrangedSubview(albumName)
        placeholderView.addArrangedSubview(artistName)

        NSLayoutConstraint.activate([
            albumImage.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            albumImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8),
            albumImage.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
            albumImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo:self.topAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor,constant: 8),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    internal func refreshWith(album: Album) {
        albumName.text = album.name
        artistName.text = album.artistName
        albumImage.loadImageUsingCache(withUrl: album.imageUrl)
    }
}
