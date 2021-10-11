//
//  Quote.swift
//  TestForTutu
//
//  Created by Михаил Кулагин on 08.10.2021.
//

import Foundation

struct Result: Decodable {
    let results: [Quote]
}

struct Quote: Decodable, Hashable {
    let author: String
    let content: String
}
