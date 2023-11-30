//
//  ViewCell.swift
//  AmericaAirlines
//
//  Created by D'Ante Watson on 11/30/23.
//

import SwiftUI

struct CellView: View {
    var title: String
    var url: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
            Text(url)
                .font(.caption)
        }
    }
}

#Preview {
    CellView(title: "American Airline Category", url: "https://duckduckgo.com/c/American_Airlines")
}
