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
            HStack(alignment:.top){
                BookView(bookTitle: libraryVM.selectedBook.title, bookImg: libraryVM.selectedBook.img)
                    .scaleEffect(1.1)
                    .matchedGeometryEffect(id: libraryVM.selectedBook.title, in: animation)
                    
                VStack(alignment: .center, spacing:0){
                    VStack(spacing: 5){
                        Text("\(libraryVM.selectedBook.title)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Text("\(libraryVM.selectedBook.author)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(width: screen.width * 0.5, height: screen.height*0.16)
                    .padding(.horizontal, 5)
                    // DOWNLOAD BUTTON
                    DownloadButton(downloaded: $downloaded, loadContent: $loadContent)
                } //: VSTACK
            } //: HSTACK
            .padding(.top, screen.height*0.022)
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
}

struct BookViewHead_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
        BookPageView(animation: ns)
            .environmentObject(LibraryViewModel())
    }
}

struct DownloadButton: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    @Binding var downloaded: Bool
    @Binding var loadContent: Bool
    
    @State var downloading: Bool = false
    
    func animateDownload(){
        downloading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1..<1.5)) {
            withAnimation {
                downloading = false
                downloaded = true
            }
        }
    }
    var body: some View {
        Button(action: {
            animateDownload()
            if libraryVM.selectedBook.title.count > 0{
                coreDataManager.downloadBook(book: libraryVM.selectedBook)
            }
        }, label: {
            ZStack{
                if !downloading{
                    Text(downloaded ? "DOWNLOADED" : "DOWNLOAD")
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        
                }else{
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.white)
                }
            }
            .frame(width: 110)
            .padding(.horizontal, 10)
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
    }
}
