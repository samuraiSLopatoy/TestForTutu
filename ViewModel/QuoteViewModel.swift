//
//  QuoteViewModel.swift
//  TestForTutu
//
//  Created by Михаил Кулагин on 08.10.2021.
//

import SwiftUI
import CoreData

class QuoteViewModel: ObservableObject {

    @Published var quotes: [Quote] = []
    
    // MARK: - SAVING JSON TO CORE DATA
    
    func saveQuotes(viewContext: NSManagedObjectContext) {
        quotes.forEach { quote in
            let quoteEntity = QuoteEntity(context: viewContext)
            quoteEntity.author = quote.author
            quoteEntity.content = quote.content
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: - NETWORK MANAGER
    
    func fetchQuotes(page: Int, viewContext: NSManagedObjectContext) {
        
        guard let urlString = URL(string: "https://api.quotable.io/quotes?page=\(page)") else { return }
        
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            guard
                let jsonData = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else { return }
            
            do {
                let jsonQuotes = try JSONDecoder().decode(Result.self, from: jsonData)
                DispatchQueue.main.async {
                    self.quotes = jsonQuotes.results
                    self.saveQuotes(viewContext: viewContext)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
}


