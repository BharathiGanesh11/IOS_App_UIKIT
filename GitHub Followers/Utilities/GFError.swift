//
//  GFError.swift
//  GitHub Followers
//
//  Created by Kumar on 05/08/24.
//

import Foundation

enum GFError : String , Error
{
    case checkInternetConnection = "Unable to process the request,please check the internet connection"
    case invalidUserName = "unable to process the request,invalid username"
    case invalidResponse = "unable to process the request,please try again!"
    case unableToFavorite = "unable to favorite,please try again!"
    case errorInGettingFavorites = "there is a error in getting your favorites,please try again!"
    case alreadyExistInfavorites = "this user is already exixt in your favorites!"
    case addedToFavoriteList = "this user is added to user favorites list!"
}
