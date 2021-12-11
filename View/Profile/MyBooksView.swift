//
//  MyBooksView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 01/10/2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct MyBooksView: View {
    @StateObject var downloadedBooksVM: DownloadedBookViewModel = DownloadedBookViewModel()
    @EnvironmentObject var currentBookVM: CurrentBookViewModel
    @State var showActionSheet: Bool = false
    @State var clickedBook: DownloadedBook?
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: -20), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing:0){
                ForEach(downloadedBooksVM.books, id: \.self.id){ book in
                    Image(uiImage: UIImage(data: book.img!)!)
                        .resizable()
                        .cornerRadius(15)
                        .frame(width: 120, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onTapGesture{
                            showActionSheet.toggle()
                            clickedBook = book
                            print("\(book.title!)")
                        }
                        .confirmationDialog(("\(clickedBook?.title ?? "sh")"), isPresented: $showActionSheet ){
                            Button("Set as current book"){
                                currentBookVM.setBook(entity: book)
                            }
                            Button("Delete", role: .destructive){
                                downloadedBooksVM.delete(entity: book)
                            }
                            
                            
                        }
                }
            }
            Spacer()
        }
        .onAppear{
            downloadedBooksVM.getBooks()
        }
    }
    
    func getConfirmation(entity: DownloadedBook) -> ActionSheet{
        //print("\(entity.title!) entity")
        let button1: ActionSheet.Button = .cancel()
        let button2: ActionSheet.Button = .default(Text("Set as current book"), action: {
            currentBookVM.setBook(entity: entity)
            
        })
        let button3: ActionSheet.Button = .destructive(Text("Delete"), action: {
            downloadedBooksVM.delete(entity: entity)
        })
        
        return ActionSheet(title: Text("\(entity.title!)"), buttons: [button1, button2, button3])
    }
}


@available(iOS 15.0, *)
struct MyBooksView_Previews: PreviewProvider {
    static var previews: some View {
        MyBooksView()
    }
}
