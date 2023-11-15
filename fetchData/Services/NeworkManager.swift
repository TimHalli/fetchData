//
//  NeworkManager.swift
//  fetchData
//
//  Created by Admin on 14/11/2023.
//

import Foundation

enum Link {
    case usersAPI
    case imageURL
    case courseURL
    case coursesURL
    case aboutUsURL
    case aboutUsURL2
    case postRequest
    case courseImageURL
    
    var url: URL {
        switch self {
        case .usersAPI:
            return URL(string: "https://random-data-api.com/api/v2/users?size=100&is_xml=true")!
        case .imageURL:
            return URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg")!
        case .courseURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_course")!
        case .coursesURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_courses")!
        case .aboutUsURL:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_website_description")!
        case .aboutUsURL2:
            return URL(string: "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields")!
        case .postRequest:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        case .courseImageURL:
            return URL(string: "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchAPI<T: Decodable>(_ type: T.Type, from url: URL, comletion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                comletion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    comletion(.success(type))
                }
            } catch {
                comletion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
