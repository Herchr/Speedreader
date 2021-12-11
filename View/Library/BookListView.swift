//
//  BookView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 08/09/2021.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var bookListVM: BookListViewModel
    
    @Namespace var animation
    @State var showBookView: Bool = false
    @State var selectedBook: Book = Book()
    
    var columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: -20), count: 2)
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing:0) {
                    ForEach(bookListVM.books, id: \.self.title){ book in
                        Image(uiImage: ((book.img ?? UIImage(named: "A_Christmas_Carol"))!))
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .padding(.vertical, 20)
                            .matchedGeometryEffect(id: book.title, in: animation)
                            .onTapGesture{
                                withAnimation{
                                    selectedBook = book
                                    showBookView.toggle()
                                }
                            }
                    } //: FOREACH
                } //: LAZYVGRID
            } //: SCROLLVIEW
            //.headerPadding()
            .tabBarPadding()
            if showBookView{
                BookView(book: $selectedBook, showBookView: $showBookView, animation: animation)
            }
            
        } //: ZSTACK
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(bookListVM: BookListViewModel())
    }
}
