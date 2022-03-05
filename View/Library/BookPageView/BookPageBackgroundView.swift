//
//  BookPageBackgroundView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookPageBackgroundView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
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
                .frame(width: screen.width, height: screen.height*0.7)
                .shadow(radius: 6)
                .clipShape(RightRoundedRectangle(radius: 60))

        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct BookViewBackground_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
//        BookPageView(book: Binding.constant(bookExamples[0]), showBookView: Binding.constant(true), animation:ns)

        BookPageView(animation: ns)
            .environmentObject(LibraryViewModel())
    }
}
