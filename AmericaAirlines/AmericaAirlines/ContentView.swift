//
//  ContentView.swift
//  AmericaAirlines
//
//  Created by Tony Lieu on 11/30/23.
//

import SwiftUI

/*
 4. Create a view which has the following features
 
 1. Search text bar on the top: call the vm function to update the search result every time the searchText value changes.
 2. Results section: only results length is greater than 0.
 3. Related topics section: only relatedTopics length is greater than 0.

 */

struct ContentView: View {
    
    @StateObject var americanAirlineViewModel = AmericanAirlineViewModel()
    @State var isErrorOccurred:Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            List{
                if !americanAirlineViewModel.results.isEmpty {
                    ForEach{
                        Section("Result") {
                            CellView()
                        }
                    }
                }else {
                    Text("No Results Were Found")
                }
                
                
                if !americanAirlineViewModel.relatedTopics.isEmpty {
                    ForEach{
                        Section("Related Topics") {
                            CellView()
                        }
                    }
                }else {
                    Text("No Results Were Found")
                }
            }
        }
        .searchable(text: $searchText, placement: .automatic, prompt: "Search Planet")
        .onChange(of: searchText) { oldValue, newValue in
            americanAirlineViewModel.performSearch(searchText: newValue)
        }
        .alert(isPresented: $isErrorOccurred) {
            Alert(title: Text(americanAirlineViewModel.customError?.localizedDescription ?? ""),
                  message: Text("Try Again"),
                  dismissButton: .default(Text("Okay")))
        }
    }
}

#Preview {
    ContentView()
}
