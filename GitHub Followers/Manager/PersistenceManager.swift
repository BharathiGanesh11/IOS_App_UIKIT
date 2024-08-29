//
//  PersistenceManager.swift
//  GitHub Followers
//
//  Created by Kumar on 29/08/24.
//

import UIKit

enum PersistenceActionType {
    case add
    case remove
}

enum PersistenceManager {
    
    enum Keys {
        static let favoriteKey = "favoriteKey"
    }
    
    static let defaults = UserDefaults.standard
    
    static func saveFavorites(favorites : [Follower]) -> GFError? {
        do
        {
            let encoder = JSONEncoder()
            let encodedfavorites = try encoder.encode(favorites)
            defaults.setValue(encodedfavorites, forKey: Keys.favoriteKey)
            return nil
        }
        catch
        {
            return .unableToFavorite
        }
    }
    
    static func fetchFavorites(completed : @escaping (Result<[Follower],GFError>) -> ()) {
        guard let favoritesData = defaults.object(forKey: Keys.favoriteKey) as? Data else {
            completed(.success([]))
            return
        }
        
        do
        {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }
        catch
        {
            completed(.failure(.errorInGettingFavorites))
        }
    }
    
    static func updateFavorites(actionType : PersistenceActionType , with favorite : Follower , completed : @escaping (GFError?) -> ())
    {
        var favorites : [Follower] =  []
        
        fetchFavorites { result in
            switch result {
            case .success(let favoritesArray):
                favorites = favoritesArray
                
                switch actionType {
                case .add:
                    if !favorites.contains(favorite)
                    {
                        favorites.append(favorite)
                        completed(saveFavorites(favorites: favorites))
                        return
                    }
                    else
                    {
                        completed(.alreadyExistInfavorites)
                        return
                    }
                case .remove:
                    favorites.removeAll(where: {$0.login == favorite.login})
                    completed(saveFavorites(favorites: favorites))
                    return
                }
                
            case .failure(let error):
                completed(error)
                return
            }
        }
    }
}

// favorite is basically a follower object with login and avatar url

// function for reterive those favorites

// function for save those favorites

// function to do manupulation on those favorites like add or delete favorites
