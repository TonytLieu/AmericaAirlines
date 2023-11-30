//
//  AmericanAirlineViewModel.swift
//  AmericaAirlines
//
//  Created by Suguru Tokuda on 11/30/23.
//

import Foundation
import Combine

class AmericanAirlineViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [AAResult] = []
    @Published var relatedTopics: [AARelatedTopic] = []
    @Published var errorOccured: Bool = false
    @Published var customError: NetworkError?
    
    var cancellables = Set<AnyCancellable>()
    
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func addSubscriptions() {
        $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { val in
                Task {
                    await self.performSearch(searchText: val)
                }
            }
            .store(in: &cancellables)
    }
    
    func performSearch(searchText: String) async {
        var urlString = "\(Constants.apiEndpoint)?\(searchText.replacingOccurrences(of: " ", with: "+"))&format=json&pretty=1"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.customError = NetworkError.badUrl
                self.errorOccured = true
            }
            return
        }
        
        do {
            let res = try await networkManager.getDataApi(url: url, modelType: DuckDuckGoResponse.self)
            
            if res.results.isEmpty && res.relatedTopics.isEmpty {
                self.customError = NetworkError.noData
                self.errorOccured = true
                return
            }
            
            DispatchQueue.main.async {
                results = res.results
                relatedTopics = res.relatedTopics
            }
        } catch {
            DispatchQueue.main.async {
                if let error = error as? NetworkError {
                    self.customError = error
                    self.errorOccured = true
                } else {
                    self.customError = NetworkError.unknown
                    self.errorOccured = true
                }
            }
        }
    }
    
    func supressError() {
        errorOccured = false
        customError = nil
    }
}
