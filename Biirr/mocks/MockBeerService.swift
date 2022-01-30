//
//  MockBeerService.swift
//  Biirr
//
//  Created by Marko Nikolov on 30.1.22.
//

import UIKit

class MockBeerService: BeersServiceProtocol {
    func fetchBeers(page: Int) async throws -> [Beer] {
        let beerModel1 = BeerModel(name: "Vice Bier", tagline: "Hoppy Wheat Bier.", description: "Our take on the classic German Kristallweizen. A clear German wheat beer, layers of bubblegum and vanilla perfectly balanced with the American and New Zealand hops.", image_url: "https://images.punkapi.com/v2/keg.png", abv: 4.3, ibu: 25)
        let beerModel2 = BeerModel(name: "Devine Rebel (w/ Mikkeller)", tagline: "Oak-aged Barley Wine.", description: "Two of Europe's most experimental, boundary-pushing brewers, BrewDog and Mikkeller, combined forces to produce a rebellious beer that combined their respective talents and brewing skills. The 12.5% Barley Wine fermented well, and the champagne yeast drew it ever closer to 12.5%. The beer was brewed with a single hop variety and was going to be partially aged in oak casks.", image_url: "https://images.punkapi.com/v2/22.png", abv: 12.5, ibu: 100)
        let beerModel3 = BeerModel(name: "Storm", tagline: "Islay Whisky Aged IPA.", description: "Dark and powerful Islay magic infuses this tropical sensation of an IPA. Using the original Punk IPA as a base, we boosted the ABV to 8% giving it some extra backbone to stand up to the peated smoke imported directly from Islay.", image_url: "https://images.punkapi.com/v2/23.png", abv: 8, ibu: 60)
        
      
        return [
            Beer(image: UIImage(), beerModel: beerModel1),
            Beer(image: UIImage(), beerModel: beerModel2),
            Beer(image: UIImage(), beerModel: beerModel3)
        ]
    }
}
