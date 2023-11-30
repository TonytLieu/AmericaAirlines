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
    @Published var relatedTopics: [AAResult] = []
    @Published var errorOccured: Bool = false
    @Published var customError: NetworkError?
    
    var cancellables = Set<AnyCancellable>()
    
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        self.addSubscriptions()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func addSubscriptions() {
        $searchText
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { val in
                Task {
                    await self.performSearch(searchText: val)
                }
            }
            .store(in: &cancellables)
    }
    
    func performSearch(searchText: String) async {
        if !searchText.isEmpty {
            let urlString = "\(Constants.apiEndpoint)?q=\(searchText.replacingOccurrences(of: " ", with: "+"))&format=json&pretty=1"
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
                    self.customError = NetworkError.nodata
                    self.errorOccured = true
                    return
                }
                
                DispatchQueue.main.async {
                    self.results = res.results
                    self.relatedTopics = res.relatedTopics
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
    }
    
    func supressError() {
        errorOccured = false
        customError = nil
    }
}
