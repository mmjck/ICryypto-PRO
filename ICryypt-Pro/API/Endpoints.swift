//
//  Endpoints.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 17/04/23.
//

import Foundation


enum Endponts {
    case fetchCoins(url: String = "/v1/cryptocurrency/listings/latest")
    // case postCoins(url: String = "/v2/postCoins")
    
    
    var request: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = []
        print(components)
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCoins(let url):
            return url
        }
        
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "CAD"),
                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
            ]
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
           switch self {
           case .fetchCoins:
               return nil
           }
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endponts){
        switch endpoint {
        case .fetchCoins:
            self.setValue("application/json", forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
          
            self.setValue(Constants.API_KEY, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
            
            print(self)
        }
    }
}
