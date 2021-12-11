//
//  BookViewHeader.swift
//  Speedreader
//
//  Created by Herman Christiansen on 27/09/2021.
//

import SwiftUI

struct BookViewHead: View {
    var downloadedBookVM: DownloadedBookViewModel = DownloadedBookViewModel()
    @Binding var showBookView: Bool
    @Binding var book: Book
    var rectangleSize: [CGFloat]
    var animation: Namespace.ID
    
    @State private var loadContent: Bool = false
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    @State var downloaded: Bool = false
    
    
    var body: some View {
        //Image, Title, and Author
        HStack(alignment:.bottom, spacing:10){
            Image(uiImage: book.img!)
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 215)
                .cornerRadius(10)
                .shadow(radius: 10, x: 3, y: 8)
                .matchedGeometryEffect(id: book.title, in: animation)
            VStack(alignment:.leading, spacing:8){
                Group{
                    Text("\(book.title)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Text("\(book.author)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(white: 1, opacity: 0.9))
                }
                .offset( y: screenHeight*0.86 - rectangleSize[1])
                Spacer()
                
                // DOWNLOAD BUTTON
                Button(action: {
                    downloaded = true
                    downloadedBookVM.add(book: book)
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
                
                .offset(x: rectangleSize[0]*0.08, y: -rectangleSize[1]*0.1)
            } //: VSTACK
        } //: HSTACK
        .frame(width: screenWidth*0.88, height: screenHeight-rectangleSize[1]+screenHeight*0.09, alignment: .bottomLeading)
        .onAppear{
            if downloadedBookVM.itemExists(title: book.title){
                downloaded = true
            }
            withAnimation(.spring().delay(0.25)){
                loadContent.toggle()
            }
        }
        //.offset(x: rectangleSize[0]*0.08)
        
    }
}

struct BookViewHead_Previews: PreviewProvider {
    @Namespace static var ns
    static var previews: some View {
        BookView(book: Binding.constant(Constants().books[0]), showBookView: Binding.constant(true), animation:ns)
    }
}
