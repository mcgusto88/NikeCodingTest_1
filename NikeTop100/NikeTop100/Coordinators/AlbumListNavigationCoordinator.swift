//
//  AlbumListDisplayCoordinator.swift
//  NikeTop100
//
//  Created by Augustus Wilson on 6/28/20.
//  Copyright © 2020 Augustus Wilson. All rights reserved.
//

import UIKit

protocol NavigationCoordinator {
    func getInitialViewController() -> UINavigationController;
}

class AlbumListNavigationCoordinator : NavigationCoordinator {
        
    func getInitialViewController() -> UINavigationController {
        let navigationController = UINavigationController()
        let urlSession = URLSession(configuration: .default)
        let albumDataLoader = RemoteAlbumsLoader(networkClient: URLSessionNetworkClient(urlSession:urlSession) ,jsonDecoder: JSONDecoder())
        let listViewController = AlbumsListViewController(dataLoader: albumDataLoader) { [weak self] album in
            guard let self = self else {return}
            let detailsViewController = self.getDetailsViewController(album: album)
            navigationController.pushViewController(detailsViewController, animated: true)
        }
        listViewController.title = "Albums"
        navigationController.viewControllers = [listViewController];
        navigationController.navigationBar.isTranslucent = false
        return navigationController;
    }
    
    private func getDetailsViewController(album:Album) -> AlbumDetailsViewController {
        let detailsView = AlbumDetailView()
        let detailsViewController = AlbumDetailsViewController(album: album, detailView: detailsView)
        return detailsViewController
    }

    deinit {
        print("deinit")
    }

}



