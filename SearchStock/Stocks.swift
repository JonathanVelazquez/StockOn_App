//
//  Stocks.swift
//  SearchStock
//
//  Created by Jonathan Velazquez on 11/17/17.
//  Copyright © 2017 Jonathan Velazquez. All rights reserved.
//

import UIKit

class Stocks: Codable {
    let symbol: String
    let name: String
}


class Stock: Codable {
    let symbol: String
    let name: String
    
    init(symbol: String, name: String) {
        self.symbol = symbol
        self.name = name
        
    }
}
