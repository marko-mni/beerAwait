//
//  BeersOverviewViewModelTests.swift
//  BiirrTests
//
//  Created by Marko Nikolov on 30.1.22.
//

import XCTest
@testable import Biirr

class BeersOverviewViewModelTests: XCTestCase {
    
    func testFetchBeers() async {
        
        // GIVEN
        let viewModel = BeersOverviewViewModel(service: MockBeerService())
        
        // WHEN
        try! await viewModel.getBeersAndInsertCells()
        
        // THEN
        XCTAssertEqual(viewModel.beers.count, 3)
        XCTAssertEqual(viewModel.beers[0].beerModel.name, "Vice Bier")
        XCTAssertEqual(viewModel.beers[0].beerModel.tagline, "Hoppy Wheat Bier.")
        XCTAssertEqual(viewModel.beers[0].beerModel.description, "Our take on the classic German Kristallweizen. A clear German wheat beer, layers of bubblegum and vanilla perfectly balanced with the American and New Zealand hops.")
        XCTAssertEqual(viewModel.beers[0].beerModel.image_url, "https://images.punkapi.com/v2/keg.png")
        XCTAssertEqual(viewModel.beers[0].beerModel.abv, 4.3)
        XCTAssertEqual(viewModel.beers[0].beerModel.ibu, 25)
        XCTAssertEqual(viewModel.beers[0].bitterness, "Bitter")
        
        XCTAssertEqual(viewModel.beers[1].beerModel.name, "Devine Rebel (w/ Mikkeller)")
        XCTAssertEqual(viewModel.beers[1].beerModel.tagline, "Oak-aged Barley Wine.")
        XCTAssertEqual(viewModel.beers[1].beerModel.description, "Two of Europe's most experimental, boundary-pushing brewers, BrewDog and Mikkeller, combined forces to produce a rebellious beer that combined their respective talents and brewing skills. The 12.5% Barley Wine fermented well, and the champagne yeast drew it ever closer to 12.5%. The beer was brewed with a single hop variety and was going to be partially aged in oak casks.")
        XCTAssertEqual(viewModel.beers[1].beerModel.image_url, "https://images.punkapi.com/v2/22.png")
        XCTAssertEqual(viewModel.beers[1].beerModel.abv, 12.5)
        XCTAssertEqual(viewModel.beers[1].beerModel.ibu, 100)
        XCTAssertEqual(viewModel.beers[1].bitterness, "Hipster Plus")
        
        XCTAssertEqual(viewModel.beers[2].beerModel.name, "Storm")
        XCTAssertEqual(viewModel.beers[2].beerModel.tagline, "Islay Whisky Aged IPA.")
        XCTAssertEqual(viewModel.beers[2].beerModel.description, "Dark and powerful Islay magic infuses this tropical sensation of an IPA. Using the original Punk IPA as a base, we boosted the ABV to 8% giving it some extra backbone to stand up to the peated smoke imported directly from Islay.")
        XCTAssertEqual(viewModel.beers[2].beerModel.image_url, "https://images.punkapi.com/v2/23.png")
        XCTAssertEqual(viewModel.beers[2].beerModel.abv, 8.0)
        XCTAssertEqual(viewModel.beers[2].beerModel.ibu, 60)
        XCTAssertEqual(viewModel.beers[2].bitterness, "Hipster Plus")
        
        
    }
    
    func testBeersAfterFiltering() async {
        
        // GIVEN
        let viewModel = BeersOverviewViewModel(service: MockBeerService())
        
        // WHEN
        try! await viewModel.getBeersAndInsertCells()
        viewModel.filterContentForSearchText("st")
        
        XCTAssertEqual(viewModel.filteredBeers.count, 1)
        
        XCTAssertEqual(viewModel.filteredBeers[0].beerModel.name, "Storm")
        XCTAssertEqual(viewModel.filteredBeers[0].beerModel.tagline, "Islay Whisky Aged IPA.")
        XCTAssertEqual(viewModel.filteredBeers[0].beerModel.description, "Dark and powerful Islay magic infuses this tropical sensation of an IPA. Using the original Punk IPA as a base, we boosted the ABV to 8% giving it some extra backbone to stand up to the peated smoke imported directly from Islay.")
        XCTAssertEqual(viewModel.filteredBeers[0].beerModel.image_url, "https://images.punkapi.com/v2/23.png")
        XCTAssertEqual(viewModel.filteredBeers[0].beerModel.abv, 8.0)
        XCTAssertEqual(viewModel.filteredBeers[0].beerModel.ibu, 60)
        XCTAssertEqual(viewModel.filteredBeers[0].bitterness, "Hipster Plus")
    }
    
    func testBeerForIndex() async {
        // GIVEN
        let viewModel = BeersOverviewViewModel(service: MockBeerService())
        
        // WHEN
        try! await viewModel.getBeersAndInsertCells()
        
        // THEN
        let beer = viewModel.beerFor(indexPath: IndexPath(item: 1, section: 0))
        XCTAssertEqual(beer.beerModel.name, "Devine Rebel (w/ Mikkeller)")
        XCTAssertEqual(beer.beerModel.tagline, "Oak-aged Barley Wine.")
        XCTAssertEqual(beer.beerModel.description, "Two of Europe's most experimental, boundary-pushing brewers, BrewDog and Mikkeller, combined forces to produce a rebellious beer that combined their respective talents and brewing skills. The 12.5% Barley Wine fermented well, and the champagne yeast drew it ever closer to 12.5%. The beer was brewed with a single hop variety and was going to be partially aged in oak casks.")
        XCTAssertEqual(beer.beerModel.image_url, "https://images.punkapi.com/v2/22.png")
        XCTAssertEqual(beer.beerModel.abv, 12.5)
        XCTAssertEqual(beer.beerModel.ibu, 100)
        XCTAssertEqual(beer.bitterness, "Hipster Plus")
    }
}
