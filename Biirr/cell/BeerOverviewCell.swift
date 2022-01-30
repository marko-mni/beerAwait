//
//  BeerOverviewCell.swift
//  Biirr
//
//  Created by Marko Nikolov on 29.1.22.
//

import UIKit

class BeerOverviewCell: UITableViewCell {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    var beer: Beer? {
        didSet {
            self.taglineLabel.text =  beer?.beerModel.tagline
            self.nameLabel.text = beer?.beerModel.name
            self.nameLabel.hero.id = beer?.beerModel.name
            self.beerImageView.image = beer?.image
            self.beerImageView.hero.id = beer?.beerModel.tagline
            self.colorView.backgroundColor = beer?.bitternessColor
        }
    }
}
