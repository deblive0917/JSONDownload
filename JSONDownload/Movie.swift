//
//  Movie.swift
//  JSONDownload
//
//  Created by debbb on 2020/12/23.
//

import Foundation
import UIKit
struct movie: Codable {
    let results : [detail]
   
}
struct detail: Codable {
    let original_title : String
    let poster_path : String
    let vote_average : Double
}

struct movieData : Encodable{
    var data: [detail]
}

