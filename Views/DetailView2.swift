//
//  DetailView2.swift
//  TestForTutu
//
//  Created by Михаил Кулагин on 11.10.2021.
//

import SwiftUI

struct DetailView2: View {
    
    let quoteEntity: QuoteEntity
    
    var body: some View {
        Image("thinkAboutIt").resizable()
        VStack(alignment: .leading, spacing: 5) {
            Text(quoteEntity.author ?? "").font(.title)
            Text(quoteEntity.content ?? "").font(.title2).foregroundColor(.gray)
        }
        .padding()
    }
}

//struct DetailView2_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView2()
//    }
//}
