//
//  BookViewBackground.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookViewBackground: View {
    @Binding var book: Book
    var body: some View {
        ZStack(alignment: .top) {
//            Color(book.img?.getColors()?.background ?? .gray)
//                .overlay(
//                    Color.black.opacity(0.1)
//
            Color.white
            Image(uiImage: book.img!)
                .resizable()
                .scaledToFit()
                .opacity(0.9)
                .blur(radius: 6)
        }
        //.background(.regularMaterial)
    }
}

struct BookViewBackground_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
        BookView(book: Binding.constant(Constants().books[0]), showBookView: Binding.constant(true), animation:ns)
    }
}
