//
//  QuestionCellView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 28/01/2022.
//

import SwiftUI

struct QuestionCellView: View {
    var questionOption: String
    var questionNumber: String
    @Binding var selectedOption: String
    var checkAnswer: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation{
                selectedOption = questionOption
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.25){
                checkAnswer()
            }
            
        }, label: {
            HStack {
                Text("\(questionNumber).")
                    .font(.title3.bold())
                    .foregroundColor(questionOption == selectedOption ? .white : Color.theme.text)
                    .padding(.leading)
                Text("\(questionOption)")
                    .font(.body.bold())
                    .foregroundColor(questionOption == selectedOption ? .white : Color.theme.text)
                    .multilineTextAlignment(.leading)
                    //.padding(.vertical)
                Spacer()
            }
            .frame(height: screen.height*0.1)
            .background(
                ZStack{
                    if questionOption == selectedOption{
                        Capsule()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.theme.accent, Color.theme.accent]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }else{
                        Capsule()
                            .stroke(lineWidth: 3)
                            .foregroundColor(Color.black.opacity(0.1))
                    }
                }
            )
            //.frame(height: 100)
        })
    }
}

struct QuestionCellView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCellView(questionOption: "Mount Everest", questionNumber: "A", selectedOption: Binding.constant("Mount Everest"), checkAnswer: {})
    }
}
