//
//  BookViewHeader.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookPageHeadView: View {
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    
    @EnvironmentObject var libraryVM: LibraryViewModel
    var rectangleSize: [CGFloat]
    var animation: Namespace.ID
    
    @State private var loadContent: Bool = false
    
    let screenHeight = screen.height
    let screenWidth = screen.width
    
    @State var downloaded: Bool = false
    
    
    var body: some View {
        //Image, Title, and Author
        VStack {
            HStack(alignment:.top){
                BookView(bookTitle: libraryVM.selectedBook.title, bookImg: libraryVM.selectedBook.img)
                    .scaleEffect(1.1)
                    .shadow(radius: 5, y: 3)
                    .matchedGeometryEffect(id: libraryVM.selectedBook.title, in: animation)
                    
                VStack(alignment: .center, spacing:0){
                    VStack(spacing: 5){
                        Text("\(libraryVM.selectedBook.title)")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Text("\(libraryVM.selectedBook.author)")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(width: screen.width * 0.5, height: screen.height*0.135)
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
                            .padding(.vertical, screen.height * 0.015)
                            .background(downloaded ? Color.gray : Color.theme.accent)
                            .cornerRadius(100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                    .blendMode(.overlay)
                            )
                            .shadow(color: downloaded ? Color.gray : Color.theme.accent, radius: 6, y: 3)
                            .scaleEffect(loadContent ? 1 : 0.5)
                            
                    }) //: BUTTON
                    .disabled(downloaded)
                } //: VSTACK
            } //: HSTACK
            .padding(.top, screen.height*0.025)
            .padding(.leading, 35)
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
        BookPageView(animation: ns)
            .environmentObject(LibraryViewModel())
    }
}
