//
//  QuestionView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/01/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var questionnaireVM: QuestionnaireViewModel
    var firestoreManager: FirestoreManager = FirestoreManager()
    var question: Question
    @State var selectedOption: String = ""
    var initialTest: Bool = true
    @Binding var isActive: Bool
    @Environment(\.dismiss) private var dismiss
    
    func checkAnswer(){
        if selectedOption == question.answer{
            questionnaireVM.correctAnswers += 1
        }else{
            questionnaireVM.wrongAnswers += 1
        }
        
        let currentQuestionIndex = questionnaireVM.questions.firstIndex(where: {$0 == question})
        if currentQuestionIndex! + 1 < questionnaireVM.questions.count{
            questionnaireVM.currentQuestion = questionnaireVM.questions[currentQuestionIndex!+1]
        }else{
            let comprehensionScore = questionnaireVM.getComprehensionScore()
            if initialTest{
                firestoreManager.setComprehensionBefore(comprehensionBefore: comprehensionScore)
                appViewModel.activeFullScreenCover = nil
            }else{
                firestoreManager.setComprehensionAfter(comprehensionAfter: comprehensionScore)
                isActive = false
                dismiss()
            }
            
            print("nihao in the setcomprehensionscore")
        }
        
    }
    
    var body: some View {
        VStack{
            Text("\(question.question!)")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(height: screen.height * 0.13, alignment: .top)
            
            QuestionCellView(questionOption: question.optionA!, questionNumber: "A", selectedOption: $selectedOption, checkAnswer: checkAnswer)
                .padding(.bottom, screen.height*0.02)
            QuestionCellView(questionOption: question.optionB!, questionNumber: "B", selectedOption: $selectedOption, checkAnswer: checkAnswer)
                .padding(.bottom, screen.height*0.02)
                
            QuestionCellView(questionOption: question.optionC!, questionNumber: "C", selectedOption: $selectedOption, checkAnswer: checkAnswer)
                .padding(.bottom, screen.height*0.02)
                
            QuestionCellView(questionOption: question.optionD!, questionNumber: "D", selectedOption: $selectedOption, checkAnswer: checkAnswer)
                .padding(.bottom, screen.height*0.05)
            
//            // SUBMIT BUTTON
//            Button(action: checkAnswer, label: {
//                HStack{
//                    Spacer()
//                    Text("SUBMIT")
//                        .foregroundColor(.white)
//                        .font(.title3)
//                        .fontWeight(.bold)
//                        .padding()
//                    Spacer()
//                }
//                .background(Color.theme.accent)
//                .mask(
//                    RoundedRectangle(cornerRadius: 12, style: .continuous)
//                )
//            })
        } //: VSTACK
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(.white)
        .mask(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .padding(.horizontal, 10)
        //.padding(.vertical, 20)
        .shadow(radius: 5)
        .padding(.vertical, 10)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: Question(question: "Which statement would the author most likely disagree with?", optionA: "Honey badgers like to to eat honey", optionB: "Honey badgers might be the toughest animal.", optionC: "Honey badgers disguise their young to look like cheetah kittens.", optionD: "Honey badgers are not afraid to fight with humans.", answer: "Honey badgers disguise their young to look like cheetah kittens."), isActive: Binding.constant(true))
            
    }
}
