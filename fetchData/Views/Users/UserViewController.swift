//
//  UserImageViewController.swift
//  fetchData
//
//  Created by Admin on 14/11/2023.
//

import UIKit

final class UserViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fullNameUser: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeUser(user)
    }
    
    private func composeUser(_ user: User) {
        fullNameUser.text = user.fullName
        
        networkManager.fetchData(from: user.avatar ?? "") { result in
            switch result {
            case .success(let imageData):
                self.userImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
