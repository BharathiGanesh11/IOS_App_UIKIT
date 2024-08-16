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
}
