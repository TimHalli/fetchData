//
//  UserCell.swift
//  fetchData
//
//  Created by Admin on 14/11/2023.
//

import UIKit
import Kingfisher

final class UserCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
        
    func configure(with user: User) {
        userName.text = user.name
        
        let resource = Kingfisher.KF.ImageResource(downloadURL: URL(string: user.avatar ?? "")!)
        userImage.kf.setImage(with: resource)
    }
}
