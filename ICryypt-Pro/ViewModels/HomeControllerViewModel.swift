//
//  HomeControllerViewModel.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 21/04/23.
//

import Foundation
import UIKit

class HomeControllerViewModel {
    
    var onCoinsUpdated: (() -> Void)?
    var onErrorMessage: ((CoinServiceError) -> Void)?
    
    
    private var inSearchMode: Bool = false
    
    var coins : [Coin] {
        return self.inSearchMode ? filterCoins: allCoins
    }
    
    private (set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
   
    private (set) var filterCoins: [Coin] = [] {
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
                self?.allCoins = coins
                print(coins)
            case .failure(let error):
                print(error)
                self?.onErrorMessage?(error)
            }
        }
    }
}

extension HomeControllerViewModel {
    public func inSearchMode(_ searchController: UISearchController) {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        self.inSearchMode = isActive && !searchText.isEmpty
    }
    
    public func updatSearchController(searchBarText: String?){
        
        self.filterCoins = allCoins
        
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
            
            self.filterCoins = self.allCoins.filter({
                $0.name.lowercased().contains(searchText)
            })
            
            self.onCoinsUpdated?()
        }
    }
}
