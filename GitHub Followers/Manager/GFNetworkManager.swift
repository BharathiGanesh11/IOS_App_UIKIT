//
//  GFNetworkManager.swift
//  GitHub Followers
//
//  Created by Kumar on 05/08/24.
//

import UIKit

class GFNetworkManager {
    
    static let shared = GFNetworkManager()
    var cache = NSCache<NSString,UIImage>()
    private init(){}
    
    let baseUrl : String = "https://api.github.com/users/"
    
    func getFollowers(userName : String , page : Int , completion : @escaping (Result<[Follower] , GFError>) -> ())
    {
        let endPoint = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else
        {
            completion(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil
            else
            {
                completion(.failure(.checkInternetConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200
            else
            {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data
            else
            {
                completion(.failure(.invalidResponse))
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            }
            catch
            {
                completion(.failure(.invalidResponse))
            }
        }
        
        task.resume()
    }
    
    func getUserInfo(userName : String , completion : @escaping (Result<User , GFError>) -> ())
    {
        let endPoint = baseUrl + "\(userName)"
        
        guard let url = URL(string: endPoint) else
        {
            completion(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil
            else
            {
                completion(.failure(.checkInternetConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200
            else
            {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data
            else
            {
                completion(.failure(.invalidResponse))
                return
            }
            
            do
            {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userInfo = try decoder.decode(User.self, from: data)
                completion(.success(userInfo))
            }
            catch
            {
                completion(.failure(.invalidResponse))
            }
        }
        
        task.resume()
    }
}
