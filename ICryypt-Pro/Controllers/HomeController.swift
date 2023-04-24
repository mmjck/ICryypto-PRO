//
//  ViewController.swift
//  ICryypt-Pro
//
//  Created by Jackson Matheus on 15/04/23.
//

import UIKit

class HomeController: UIViewController {
    
    // private let coins: [Coin] = []
    private let viewModel: HomeControllerViewModel

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        return tv
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeted")
    }

    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
        self.viewModel.onErrorMessage = {
            [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                )
                
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                case .decodinfError(let string):
                    alert.title = "Error parsing data"
                    alert.message = string
                    
                case .unknown(let string):
                    alert.title = "Error fetching coins"
                    alert.message = string
                }
                
                self?.present(alert, animated: true, completion: nil)
                
            }
        }
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
        return self.viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("unable to dequeue coiun cell in home controller")
        }
        let coin = self.viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let coin = self.viewModel.coins[indexPath.row]
        let vm = ViewCryptoControllerViewModel(coin: coin)
        let vc = ViewCryptoControllerViewController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
