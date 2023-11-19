//
//  MainViewController.swift
//  fetchData
//
//  Created by Admin on 12/11/2023.
//

import UIKit

enum UserAction: CaseIterable {
    case getUsers
    
    var title: String {
        switch self {
        case .getUsers:
            return "Fetch Users"
        }
    }
}

// MARK: - MainViewController
final class MainViewController: UICollectionViewController {
   
    // MARK: Private Properties
    private let userActions = UserAction.allCases
    private let networkManager = NetworkManager.shared
    private let showUsers = "showUsers"
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userAction", for: indexPath)
        guard let cell = cell as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].title
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .getUsers: performSegue(withIdentifier: showUsers, sender: nil)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showUsers {
            guard let usersTVC = segue.destination as? UsersListController else { return }
            usersTVC.fetchData()
        }
    }
}
