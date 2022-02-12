//
//  Category.swift
//  Speedreader
//
//  Created by Herman Christiansen on 09/01/2022.
//

import Foundation
import SwiftUI

struct Category: Identifiable{
    var id: UUID = UUID()
    var image: String
    var title: String
    
    init(title: String){
        self.title = title
        
        if title != "All"{
            self.image = title
        }else{
            self.image = ""
        }
    }
    
}

var categories = [
    Category(title: "All"),
    Category(title: "History"), Category(title: "Sci-Fi"),
    Category(title: "Fantasy"), Category(title: "Romance"),
    Category(title: "Mystery"), Category(title: "Nonfiction"),
    Category(title: "Biography"), Category(title: "Thriller")
]
