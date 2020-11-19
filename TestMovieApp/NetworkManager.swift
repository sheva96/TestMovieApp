//
//  Network.swift
//  TestMovieApp
//
//  Created by Yevhen Shevchenko on 17.11.2020.
//

import Foundation
import Alamofire


enum URLS: String {
    case topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=e1bda3bc572e5d4be53de6e0a030fe19&language=ru-RU&page=1"
    case postPath = "https://image.tmdb.org/t/p/w500"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(complition: @escaping ([Movie]) -> ()) {
        AF.request(URLS.topRated.rawValue)
            .validate()
            .responseJSON { (data) in
                var movies: [Movie] = []
                
                switch data.result {
                case .success(let value):
                    movies = Movie.getMovies(from: value) ?? []
                    DispatchQueue.main.async {
                        complition(movies)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

/*
class ImageManager {
    static let  shared = ImageManager()
    
    func fetchImage(from url: String) -> Data {
        var imadeData = Data()
        AF.request(url).validate().responseData { response in
            guard let data = response.data else { return }
            imadeData = data
        }
        return imadeData
    }
}
 */
