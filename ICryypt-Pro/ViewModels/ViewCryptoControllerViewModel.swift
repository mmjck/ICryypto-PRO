//
//  ViewCryptoControllerViewModel.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 15/04/23.
//

import UIKit

class ViewCryptoControllerViewModel {
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
 
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }
    
    var priveLabel: String {
        return "Price: \(self.coin.pricingData.USD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.USD.market_cap)"
    }
    
    var maxSupplyLabel: String {
        if let maxSupply = self.coin.maxSupply {
            return "Max Supply: \(maxSupply)"
        }
        
        return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
    }

}
