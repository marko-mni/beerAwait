//
//  BiirrUITestsLaunchTests.swift
//  BiirrUITests
//
//  Created by Marko Nikolov on 27.1.22.
//

import UIKit
import Hero

class BeersOverviewViewController: UIViewController, UITableViewDelegate, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    var viewModel = BeersOverviewViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var mainActivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.navTitle
        overrideUserInterfaceStyle = .light
        showActivityIndicatory()
        setupDelegates()
        setupNavBar()
        viewModel.getBeersAndHandleUpdate()
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
        viewModel.searchController = searchController
    }
    
    private func setupNavBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = viewModel.searchPlaceholder
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension BeersOverviewViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.filterContentForSearchText(searchBar.text!)
    }
}

extension BeersOverviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell",
                                                       for: indexPath) as? BeerOverviewCell else {
            print("Error dequeing BeerOverviewCell")
            return UITableViewCell()
        }
        cell.beer = viewModel.beerFor(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetails(for: viewModel.beerFor(indexPath: indexPath))
    }
}

extension BeersOverviewViewController: BeersOverviewDelegate {
    func updateTableView(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.hideMainActivityIndicator()
            self.tableView.tableFooterView = nil
            self.tableView.insertRows(at: indexPaths, with: .fade)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.isPaginating = false
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func displayAlert() {
        DispatchQueue.main.async {
            self.present(self.viewModel.noBeersAlert, animated: true, completion: nil)
        }
    }
}

extension BeersOverviewViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - scrollView.frame.size.height {
            guard !viewModel.isPaginating,
                  !searchController.isActive else { return }
            self.tableView.tableFooterView = createSpinnerFooter()
            viewModel.getBeersAndHandleUpdate()
        }
    }
}

// Activity indicators
extension BeersOverviewViewController {
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        footerView.backgroundColor = .white
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = .black
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func showActivityIndicatory() {
        mainActivityIndicator.isHidden = false
        mainActivityIndicator.color = .black
        mainActivityIndicator.center = self.view.center
        self.view.addSubview(mainActivityIndicator)
        mainActivityIndicator.startAnimating()
    }
    
    func hideMainActivityIndicator() {
        mainActivityIndicator.isHidden = true
    }
}

