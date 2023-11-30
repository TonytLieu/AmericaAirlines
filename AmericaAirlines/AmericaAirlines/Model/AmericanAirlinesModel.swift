//
//  AmericanAirlinesModel.swift
//  AmericaAirlines
//
//  Created by Russell Campbell on 11/30/23.
//

import Foundation

struct DuckDuckGoResponse: Decodable {
    let results: [AAResult]
    let relatedTopics: [AAResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case relatedTopics = "RelatedTopics"
    }
}

struct AAResult: Decodable, Identifiable {
    let id = UUID()
    let firstURL: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case text = "Text"
    }
}
