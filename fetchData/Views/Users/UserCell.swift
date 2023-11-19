//
//  UserCell.swift
//  fetchData
//
//  Created by Admin on 14/11/2023.
//

import UIKit

final class UserCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
        
    private let networkManager = NetworkManager.shared
    
    func configure(with user: User) {
        userName.text = user.fullName
        
        networkManager.fetchData(from: user.avatar ?? "") { result in
            switch result {
            case .success(let imageData):
                self.userImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
    }
}
