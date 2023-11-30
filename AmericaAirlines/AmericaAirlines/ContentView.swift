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
    
    var body: some View {
        VStack {
            TextField("Search...", text: $americanAirlineViewModel.searchText)
                .padding(.horizontal, 10)
            List{
                if !americanAirlineViewModel.results.isEmpty {
                    Section("Result") {
                        ForEach(americanAirlineViewModel.results) { result in
                            CellView(title: result.text, url: result.firstURL)
                        }
                    }
                }else {
                    Text("No Results Were Found")
                }
                
                
                if !americanAirlineViewModel.relatedTopics.isEmpty {
                    Section("Related Topics") {
                        ForEach(americanAirlineViewModel.relatedTopics) { result in
                            CellView(title: result.text, url: result.firstURL)
                        }
                    }
                }else {
                    Text("No Results Were Found")
                }
            }
        }
        .alert(isPresented: $isErrorOccurred) {
            Alert(title: Text(americanAirlineViewModel.customError?.localizedDescription ?? ""),
                  message: Text("Try Again"),
                  dismissButton: .cancel(Text("OKay"), action: {
                americanAirlineViewModel.supressError()
            }))
        }
    }
}

#Preview {
    ContentView()
}
