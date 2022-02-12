//
//  QuestionnaireViewModel.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/01/2022.
//

import Foundation

class QuestionnaireViewModel: ObservableObject{
    @Published var currentQuestion: Question?
    var questions: [Question] = Constants.questions // Fetch fra CloudKit
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    
    
    func getCurrentQuestionIndex() -> Int{
        if let currentQuestion = currentQuestion {
            return questions.firstIndex(where: {$0 == currentQuestion})! + 1
        }
        return 1
    }
    
    func getComprehensionScore() -> Double{
        return Double(self.correctAnswers)/(Double(self.correctAnswers) + Double(self.wrongAnswers))
    }
}
