//
//  PopularListMovieLoader.swift
//  MovieAPI
//
//  Created by User 2 on 09/08/22.
//
import UIKit

public struct Movie: Decodable{
    var adult : Bool
    var backdropPath : String?
    var genreIds : [Int]
    var id : Int
    var originalLanguage : String
    var originalTitle : String
    var overview : String
    var popularity : Double?
    var posterPath : String
    var releaseDate : String?
    var title : String?
    var video : Bool?
    var voteAverage : Double?
    var voteCount : Int?
}

public struct MovieList: Decodable{
    var page : Int
    var results: [Movie]
    var totalPages : Int
    var totalResults : Int
}

public enum ListMovieLoaderResult{
    case succes(MovieList)
    case failure(ListMovieError)
}

public enum ListMovieError{
    case unexpectedDataError
    case unauthorizedError
    case notFoundAdress
    case defaultError(String)
}



public class PopularListMovieLoader: ListMovieLoader{
    
    
    public func getListMovies(listType: ListTypes, completion: @escaping (ListMovieLoaderResult) -> Void) {
        
//        let API_KEY = "4e468be7387bb9d750d813d75569f6f8"
//        let BASE_URL = "https://api.themoviedb.org/3/"
//
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "api.themoviedb.org"
//        components.path = "3/movie"
//        components.queryItems = [URLQueryItem.init(name: "api_key", value: API_KEY)]
//        guard let url = components.url else{ return }

        var url: URL?

        switch listType {
        case .popular:
            url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4e468be7387bb9d750d813d75569f6f8")!
        case .upcoming:
            url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=4e468be7387bb9d750d813d75569f6f8")!
        case .topRated:
            url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=4e468be7387bb9d750d813d75569f6f8")!
        }
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: request) { data, response , error in
            guard let data = data, let response = response as? HTTPURLResponse else{
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(.defaultError(error.localizedDescription)))
                    }
                }
                return
            }
            if response.statusCode == 200{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let movieList = try? decoder.decode(MovieList.self, from: data) else{
                    return completion(.failure(.unexpectedDataError))
                }
                DispatchQueue.main.async {
                    completion(.succes(movieList))
                }
            }else if response.statusCode == 401{
                DispatchQueue.main.async {
                    completion(.failure(.unauthorizedError))
                }
            }else if response.statusCode == 404{
                DispatchQueue.main.async {
                    completion(.failure(.notFoundAdress))
                }
            }
            
        }.resume()
    }
}
