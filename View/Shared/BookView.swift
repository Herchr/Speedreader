//
//  BookView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 13/02/2022.
//

import SwiftUI

struct BookView: View {
    var book: Book
    var body: some View {
        Image(uiImage: book.img ?? UIImage(systemName: "xmark")!)
            .resizable()
            .frame(width: screen.height*0.15, height: screen.height*0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(6)
            
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(book: bookExamples[0])
    }
}
