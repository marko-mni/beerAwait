//
//  MainCoordinator.swift
//  Biirr
//
//  Created by Marko Nikolov on 29.1.22.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.overrideUserInterfaceStyle = .light
    }
    
    func start() {
        let vc = BeersOverviewViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetails(for beer: Beer) {
        let vc = BeerDetailsViewController.instantiate()
        vc.coordinator = self
        vc.beer = beer
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
