//
//  BookViewHeader.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookViewHead: View {
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    
    @EnvironmentObject var libraryVM: LibraryViewModel
    var rectangleSize: [CGFloat]
    var animation: Namespace.ID
    
    @State private var loadContent: Bool = false
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    @State var downloaded: Bool = false
    
    
    var body: some View {
        //Image, Title, and Author
        VStack {
            HStack(alignment:.top){
                if let img = libraryVM.selectedBook.img{
                    Image(uiImage: img)
                        .resizable()
                        //.scaledToFit()
                        //.aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 215)
                        .cornerRadius(10)
                        .shadow(radius: 10, x: 3, y: 8)
                        .padding(.leading, 35)
                        .matchedGeometryEffect(id: libraryVM.selectedBook.title, in: animation)
                        .onTapGesture{
                            withAnimation{
                                libraryVM.showBookView.toggle()
                            }
                        }
                }
                Spacer()
                VStack(alignment: .center, spacing:0){
                    VStack(spacing: 5){
                        Text("\(libraryVM.selectedBook.title)")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        Text("\(libraryVM.selectedBook.author)")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height*0.14)
                    .padding(.horizontal, 5)
                    // DOWNLOAD BUTTON
                    Button(action: {
                        downloaded = true
                        if libraryVM.selectedBook.title.count > 0{
                            coreDataManager.downloadBook(book: libraryVM.selectedBook)
                        }
                    }, label: {
                        Text(downloaded ? "DOWNLOADED" : "DOWNLOAD")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(downloaded ? Color.gray : Color.theme.accent)
                            .cornerRadius(100)
                            .shadow(color: Color.gray, radius: 5, x: 4, y: 4)
                            .scaleEffect(loadContent ? 1 : 0.5)
                    }) //: BUTTON
                    .disabled(downloaded)
                } //: VSTACK
            } //: HSTACK
            .padding(.top)
            .onAppear{
                if libraryVM.selectedBook.title.count > 0{
                    if coreDataManager.itemExists(title: libraryVM.selectedBook.title){
                        downloaded = true
                    }
                }
                withAnimation(.spring().delay(0.25)){
                    loadContent.toggle()
                }
        }
        }
        //.offset(x: rectangleSize[0]*0.08)
        
    }
}

struct BookViewHead_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
        BookView(animation: ns)
            .environmentObject(LibraryViewModel())
    }
}
