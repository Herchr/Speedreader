//
//  QuestionView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/01/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var questionnaireVM: QuestionnaireViewModel
    var firestoreManager: FirestoreManager = FirestoreManager()
    var question: Question
    @State var selectedOption: String = ""
    
    var setActiveItem: (ActiveFullScreenCover?) -> Void
    
    var initialTest: Bool = true
    
    func checkAnswer(){
        if selectedOption == question.answer{
            questionnaireVM.correctAnswers += 1
        }else{
            questionnaireVM.wrongAnswers += 1
        }
        
        let currentQuestionIndex = Constants.questions.firstIndex(where: {$0 == question})
        if currentQuestionIndex! + 1 < Constants.questions.count{
            questionnaireVM.currentQuestion = Constants.questions[currentQuestionIndex!+1]
        }else{
            let comprehensionScore = questionnaireVM.getComprehensionScore()
            if initialTest{
                firestoreManager.setComprehensionBefore(comprehensionBefore: comprehensionScore)
                setActiveItem(nil)
            }else{
                firestoreManager.setComprehensionAfter(comprehensionAfter: comprehensionScore)
            }
            
            print("nihao in the setcomprehensionscore")
        }
        
    }
    
    var body: some View {
        VStack{
            Text("\(question.question!)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(30)
                .padding(.bottom, 40)
                .fixedSize(horizontal: false, vertical: true)
            
            
            QuestionCellView(questionOption: question.optionA!, questionNumber: "A", selectedOption: $selectedOption)
                .padding(.bottom, 10)
            QuestionCellView(questionOption: question.optionB!, questionNumber: "B", selectedOption: $selectedOption)
                .padding(.bottom, 10)
            QuestionCellView(questionOption: question.optionC!, questionNumber: "C", selectedOption: $selectedOption)
                .padding(.bottom, 10)
            QuestionCellView(questionOption: question.optionD!, questionNumber: "D", selectedOption: $selectedOption)
                .padding(.bottom, 10)
            
            // SUBMIT BUTTON
            Button(action: checkAnswer, label: {
                HStack{
                    Spacer()
                    Text("SUBMIT")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.mint]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .padding(25)
            })
        } //: VSTACK
        
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
        .shadow(radius: 10)
    }
}

//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView(question: Question(question: "Hva heter verdens tredje høyeste fjell?", optionA: "Mount Everest", optionB: "Kanchenchunga", optionC: "K2", optionD: "Aconcagua", answer: "Kanchenchunga"), showWPMTest: Binding.constant(true))
//    }
//}
