//
//  MyBooksView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import SwiftUI

struct MyBooksView: View {
    @StateObject var myBooksVM: MyBooksViewModel = MyBooksViewModel()
    var coreDataManager: CoreDataManager = CoreDataManager.shared
    @State var showActionSheet: Bool = false
    @State var clickedBook: DownloadedBook?
    @State var showFiles: Bool = false
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: -40), count: 2)

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing:0){
                    ForEach(myBooksVM.books, id: \.self.title){ book in
                        if let img = book.img{
                            BookView(bookTitle: book.title ?? "", bookImg: UIImage(data: img))
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
                .padding(.top, 20)
            }
            Spacer()
        }
        .toolbar {
            Button {
                showFiles.toggle()
            } label: {
                ZStack{
                    Image(systemName:"plus")
                        .font(.system(size: 20))
                        .foregroundColor(Color(uiColor: .systemBlue))
                }
                .frame(width: 54, height: 54)
            }
            .frame(width: 54, height: 54)
        }
        .fileImporter(isPresented: $showFiles, allowedContentTypes: [.pdf]){ result in
            coreDataManager.uploadPDF(result: result)
            myBooksVM.refresh()
        }
    }
}


struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        MyBooksView()
    }
}
