//
//  RSVPView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/09/2021.
//

import SwiftUI

struct RSVPView: View {
    // MARK: - PROPERTIES
    @ObservedObject var rsvpVM: RSVPViewModel
    @StateObject var firestoreManager: FirestoreManager = FirestoreManager()
    
    init(vm: RSVPViewModel){
        self.rsvpVM = vm
    }
    
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            rsvpVM.showSpeedPopOver ? AnyView(SpeedPopOverView(rsvpVM: rsvpVM).zIndex(4).edgesIgnoringSafeArea(.vertical)) : AnyView(Color.clear)
            //Header(title: "Practice")
            
            VStack{
                Text("Practice")
                    .font(Font.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                ZStack {
                    Image(data:rsvpVM.activeBook?.img, placeholder: "Beowulf")
                        .resizable()
                        .frame(width: 120, height: 160)
                        .cornerRadius(6)
                }
                .padding(30)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(.linearGradient(colors: [.white.opacity(0.8),  .clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                        .blendMode(.overlay)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(.linearGradient(colors: [.gray.opacity(0.4), .clear], startPoint: .bottomTrailing, endPoint: .topLeading), lineWidth: 0.5)
                )
                Spacer()
            }
            .padding(.top)
            
            //Text
            RSVPTextView(rsvpVM: rsvpVM)
                .padding(20)
                .frame(width: UIScreen.main.bounds.width / 1.1)
                .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                
            VStack{
                Spacer()
                ProgressBarView(percentage: 0.37)
                PlayStackView(rsvpVM: rsvpVM)
                    .padding(.vertical, 20)
            } //: VStack
            .tabBarPadding()
        } //:ZSTACK
        .navigationBarHidden(true)
        .onDisappear{
            print("\(rsvpVM.currentIndex)") // set to save currentIndex
        }
        .background(
            BlobView()
        )
    }
}

// MARK: - PREVIEW
struct RSVPView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(vm: RSVPViewModel())
    }
}
