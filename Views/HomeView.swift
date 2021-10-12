//
//  HomeView.swift
//  TestForTutu
//
//  Created by Михаил Кулагин on 08.10.2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var qvm = QuoteViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: QuoteEntity.entity(), sortDescriptors: [], animation: .default)
    private var coreDataQuotes: FetchedResults<QuoteEntity>
    
    var body: some View {
        NavigationView {
            VStack {
                
                if !coreDataQuotes.isEmpty && !qvm.quotes.isEmpty {
                    
                    List {
                        ForEach(qvm.quotes, id: \.self) { quote in
                            NavigationLink {
                                DetailView(quote: quote)
                            } label: {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(quote.author).font(.headline)
                                    Text(quote.content).font(.subheadline).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    
                } else if !coreDataQuotes.isEmpty && qvm.quotes.isEmpty {
                    
                    List {
                        ForEach(coreDataQuotes) { quoteEntity in
                            NavigationLink {
                                DetailView2(quoteEntity: quoteEntity)
                            } label: {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(quoteEntity.author ?? "").font(.headline)
                                    Text(quoteEntity.content ?? "").font(.subheadline).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationBarTitle(qvm.quotes.isEmpty ? "Quotes from core data" : "Quotes from network")
            .navigationBarItems(trailing:
                                    Button(
                                        action: {
                                            do {
                                                try viewContext.save()
                                            } catch {
                                                print(error)
                                            }
                                            
                                            if !coreDataQuotes.isEmpty && qvm.quotes.isEmpty {
                                                coreDataQuotes.forEach { quoteEntity in
                                                    viewContext.delete(quoteEntity)
                                                }
                                                qvm.quotes.removeAll()
                                            }
                                            
                                            qvm.fetchQuotes(page: Int.random(in: 0...95), viewContext: viewContext)
                                        },
                                        label: { Image(systemName: "arrow.triangle.2.circlepath") }))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
