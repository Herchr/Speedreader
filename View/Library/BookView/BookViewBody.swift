//
//  BookViewBody.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookViewBody: View {
    @Binding var book: Book
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
                Text("\(book.about)")
                    .foregroundColor(Color.theme.text)
                .padding(30)
            }
        }
    }
}

//struct BookViewBody_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView(book: BookViewModel(book: Constants.books[0]))
//    }
//}
