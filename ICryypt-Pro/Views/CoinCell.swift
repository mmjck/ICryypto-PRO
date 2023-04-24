//
//  CoinCell.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 15/04/23.
//

import Foundation
import UIKit

class CoinCell: UITableViewCell {
    static let identifier = "CoinCell"
    
    
    private (set) var coin: Coin!
    
    
    private lazy var coinLogo: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "questionmark")
        image.tintColor = .black
        return image
    }()

    private lazy var coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Trror"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func configure(with coin: Coin){
        self.coin = coin
        DispatchQueue.global().async { [weak self] in
                    if let logoURL = coin.logoURL,
                       let imageData = try? Data(contentsOf: logoURL),
                       let logoImage = UIImage(data: imageData) {

                        DispatchQueue.main.async {
                            self?.coinLogo.image = logoImage
                        }
                    }
        }
        self.coinName.text = coin.name
        
    }
    
    
    // TODO: - PrepareForReuse
      override func prepareForReuse() {
          super.prepareForReuse()
          self.coinName.text = nil
          self.coinLogo.image = nil
      }
    
    private func setupUI(){
        self.addSubview(coinLogo)
        self.addSubview(coinName)
        
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        coinName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(
                equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier:  0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:  0.75)
        ])
        NSLayoutConstraint.activate([
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            coinName.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            ])
            
    }
}
