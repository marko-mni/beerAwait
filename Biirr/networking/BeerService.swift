//
//  BiirrUITestsLaunchTests.swift
//  BiirrUITests
//
//  Created by Marko Nikolov on 27.1.22.
//

import Foundation
import UIKit

class BeerService: NSObject, BeersServiceProtocol {
    
    func fetchBeers(page: Int) async throws -> [Beer] {
        
        let urlString = "https://api.punkapi.com/v2/beers?page=\(page)&per_page=10"
        guard let url = URL(string: urlString) else {
            throw BeerError.InvalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw BeerError.InvalidResponse
              }
        let beers = try JSONDecoder().decode([BeerModel].self, from: data)
        print("beers downloaded")
        let birs: [Beer] = beers.map {
            guard let url = URL(string: $0.image_url),
                  let imageData = try? Data(contentsOf: url),
                  let image = UIImage(data: imageData) else {
                      print("Image cannot be parsed for \($0.name), showing empty image instead")
                      return Beer(image: UIImage(), beerModel: $0)
                  }
            return (Beer(image: image, beerModel: $0))
        }
        return birs
    }
    
    enum BeerError: Error {
        case InvalidResponse
        case InvalidURL
    }
}
