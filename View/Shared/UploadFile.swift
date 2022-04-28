//
//  UploadFile.swift
//  Speedreader
//
//  Created by Herman Christiansen on 18/03/2022.
//

import SwiftUI
import PDFKit

struct UploadFile: View {
    @State var show: Bool = false
    var coreDataManager: CoreDataManager = CoreDataManager.shared
    @ObservedObject var myBooksVM: MyBooksViewModel
    var body: some View {
        Button {
            show.toggle()
        } label: {
            ZStack{
                LinearGradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .mask(
                        Image(systemName:"square.and.arrow.up")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                    )
            }
        }
        .frame(width: 54, height: 54)
        .background(Rectangle().fill(Color.blue))
        .fileImporter(isPresented: $show, allowedContentTypes: [.pdf]){ result in
            coreDataManager.uploadPDF(result: result)
            myBooksVM.refresh()
        }
        
    }
}

struct UploadFile_Previews: PreviewProvider {
    static var previews: some View {
        UploadFile(myBooksVM: MyBooksViewModel())
    }
}
