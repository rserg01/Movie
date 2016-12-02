//
//  MovieModel.swift
//  movie
//
//  Created by Reginald Sergio on 11/21/16.
//  Copyright © 2016 com.movie. All rights reserved.
//

import Foundation

class Movie {
    
    var id : Double
    var posterPath : String?
    var adult : Bool?
    var overview : String?
    var releaseDate : String?
    var originalTitle : String?
    var originalLanguage : String?
    var title: String?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool
    var voteAverage: Double?
    var genreIds:[Genre]
    
    init (id: Double, posterPath: String, adult: Bool, overview: String, releaseDate: String, originalTitle: String?, originalLanguage: String, title:String, backdropPath:String, popularity: Double, voteCount: Int, video: Bool, voteAverage: Double, genreIds:[Genre]) {
        self.id = id
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
        self.genreIds = genreIds
    }
    
    init(movieDictionary:[String : AnyObject]) {
        self.id = movieDictionary["id"] as! Double
        self.posterPath = movieDictionary["poster_path"] as? String
        self.adult = movieDictionary["adult"] as? Bool
        self.overview = movieDictionary["overview"] as? String
        self.releaseDate = movieDictionary["release_date"] as? String
        self.originalTitle = movieDictionary["original_title"] as? String
        self.originalLanguage = movieDictionary["original_language"] as? String
        self.title = movieDictionary["title"] as? String
        self.backdropPath = movieDictionary["backdrop_path"] as? String
        self.popularity = movieDictionary["popularity"] as? Double
        self.voteCount = movieDictionary["vote_count"] as? Int
        self.video = movieDictionary["video"] as! Bool
        self.voteAverage = movieDictionary["vote_average"] as? Double
        self.genreIds = movieDictionary["genre_ids"] as! [Genre]
    }
    
    static func downloadAllMovies -> [Movie] {
        
    }
    
}

class Genre {
    var id : Int
    
    init(id: Int) {
        self.id = id
    }
}