//
//  Question.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/01/2022.
//

import Foundation
import Combine

struct Question: Identifiable, Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(question)
    }
    
    var id: UUID = UUID()
    var question: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var optionD: String?
    var answer: String?
    
}
