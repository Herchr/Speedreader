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
    
    var body: some View {
        Button(action: {
            withAnimation{
                selectedOption = questionOption
            }
        }, label: {
            HStack {
                Text("\(questionNumber).")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(questionOption == selectedOption ? .white : Color.theme.text)
                    .padding(.leading)
                Text("\(questionOption)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(questionOption == selectedOption ? .white : Color.theme.text)
                    .padding(.vertical)
                Spacer()
            }
            .background(
                ZStack{
                    if questionOption == selectedOption{
                        Capsule()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.theme.accent, Color.theme.accentGradient]), startPoint: .leading, endPoint: .trailing)
                            )
                    }else{
                        Capsule()
                            .stroke(lineWidth: 5)
                            .foregroundColor(Color(.gray))
                    }
                }
            )
            .padding(.horizontal, 25)
        })
    }
}

struct QuestionCellView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCellView(questionOption: "Mount Everest", questionNumber: "A", selectedOption: Binding.constant("Mount Evrest"))
    }
}
