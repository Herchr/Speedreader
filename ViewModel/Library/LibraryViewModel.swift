//
//  BookViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 08/09/2021.
//

import Foundation
import CloudKit
import UIKit
import SwiftUI
import Combine

class LibraryViewModel: ObservableObject {
    
    // MARK: - BOOKLISTVIEW
    @Published var books: [Book] = []
    
    // MARK: - BOOKVIEW
    @Published var showBookView: Bool = false
    @Published var selectedBook: Book = bookExamples[0]
    // MARK: - SEARCHBAR
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedBooks: [Book]?
    
    // MARK: - CATEGORIES
    @Published var filteredBooks: [Book]? = bookExamples
    @Published var selectedCategory: Category = categories.first!
    
    var searchCancellable: AnyCancellable?
    var selectCategoryCancellable: AnyCancellable?
//    init(){
//        if self.books.isEmpty{
//            self.fetchBooks()
//        }
//        
//        searchCancellable = $searchText.removeDuplicates()
//            .debounce(for: 0.5, scheduler: RunLoop.main)
//            .sink(receiveValue: { str in
//                if str != ""{
//                    self.filterBooksBySearch()
//                }
//                else{
//                    self.searchedBooks = nil
//                }
//            })
//        selectCategoryCancellable = $selectedCategory
//            .debounce(for: 0.1, scheduler: RunLoop.main)
//            .sink(receiveValue: { _ in
//                
//                self.filterBooksByCategory()
//        })
//    }
    
    func parseRecord(record: CKRecord) -> Book{
        var book = Book()
        book.author = record["author"] as! String
        book.about = record["about"] as! String
        let img = record["img"] as? CKAsset
        var imgURL: Data
        do{
            imgURL = try Data(contentsOf: (img?.fileURL!)!)
        }catch{
            return Book()
        }
        book.img = UIImage(data: (imgURL))
        book.title = record["title"] as! String
        //book.text = record["text"] as! String
        
        if let categories = (record["categories"] as? [String]){
            for cat in categories{
                book.categories.append(Category(title: cat))
            }
        }
        return book
    }
    
    func fetchBooks(){
        let pred = NSPredicate(value: true)
        let query = CKQuery(recordType: "Book", predicate: pred)
        let operation = CKQueryOperation(query: query)
        
        operation.desiredKeys = ["author", "about", "img", "title", "categories"]
        
        var fetchedBooks: [Book] = [Book]()
        
        operation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult{
            case .success(let record):
                let book = self.parseRecord(record: record)
                fetchedBooks.append(book)
            case .failure(let error):
                print("\(error)")
            }
        }
        
        operation.queryResultBlock = { [weak self] returnedResult in
            DispatchQueue.main.async {
                self?.books = fetchedBooks
                self?.filteredBooks = fetchedBooks
            }
        }
        
        CKContainer(identifier: "iCloud.com.hc.Book").publicCloudDatabase.add(operation)
        
    }

    func filterBooksBySearch(){
    
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.books
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter { book in
                    
                    return book.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedBooks = results.compactMap({ book in
                    return book
                })
            }
        }
    }
    
    func filterBooksByCategory(){
        if self.selectedCategory.title.lowercased() == "all"{
            DispatchQueue.main.async {
                self.filteredBooks = self.books
            }
        }else{
            DispatchQueue.global(qos: .userInteractive).async {
                let results = self.books
                // Since it will require more memory so were using lazy to perform more...
                    .lazy
                    .filter { book in
                        for category in book.categories{
                            if category.title.lowercased() == self.selectedCategory.title.lowercased(){
                                return true
                            }
                        }
                        return false
                    }
                
                DispatchQueue.main.async {
                    self.filteredBooks = results.compactMap({ book in
                        return book
                    })
                }
            }
        }
    }
}
