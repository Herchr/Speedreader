//
//  BookPageBackButtonView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 31/10/2021.
//

import SwiftUI

struct BookPageBackButtonView: View {
    @EnvironmentObject var libraryVM: LibraryViewModel
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation{
                    libraryVM.showBookView = false
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 10, height: 14)
                    .foregroundColor(.white)
                    .padding()
            })
            Spacer()
        }
    }
}

struct BookPageBackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BookPageBackButtonView()
    }
}
