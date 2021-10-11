//
//  DetailView.swift
//  TestForTutu
//
//  Created by Михаил Кулагин on 08.10.2021.
//

import SwiftUI

struct DetailView: View {
    
    let quote: Quote
    
    var body: some View {
        Image("thinkAboutIt").resizable()
        VStack(alignment: .leading, spacing: 5) {
            Text(quote.author).font(.title)
            Text(quote.content).font(.title2).foregroundColor(.gray)
        }
        .padding()
    }
}


//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
