//
//  MovieModel.swift
//  DevRevSample
//
//  Created by Cloy Monis on 14/03/24.
//

import Foundation
import UIKit

struct MovieModel {
    let mainImage: String
    let movieName: String
    var releaseDate: String?
    let backgroundImage: String
    let id: Int
    
    init(id: Int, mainImage: String, movieName: String, releaseDate: String, backgroundImage: String) {
        self.id = id
        self.mainImage = mainImage
        self.movieName = movieName
        self.backgroundImage = backgroundImage
        self.releaseDate = releaseDate.convertDate()
    }
}

extension String {
    func convertDate() -> String? {
        let dateFormatFrom = "yyyy-MM-dd"
        let dateFormatterFrom = DateFormatter()
        dateFormatterFrom.dateFormat = dateFormatFrom
        
        let dateFormatTo = "MMM dd, yyyy"
        let dateFormatterTo = DateFormatter()
        dateFormatterTo.dateFormat = dateFormatTo

        guard let date = dateFormatterFrom.date(from: self) else {
            return nil
        }
        return dateFormatterTo.string(from: date)
    }
}
