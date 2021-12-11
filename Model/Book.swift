//
//  Book.swift
//  Speedreader
//
//  Created by Herman Christiansen on 23/10/2021.
//

import Foundation
import SwiftUI

struct Book: Identifiable {
    var id = UUID()
    var title: String = ""
    var author: String = ""
    var img: UIImage?
    var text: String = ""
    var about: String = ""
    var category: String = ""
}
