//
//  AmericanAirlinesModel.swift
//  AmericaAirlines
//
//  Created by Russell Campbell on 11/30/23.
//

import Foundation

struct DuckDuckGoResponse: Decodable
{
    
    let results, relatedTopics: [AAResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case relatedTopics = "RelatedTopics"
    }
}

struct AAResult: Decodable {
    
    let firstURL, result, text: String
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case firstURL = "FirstURL"
        case text     = "Text"
    }

}

