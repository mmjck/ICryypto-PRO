//
//  CoinService.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 18/04/23.
//

import Foundation


enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknow error ocurred")
    case decodinfError(String = "Error parsing server")
}

enum CoinService {
    static func fetchCoins(with endpoint: Endponts, completion: @escaping (Result<[Coin], CoinServiceError>) -> Void){
  
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) {
            data, resp, error in
            
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                do {
                    
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                }catch let err {
                    completion(.failure(.unknown()))

                }
                
            }
            
            if let data = data {
                do {
                     let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    
                    let result = try JSONDecoder().decode(CoinArray.self, from: data)
                    completion(.success(result.data))
                }catch let err {
                    completion(.failure(.decodinfError(err.localizedDescription)))

                }
                
                
            }else {
                completion(.failure(.unknown()))

            }
        }.resume()
    }
}
