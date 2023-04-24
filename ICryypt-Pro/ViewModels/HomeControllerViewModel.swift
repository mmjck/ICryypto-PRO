//
//  HomeControllerViewModel.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 21/04/23.
//

import Foundation

class HomeControllerViewModel {
    
    var onCoinsUpdated: (() -> Void)?
    var onErrorMessage: ((CoinServiceError) -> Void)?
    
    
    private (set) var coins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    init(){
        self.fetchCoins()
    }
    
    public func fetchCoins(){
        let endpoint = Endponts.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint){ [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
                print(coins)
            case .failure(let error):
                print(error)
                self?.onErrorMessage?(error)
            }
             
        }
    }
}
