//
//  BiirrUITestsLaunchTests.swift
//  BiirrUITests
//
//  Created by Marko Nikolov on 27.1.22.
//

import Foundation
import UIKit

struct Beer {
    let image: UIImage
    let beerModel: BeerModel
    
    init(image: UIImage, beerModel: BeerModel) {
        self.image = image
        self.beerModel = beerModel
    }
}

struct BeerModel: Codable {
    let name: String
    let tagline: String
    let description: String
    let image_url: String
    let abv: Float?
    let ibu: Float?
}

extension Beer {
    var bitterness: String {
        guard let ibu = beerModel.ibu else { return "Unknown" }
        if ibu <= 20 { return "Smooth" }
        else if ibu <= 50 { return "Bitter" }
        else { return "Hipster Plus" }
    }
    
    var bitternessColor: UIColor {
        guard let ibu = beerModel.ibu else { return UIColor(red: 128/255, green: 166/255, blue: 172/255, alpha: 1) }
        if ibu <= 20 { return UIColor(red: 128/255, green: 200/255, blue: 97/255, alpha: 1) }
        else if ibu <= 50 { return UIColor(red: 242/255, green: 169/255, blue: 80/255, alpha: 1) }
        else { return UIColor(red: 221/255, green: 103/255, blue: 97/255, alpha: 1) }
    }
}




