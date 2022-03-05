//
//  BookPageBodyView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookPageBodyView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    var rectangleSize: [CGFloat]
    
    var body: some View {
        VStack {
            HStack {
                Text("About")
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.theme.text)
                VStack{
                    Divider()
                }
            } //: HSTACK
            .padding([.leading, .top], 30)
            
            ScrollView {
                Text("\(libraryVM.selectedBook.about)")
                    .foregroundColor(Color.theme.text)
                .padding(30)
                .padding(.bottom, 40)
            }
            .overlay(
                VStack(spacing: 0) {
                    Spacer()
                    // Right gradient
                    LinearGradient(gradient:
                       Gradient(
                        colors: [Color.white.opacity(0), Color.white]),
                           startPoint: .top, endPoint: .bottom
                       )
                        .frame(height: screen.height * 0.1)
                }
             )
        }
    }
}

struct BookViewBody_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
//        BookPageView(book: Binding.constant(bookExamples[0]), showBookView: Binding.constant(true), animation:ns)

        BookPageView(animation: ns)
            .environmentObject(LibraryViewModel())
    }
}
