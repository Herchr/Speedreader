//
//  Questionnaire.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/01/2022.
//

import SwiftUI

struct Questionnaire: View {
    @StateObject var questionnaireVM: QuestionnaireViewModel = QuestionnaireViewModel()
    
    var setActiveItem: (ActiveFullScreenCover?) -> Void = { _ in }
    
    var initialTest: Bool = true
    
    var body: some View {
        VStack {
            QuestionProgress()
            Spacer()
            ScrollViewReader{ proxy in
                ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: -60){
                            ForEach(Constants.questions){ question in
                                QuestionView(question: question, setActiveItem: setActiveItem, initialTest: initialTest)
                                    .frame(width: UIScreen.main.bounds.width)
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
        .background(Color.theme.primary)
        .environmentObject(questionnaireVM)
        
    }
}

//struct Questionnaire_Previews: PreviewProvider {
//    static var previews: some View {
//        Questionnaire(showWPMTest: Binding.constant(true))
//    }
//}
