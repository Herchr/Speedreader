//
//  BookViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 08/09/2021.
//

import Foundation
import CloudKit
import UIKit

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = [Book()]
    
    init(){
        let container = CKContainer(identifier: "iCloud.com.hc.Book")
        let publicDatabase = container.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Book", predicate: predicate)
        publicDatabase.perform(query, inZoneWith: CKRecordZone.default().zoneID){ records, error in
            if let error = error {
              DispatchQueue.main.async {
                print(error)
              }
              return
            }
            guard let records = records else { return }
            DispatchQueue.main.async {
                self.parseRecords(records: records)
            }

        }
    }
    
    func parseRecords(records: [CKRecord]){
        for record in records{
            var newBook = Book()
            newBook.author = record["author"] as! String
            newBook.about = record["about"] as! String
            let img = record["img"] as? CKAsset
            var imgURL: Data
            do{
                imgURL = try Data(contentsOf: (img?.fileURL!)!)
            }catch{
                return
            }
            newBook.img = UIImage(data: (imgURL))
            newBook.title = record["title"] as! String
            newBook.text = record["text"] as! String
            //newBook.category = record["category"] as! String
            self.books.append(newBook)
        }
    }

    func loadImage(img: CKAsset){

    }
}

//class BookViewModel {
//    var book: Book
//
//    init(book : Book){
//        self.book = book
//    }
//
//    //var id: UUID { return self.book.id}
//    var author: String { return self.book.author ?? ""}
//    var title: String { return self.book.title ?? ""}
//    var about: String { return self.book.about ?? ""}
//    var text: String { return self.book.text ?? ""}
//    var img: String { return self.book.img ?? ""}
//}
