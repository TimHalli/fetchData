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

final class MainViewController: UIViewController {
    private let url = "https://random-data-api.com/api/v2/users?size=10&is_xml=true"
    
    // MARK: - Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
    
    @IBAction func getUsersButton(_ sender: UIButton) {
        fetchData()
    }
}

    // MARK: - Extention
extension MainViewController {
    
    private func fetchData() {
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            // Обработка ошибок
            if let error = error {
                print(error.localizedDescription)
                self.showAlert(withStatus: .failed)
                return
            }
            
            // Проверка наличия данных
            guard let data = data else {
                print("No data received")
                self.showAlert(withStatus: .failed)
                return
            }
            
            do {
                // Декодирование данных
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                
                // Перечисление пользователей
                DispatchQueue.main.async {
                    users.enumerated().forEach { (index, user) in
                        print("User \(index + 1): \(user)")
                    }
                    
                    self.showAlert(withStatus: .success)
                }
            } catch {
                print("Wrong data from API: \(error)")
                self.showAlert(withStatus: .failed)
            }
        }.resume()
    }

//    private func fetchData() {
//        
//        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error describtion" )
//                return
//            }
//            
//            do {
//                let data = try JSONDecoder().decode([User].self, from: data)
//                
//                data.enumerated().forEach { (index, user) in
//                    print("User \(index + 1): \(user)")
//                }
//            
//                self.showAlert(withStatus: .success)
//            } catch let connectioonError {
//                print("Wrong data from API: \(connectioonError)")
//                self.showAlert(withStatus: .failed)
//            }
//        }.resume()
//    }
}
