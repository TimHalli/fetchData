//
//  MainViewController.swift
//  fetchData
//
//  Created by Admin on 12/11/2023.
//

import UIKit

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

// MARK: - MainViewController
final class MainViewController: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var fetchButton: UIButton!

    // MARK: Private Properties
    private let BASE_URL = "https://random-data-api.com/api/v2"

    // MARK: Lifecycle view
    override func viewDidLoad() {
        loader.hidesWhenStopped = true
    }

    // MARK: Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.fetchButton.isHidden = false
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    // MARK: - IBActions
    @IBAction func getUsersButton(_ sender: UIButton) {
        sender.isHidden = true
        loader.startAnimating()
        fetchData()
    }
}

// MARK: - Fetch Data
extension MainViewController {
    
    private func fetchData() {
        URLSession.shared.dataTask(with: URL(string: "\(BASE_URL)/users?size=10&is_xml=true")!) { data, response, error in
            
            guard let data else {
                self.showAlert(withStatus: .failed)
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                
                DispatchQueue.main.async {
                    users.enumerated().forEach { (index, user) in
                        print("""
                              User \(index + 1)| \(user.fullName): 
                              \(user)
                              """)
                    }
                    
                    self.showAlert(withStatus: .success)
                    self.loader.stopAnimating()
                }

            } catch let connectioonError {
                print("Wrong data from API: \(connectioonError)")
                self.showAlert(withStatus: .failed)
            }
        }.resume()
    }
}
