//
//  BiirrUITestsLaunchTests.swift
//  BiirrUITests
//
//  Created by Marko Nikolov on 29.1.22.
//

import Foundation
import UIKit

protocol BeersServiceProtocol {
    func fetchBeers(page: Int) async throws -> [Beer]
}

protocol BeersOverviewDelegate: AnyObject {
    func updateTableView(at indexPaths: [IndexPath])
    func reloadTableView()
    func displayAlert()
}

class BeersOverviewViewModel {
    
    private let service: BeersServiceProtocol
    weak var delegate: BeersOverviewDelegate?
    var searchController: UISearchController?
    
    var beers: [Beer] = []
    var filteredBeers: [Beer] = []
    var page = 1
    var isPaginating = false
    
    let navTitle = "BiiRR"
    let searchPlaceholder = "Search Biirrs"
    
    var isSearchBarEmpty: Bool {
        searchController?.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        searchController?.isActive ?? true && !isSearchBarEmpty
    }
    var numberOfRows: Int {
        isFiltering ? filteredBeers.count : beers.count
    }
    var noBeersAlert: UIAlertController {
        let alert = UIAlertController(title: "Error occurred", message: "Couldn't fetch any beers.",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.isPaginating = false
            }}))
        return alert
    }
    
    init(service: BeersServiceProtocol = BeerService()) {
        self.service = service
    }
    
    func getBeersAndHandleUpdate() {
        Task {
            do {
                try await getBeersAndInsertCells()
            } catch let error {
                print(error)
                delegate?.displayAlert()
            }
        }
    }
    
    func getBeersAndInsertCells() async throws {
        self.isPaginating = true
        let newBeers = try await service.fetchBeers(page: page)
        beers += newBeers
        let indexPaths = (self.beers.count - newBeers.count ..< self.beers.count).map {
            IndexPath(row: $0, section: 0)
        }
        page += 1
        delegate?.updateTableView(at: indexPaths)
    }
    
    func beerFor(indexPath: IndexPath) -> Beer {
        isFiltering ? filteredBeers[indexPath.row] :  beers[indexPath.row]
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBeers = beers.filter { (beer: Beer) -> Bool in
            return beer.beerModel.name.lowercased().contains(searchText.lowercased())
        }
        delegate?.reloadTableView()
    }
}
