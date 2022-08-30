//
//  ListMovieLoader.swift
//  MovieAPI
//
//  Created by User 2 on 09/08/22.
//

import UIKit

public enum ListTypes{
    case popular
    case upcoming
    case topRated
    
    var path: String{
        switch self {
        case .popular: return "popular"
        case .upcoming:return "upcoming"
        case .topRated:return "topRated"
        }
    }
}

public protocol ListMovieLoader{
    
    func getListMovies(listType: ListTypes, completion: @escaping(ListMovieLoaderResult)->Void)
}
