//
//  BookView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 19/09/2021.
//

import SwiftUI

struct BookView: View {
    @Binding var book: Book
    @Binding var showBookView: Bool
    var animation: Namespace.ID
    
    @State private var loadContent: Bool = false
    
    let rectangleSize = [UIScreen.main.bounds.width, UIScreen.main.bounds.height * 0.70]
    
    var body: some View {
        ZStack(alignment:.top){
            
            
            BookViewBackground(book: $book)
                .zIndex(1)
            VStack(alignment:.trailing){
                BookViewHead(showBookView: $showBookView, book: $book, rectangleSize: rectangleSize, animation: animation)
                    .onTapGesture{
                        showBookView = false
                    }
                BookViewBody(book: $book, rectangleSize: rectangleSize)
                    .frame(height: loadContent ? nil : 0)
                    .opacity(loadContent ? 1 : 0)
                Spacer()
            } //: VSTACK
            .background(Color.white
                            .frame(width: rectangleSize[0], height: rectangleSize[1])
                            .clipShape(RightRoundedRectangle(radius: 60))
                            , alignment: .bottom)
            .zIndex(2)
            
            BookViewBackButton(showBookView: $showBookView)
                .zIndex(3)
            
        } //: ZSTACK
        .ignoresSafeArea()
        .onAppear{
            withAnimation(.spring().delay(0.3)){
                loadContent.toggle()
            }
        }
    }
}

struct RightRoundedRectangle: Shape{
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            
            let tl = CGPoint(x: radius, y: 0)
            let tr = CGPoint(x: rect.width, y: 0)
            let br = CGPoint(x: rect.width, y: rect.height)
            let bl = CGPoint(x: 0, y: rect.height)
            let cb = CGPoint(x: 0, y: radius)
            let cc = CGPoint(x: radius, y: radius)

            path.move(to: tl)
            path.addLine(to: tr)
            path.addLine(to: br)
            path.addLine(to: bl)
            path.addLine(to: cb)
            path.addArc(center: cc, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        }
    }
}
//
struct BookView_Previews: PreviewProvider {
    @Namespace static var ns
    
    static var previews: some View {
        BookView(book: Binding.constant(Constants().books[0]), showBookView: Binding.constant(true), animation:ns)
    }
}



