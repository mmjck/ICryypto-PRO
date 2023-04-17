//
//  ViewController.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 15/04/23.
//

import UIKit

class HomeController: UIViewController {
    
    private let coins: [Coin] = []
    

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        
        
        self.navigationItem.title = "ICyypt Pro"
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
                    self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}


extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("unable to dequeue coiun cell in home controller")
        }
        let coin = self.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = self.coins[indexPath.row]
        let vm = ViewCryptoControllerViewModel(coin: coin)
        let vc = ViewCryptoControllerViewController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
