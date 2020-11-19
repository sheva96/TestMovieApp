//
//  Model.swift
//  TestMovieApp
//
//  Created by Yevhen Shevchenko on 17.11.2020.
//

struct Movie {
    let posterPath: String?
    let originalTitle: String?
    let title: String?
    let voteAverag: Double?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case title = "title"
        case voteAverag = "vote_averag"
        case overview = "overview"
    }
    
    init(result: [String: Any]) {
        posterPath = result["poster_path"] as? String
        originalTitle = result["original_title"] as? String
        title = result["title"] as? String
        voteAverag = result["vote_averag"] as? Double
        overview = result["overview"] as? String
    }
    
    static func getMovies(from value: Any) -> [Movie]? {
        guard let value = value as? [String: Any] else { return nil }
        guard let movies = value["results"] as? [[String: Any]] else { return nil}
        
        var films: [Movie] = []
        movies.forEach { movie in
            let movie = Movie(result: movie)
            films.append(movie)
        }
        return films
    }
}
