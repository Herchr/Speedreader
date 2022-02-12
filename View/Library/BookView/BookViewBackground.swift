//
//  BookViewBackground.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookViewBackground: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    let rectangleSize = [UIScreen.main.bounds.width, UIScreen.main.bounds.height * 0.70]
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image(data: libraryVM.selectedBook.img?.pngData(), placeholder: "Beowulf")
                    .resizable()
                    .scaledToFit()
                    .blur(radius: 10)
                    .scaleEffect(1.05)
                    
                    
                Spacer()
            }
            Color.theme.background
                .frame(width: rectangleSize[0], height: rectangleSize[1])
                .shadow(radius: 6)
                .clipShape(RightRoundedRectangle(radius: 60))

        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct BookViewBackground_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
//        BookView(book: Binding.constant(bookExamples[0]), showBookView: Binding.constant(true), animation:ns)

        BookView(animation: ns)
            .environmentObject(LibraryViewModel())
    }
}
