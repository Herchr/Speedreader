//
//  BookPageView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 08/09/2021.
//

import SwiftUI

struct FeaturedBookListView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    var animation: Namespace.ID
    var rows: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 0), count: 1)
    
    @State private var contentSize: CGSize = CGSize(width: 400, height: 0)
    var body: some View {
        ZStack{
            HStack {
                Spacer()
                Color.white
                    .frame(width: screen.width - 30, height: screen.height*0.33)
                    .opacity(0.3)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing:0) {
                    if let books = libraryVM.featuredBooks{
                        ForEach(books, id: \.self.id){ book in
                            VStack {
                                BookView(bookTitle: book.title, bookImg: book.img)
                                    .matchedGeometryEffect(id: book.title, in: animation)
                                Text("\(book.title)")
                                    .font(Font.caption.bold())
                                    .foregroundColor(Color.theme.text)
                                    .frame(width: screen.height*0.15, height: 20, alignment: .topLeading)
                            }
                            .onTapGesture{
                                withAnimation{
                                    libraryVM.selectedBook = book
                                    libraryVM.showBookView.toggle()
                                }
                            }
                            .padding(.trailing,20)
                        } //: FOREACH
                    }
                } //: LAZYHGRID
                .padding(.leading, 20)
            } //: SCROLLVIEW
            .background(
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        contentSize = geo.size
                    }
                    return Color.clear
                }
            )
            .frame(maxHeight: contentSize.width - 80)
            .padding(.leading, 32)
            //.headerPadding()
        } //: ZSTACK
    }
}

struct BookListView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        FeaturedBookListView(animation: animation)
            .environmentObject(LibraryViewModel())
    }
}

