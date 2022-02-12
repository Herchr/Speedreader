//
//  MyBooksView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import SwiftUI

struct MyBooksView: View {
    @StateObject var myBooksVM: MyBooksViewModel = MyBooksViewModel()
    @State var showActionSheet: Bool = false
    @State var clickedBook: DownloadedBook?
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: -40), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing:0){
                ForEach(myBooksVM.books, id: \.self.title){ book in
                    if let img = book.img{
                        Image(data: img, placeholder: "Beowulf")
                            .resizable()
                            .cornerRadius(8)
                            .frame(width: 130, height: 177, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .onTapGesture{
                                showActionSheet.toggle()
                                clickedBook = book
                            }
                            .padding(.bottom, 40)
                            .confirmationDialog(("\(clickedBook?.title ?? "")"), isPresented: $showActionSheet ){
                                Button("Set as current book"){
                                    if let clickedBook = clickedBook {
                                        //setBook(entity: clickedBook)
                                        myBooksVM.setActiveBook(book: clickedBook)
                                    }
                                }
                                Button("Delete", role: .destructive){
                                    if let clickedBook = clickedBook {
                                        myBooksVM.delete(entity: clickedBook)
                                    }
                                }
                            }
                    }
                }
            }
            Spacer()
        }
    }
}


struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        MyBooksView()
    }
}
