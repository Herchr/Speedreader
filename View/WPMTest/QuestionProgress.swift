//
//  QuestionProgress.swift
//  Speedreader
//
//  Created by Herman Christiansen on 29/01/2022.
//

import SwiftUI

struct QuestionProgress: View {
    @EnvironmentObject var questionnaireVM: QuestionnaireViewModel
    
    func getImageName(i: Int, currentQuestionIndex: Int) -> String{
        var imageName: String = ""
        if i == currentQuestionIndex{
            imageName = "\(i).circle.fill"
        }else if i > currentQuestionIndex{
            imageName = "\(i).circle"
        }else{
            imageName = "checkmark.circle"
        }
        
        return imageName
    }
    
    var body: some View {
        HStack{
            ForEach(1...questionnaireVM.questions.count, id: \.self){ i in
                Image(systemName: getImageName(i: i, currentQuestionIndex: questionnaireVM.getCurrentQuestionIndex()))
                    .resizable()
                    .frame(minWidth: 0, idealWidth: 35, maxWidth: 35, minHeight: 0, idealHeight: 35, maxHeight: 35)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct QuestionProgress_Previews: PreviewProvider {
    static var previews: some View {
        QuestionProgress()
            .environmentObject(QuestionnaireViewModel())
    }
}
