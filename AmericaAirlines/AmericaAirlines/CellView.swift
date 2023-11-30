//
//  ViewCell.swift
//  AmericaAirlines
//
//  Created by D'Ante Watson on 11/30/23.
//

import SwiftUI

struct CellView: View {
    var title:String
    var url:String
    var body: some View {
        VStack{
            Text(title)
            Text(url)
        }.frame(height: 100)
        
    }
}

#Preview {
    CellView(title: "taco", url: "taco")
}
