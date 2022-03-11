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
                .padding(.bottom, 50)
            }
            .overlay(
                VStack(spacing: 0) {
                    Spacer()
                    // Right gradient
                    LinearGradient(gradient:
                       Gradient(
                        colors: [Color.theme.background.opacity(0), Color.theme.background]),
                           startPoint: .top, endPoint: .bottom
                       )
                        .frame(width: screen.width, height: screen.height * 0.12)
                        
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
