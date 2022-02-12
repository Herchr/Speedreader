//
//  Book.swift
//  Speedreader
//
//  Created by Herman Christiansen on 23/10/2021.
//

import Foundation
import SwiftUI

struct Book: Identifiable, Equatable, Hashable {
    
    var id: UUID = UUID()
    var title: String = ""
    var author: String = ""
    var img: UIImage?
    var text: String = ""
    var about: String = ""
    var categories: [Category] = []
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
//    enum CodingKeys: String, CodingKey { //Firestore
//        case id
//        case title
//        case author
//        case img = "image"
//    }
    
    
}

var bookExamples = [
    Book(title: "Frankenstein", author: "Mary Shelley", img: UIImage(named: "Frankenstein_Or_The_Modern_Prometheus")!, text: "", about: "Obsessed with the idea of creating life itself, Victor Frankenstein plunders graveyards for the material with which to fashion a new being, shocking his creation to life with electricity. But this botched creature, rejected by its creator and denied human companionship, sets out to destroy Frankenstein and all that he holds dear.", categories: [Category(title: "Horror"), Category(title: "Mystery")]),
    
    Book(title: "Huckleberry Finn", author: "Mary Shelley", img: UIImage(named: "Huckleberry_Finn")!, text: "", about: "blabla", categories: [Category(title: "Horror"), Category(title: "Mystery")]),
    
    Book(title: "The Scarlett Letter", author: "Mary Shelley", img: UIImage(named: "The_Scarlett_Letter")!, text: "", about: "blabla", categories: [Category(title: "History"), Category(title: "Nonfiction")]),
    
    Book(title: "Moby Dick", author: "Mary Shelley", img: UIImage(named: "Moby_Dick")!, text: "", about: "blabla", categories: [Category(title: "Romance"), Category(title: "Thriller")]),
    
    Book(title: "Sherlock Holmes", author: "Mary Shelley", img: UIImage(named: "Sherlock_Holmes")!, text: "", about: "blabla", categories: [Category(title: "Sci-Fi"), Category(title: "Thriller")])
]
