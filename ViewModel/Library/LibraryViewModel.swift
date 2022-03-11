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
import Firebase
import FirebaseFirestore
import FirebaseStorage

class LibraryViewModel: ObservableObject {
    // MARK: - FIRESTORE
    let db = Firestore.firestore()
    // MARK: - BOOKLISTVIEW
    @Published var books: [Book] = [Book]()
    
    // MARK: - FEATURED BOOKLIST
    @Published var featuredBooks: [Book] = [Book]()
    
    // MARK: - BOOKVIEW
    @Published var showBookView: Bool = false
    @Published var selectedBook: Book = bookExamples[4]
    // MARK: - SEARCHBAR
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedBooks: [Book]?
    
    // MARK: - CATEGORIES
    @Published var filteredBooks: [Book]? = bookExamples
    @Published var showCategoryBookListView: Bool = false
    @Published var selectedCategory: Category = categories.first!
    
    var searchCancellable: AnyCancellable?
    var selectCategoryCancellable: AnyCancellable?
    

    init(){
        if self.books.isEmpty{
            self.getBooks()
        }

        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterBooksBySearch()
                }
                else{
                    self.searchedBooks = nil
                }
            })
        selectCategoryCancellable = $selectedCategory
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .sink(receiveValue: { _ in

                self.filterBooksByCategory()
        })
    }
    
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
        if let text = record["text"]{
            book.text = text as! String
        }
        
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
        
        operation.desiredKeys = ["author", "about", "img", "title", "text", "categories"]
        
        var fetchedBooks: [Book] = [Book]()
        
        operation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult{
            case .success(let record):
                let book = self.parseRecord(record: record)
                if ["The Adventures of Sherlock Holmes", "The Scarlet Letter", "The Adventures of Huckleberry Finn"].contains(book.title){
                    fetchedBooks.insert(book, at: 0)
                }else{
                    fetchedBooks.append(book) // CHANGE TO JUST THIS LINE. THE ABOVE IF IS FOR DESIGN PURPOSES
                }
                
            case .failure(let error):
                print("\(error)")
            }
        }
        
        operation.queryResultBlock = { [weak self] returnedResult in
            DispatchQueue.main.async {
                self?.books = fetchedBooks
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
    
    // MARK: - FIRESTORE
    func getBooks(){
        db.collection("Books").getDocuments{ (querySnapshot, error) in
            guard error == nil else{
                print("error fetching from firestore: ", error ?? "")
                return
            }
            //var documents: [QueryDocumentSnapshot] = []
            for doc in querySnapshot!.documents{
                let data = doc.data()
                let id = doc.documentID
                let title = data["title"] as? String ?? ""
                let author = data["author"] as? String ?? ""
                var img: UIImage?
                if let image = UIImage(named: title){
                    img = image
                }else{
                    img = UIImage(color: UIColor.random)
                }
                let imgUrl = data["imgUrl"] as? String ?? ""
                let about = data["about"] as? String ?? ""
                var categories: [Category] = []
                if let cats = data["categories"] as? [String]{
                    for cat in cats{
                        categories.append(Category(title: cat))
                    }
                }
                if title == "Alice's Adventures in Wonderland"{
                    print(id)
                }
                let book = Book(id: id, title: title, author: author, img: img, imgUrl: imgUrl, about: about, categories: categories)
                if let featured = data["featured"] as? Bool{
                    if featured{
                        withAnimation {
                            self.featuredBooks.append(book)
                        }
                        print("\(title) \(id)")
                    }
                }
                self.books.append(book)
                
                //documents.append(doc)
            }
        }
    }
}
