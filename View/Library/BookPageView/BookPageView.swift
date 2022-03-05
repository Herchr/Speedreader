//
//  BookPageView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 19/09/2021.
//

import SwiftUI

struct BookPageView: View {
    var animation: Namespace.ID
    @EnvironmentObject var libraryVM: LibraryViewModel
    
    @State private var loadContent: Bool = false
    let rectangleSize = [screen.width, 200]//screen.height * 0.70]
    
    var body: some View {
        ZStack(alignment:.top){
            BookPageBackgroundView()
                .ignoresSafeArea()
            
            VStack{
                BookPageBackButtonView()
                BookPageHeadView(rectangleSize: rectangleSize, animation: animation)
                    .environmentObject(libraryVM)
                    
                BookPageBodyView(rectangleSize: rectangleSize)
                    .frame(height: loadContent ? nil : 0)
                    .opacity(loadContent ? 1 : 0)
            } //: VSTACK
            //.padding(.top, 45)
            
        } //: ZSTACK
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

struct BookPageView_Previews: PreviewProvider {
    @Namespace static var ns

    static var previews: some View {
//        BookPageView(book: Binding.constant(bookExamples[0]), showBookView: Binding.constant(true), animation:ns)

        BookPageView(animation: ns)
            .environmentObject(LibraryViewModel())
    }
}



