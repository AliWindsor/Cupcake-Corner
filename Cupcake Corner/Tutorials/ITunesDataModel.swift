//
//  ITunesDataModel.swift
//  Cupcake Corner
//
//  Created by Alicia Windsor on 01/06/2021.
//

import Foundation

struct Response: Codable{
    var results: [Result]
}

struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}
