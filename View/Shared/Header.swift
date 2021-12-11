//
//  Header.swift
//  Speedreader
//
//  Created by Herman Christiansen on 25/10/2021.
//

import SwiftUI

struct Header: View {
    var title: String
    var height: CGFloat = 100
    
    var body: some View {
            VStack {
                ZStack{
                    Color.theme.secondary
                        .frame(width: UIScreen.main.bounds.width, height: height, alignment: .top)
                        .shadow(radius: 15)
                    //.clipShape(HeaderShape())
                    Text("\(title)")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 25)
                }
                Spacer()
            }
            .frame(alignment: .topLeading)
            .ignoresSafeArea()
            
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Practice", height: 120)
    }
}
