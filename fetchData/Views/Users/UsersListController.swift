//
//  UsersListController.swift
//  fetchData
//
//  Created by Admin on 14/11/2023.
//

import UIKit

final class UsersListController: UITableViewController {
    private let networkManager = NetworkManager.shared
    
    private var localUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        localUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        guard let cell = cell as? UserCell else { return UITableViewCell() }

        let user = localUsers[indexPath.row]
        cell.configure(with: user)
//        cell.userImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = localUsers[indexPath.row]
        performSegue(withIdentifier: "selectedUser", sender: user)
    }
}

extension UsersListController {
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let user = sender as? User else { return }
        guard let userVC = segue.destination as? UserViewController else { return }
        userVC.user = user
    }
}
// MARK: - Networking
extension UsersListController {
   
    func fetchData() {
        networkManager.fetchAPI ([User].self, from: Link.usersAPI.url) { [unowned self] result in
            switch result {
            case .success(let dataUsers):
                localUsers = dataUsers
            case .failure(let error):
                print(error)
            }
            tableView.reloadData()
        }
    }
}
