//
//  ViewController.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/27/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import UIKit

typealias AlbumSelectionHandler = ((_ album:Album)->Void)

protocol AlbumListSummaryUI : UIViewController {
    var dataLoader : AlbumsDataLoader { get }
    var selectionHandler : AlbumSelectionHandler { get }
    func getAlbums(count:Int)
}

class AlbumsListViewController: UITableViewController , AlbumListSummaryUI {
    
    private var albums : [Album] = []
    private let numberOfAlbumsToFetch = 100
    internal let dataLoader : AlbumsDataLoader
    internal var selectionHandler: AlbumSelectionHandler
    
    let reuseIdentifier = "albumCell"
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    
    init(dataLoader:AlbumsDataLoader,selectionHandler:@escaping AlbumSelectionHandler) {
        self.dataLoader = dataLoader
        self.selectionHandler = selectionHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupUI()
        getAlbums(count:numberOfAlbumsToFetch)
    }
    
    func setupUI() {
        self.tableView.accessibilityLabel = "Albums List"
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        self.tableView.addSubview(activityIndicator)
        activityIndicator.center=self.tableView.center
        activityIndicator.accessibilityLabel = "Album Loading Indicator"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
        
    func getAlbums(count:Int) {
        activityIndicator.startAnimating()
        dataLoader.getAlbums(count: count) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            switch result {
            case .success(let albums ):
                self.albums = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle:.alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
                break
            }
        }
    }
}

//Tableview datasource
extension AlbumsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : AlbumTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.refreshWith(album: album)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//Tableview delegate
extension AlbumsListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let album = albums[indexPath.row]
           selectionHandler(album)
       }
}

