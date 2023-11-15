//
//  UserImageViewController.swift
//  fetchData
//
//  Created by Admin on 14/11/2023.
//

import UIKit
import Kingfisher

final class UserViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fullNameUser: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeUser(user)
    }
    
    private func composeUser(_ user: User) {
        fullNameUser.text = user.fullName
        let resource = Kingfisher.KF.ImageResource(downloadURL: URL(string: user.avatar ?? "")!)
        userImage.kf.setImage(with: resource)
    }
}
