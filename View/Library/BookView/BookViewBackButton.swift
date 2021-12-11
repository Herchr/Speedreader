//
//  BookViewBackButton.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/10/2021.
//

import SwiftUI

struct BookViewBackButton: View {
    @Binding var showBookView: Bool
    var body: some View {
        HStack{
            Button(action: {
                withAnimation{
                    showBookView.toggle()
                }
                print("pressed")
            }, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 10, height: 20, alignment: .center)
                    .foregroundColor(.white)
            })
                .padding()
                .padding(.top, 15)
            Spacer()
        }
    }
}

struct BookViewBackButton_Previews: PreviewProvider {
    static var previews: some View {
        BookViewBackButton(showBookView: Binding.constant(true))
    }
}
