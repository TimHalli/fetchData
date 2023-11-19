//
//  NeworkManager.swift
//  fetchData
//
//  Created by Admin on 14/11/2023.
//

import Foundation
import Alamofire

enum Link {
    case usersAPI
   
    var url: URL {
        switch self {
        case .usersAPI:
            return URL(string: "https://random-data-api.com/api/v2/users?size=100&is_xml=true")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case noUsers
    
    var title: String {
        switch self {
        case .invalidURL:
            return "Can't decode recived data"
        case .noData:
            return "Can'tfetch data at all"
        case .noUsers:
            return "No users got from API"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUsers(from url: URL, complition: @escaping(Result<[User], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let localUsers = User.getUsers(from: value)
                    complition(.success(localUsers))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
//    func fetchAPI<T: Decodable>(_ type: T.Type, from url: URL, comletion: @escaping(Result<T, NetworkError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data else {
//                comletion(.failure(.noData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let type = try decoder.decode(T.self, from: data)
//                DispatchQueue.main.async {
//                    comletion(.success(type))
//                }
//            } catch {
//                comletion(.failure(.noUsers))
//            }
//        }.resume()
//    }
//    
//    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: url) else {
//                completion(.failure(.noData))
//                return
//            }
//            DispatchQueue.main.async {
//                completion(.success(imageData))
//            }
//        }
//    }
    
//    func fetchURL(url: URL, completion: @escaping(URL) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data else {
//                print(error ?? "Non")
//                return
//            }
//            
//            let jsonDecoder = JSONDecoder()
//            
//            do {
//                let imageData = try jsonDecoder.decode(User.self, from: data)
//                DispatchQueue.main.async {
//                    completion(URL(string: imageData.avatar ?? "")!)
//                }
//            } catch {
//                print(error)
//            }
//        }
//    }
}
