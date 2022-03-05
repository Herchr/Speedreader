//
//  Questionnaire.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/01/2022.
//

import SwiftUI

struct Questionnaire: View {
    @StateObject var questionnaireVM: QuestionnaireViewModel = QuestionnaireViewModel()
    
    var initialTest: Bool = true
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            QuestionProgress()
            Spacer()
            ScrollViewReader{ proxy in
                ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 0){
                            ForEach(questionnaireVM.questions){ question in
                                QuestionView(question: question, initialTest: initialTest, isActive: $isActive)
                                    .frame(width: screen.width)
                                    .id(question)
                                
                            }.onChange(of: questionnaireVM.currentQuestion){ question in
                                withAnimation{
                                    proxy.scrollTo(question)
                                }
                            }
                        }
                    }
                    
            } //: SCROLLVIEWREADER
            .padding(.bottom)
        } //: VSTACK
        .background(LinearGradient(colors: [Color.theme.accent, Color.theme.pinkGradient], startPoint: .topLeading, endPoint: .bottomTrailing))
        .environmentObject(questionnaireVM)
        .onAppear{
            if initialTest{
                questionnaireVM.questions = Constants.honeyBadgerQuestions
            }else{
                questionnaireVM.questions = Constants.dodoQuestions
            }
        }
        
    }
}

struct Questionnaire_Previews: PreviewProvider {
    static var previews: some View {
        Questionnaire(initialTest: false, isActive: Binding.constant(true))
    }
}
