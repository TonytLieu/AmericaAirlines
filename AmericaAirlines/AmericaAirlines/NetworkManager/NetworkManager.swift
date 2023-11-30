//
//  Network.swift
//  PokemonFirstSwiftUI
//
//  Created by Tony Lieu on 11/8/23.
//

import Foundation

protocol NetworkingManager{
    func getDataApi<T:Decodable>(url:URL, modelType:T.Type) async throws-> T
}

class NetworkManager:NetworkingManager{
    func getDataApi<T>(url: URL, modelType: T.Type) async throws -> T where T : Decodable {
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            let parsedData = try JSONDecoder().decode(modelType, from: data)
            return parsedData
        }catch{
            throw error
        }
    }
}
