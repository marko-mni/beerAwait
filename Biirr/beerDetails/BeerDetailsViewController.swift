//
//  BeerDetailsViewController.swift
//  Biirr
//
//  Created by Marko Nikolov on 29.1.22.
//

import UIKit

class BeerDetailsViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    var beer: Beer!
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bitternessLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    
    var alcohol: String {
        guard let percetage = beer.beerModel.abv else {
            return "?"
        }
        return String(describing: percetage)
    }
    
    override func viewDidLoad() {
        self.title = ""
        configureView()
        overrideUserInterfaceStyle = .light
    }
    
    private func configureView() {
        self.beerImageView.image = beer.image
        self.backgroundView.backgroundColor = beer.bitternessColor
        self.beerImageView.hero.id = beer.beerModel.tagline
        self.nameLabel.hero.id = beer.beerModel.name
        self.nameLabel.text = beer.beerModel.name
        self.taglineLabel.text = beer.beerModel.tagline
        self.taglineLabel.textColor = beer.bitternessColor
        self.descriptionLabel.text = beer.beerModel.description
        self.bitternessLabel.text = beer.bitterness
        self.bitternessLabel.textColor = beer.bitternessColor
        self.alcoholLabel.text = "\(alcohol)%"
    }
}
