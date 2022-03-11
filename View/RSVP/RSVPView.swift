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
    @EnvironmentObject var appViewModel: AppViewModel
    // MARK: - BODY
    var body: some View {
        ZStack {
            if !rsvpVM.isPlaying{
                VStack{
                    Text("Practice")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    ZStack {
                        Image(data:rsvpVM.activeBook?.img, placeholder: "Beowulf")
                            .resizable()
                            .frame(width: 100, height: 130)
                            .cornerRadius(6)
                    }
                    .padding(22)
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
                .transition(.move(edge: .top))
                .zIndex(1)
            }
            
            //Text
            if rsvpVM.isPlaying{
                Button {
                    DispatchQueue.main.async {
                        withAnimation(.spring()) {
                            rsvpVM.stop()
                        }
                    }
                } label: {
                    Color.clear
                        .ignoresSafeArea()
                }
                .zIndex(1)
            }
            RSVPTextView(rsvpVM: rsvpVM)
                .padding(20)
                .frame(width: screen.width / 1.1)
                //.background(Color.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                
            
                VStack{
                    Spacer()
                    if !rsvpVM.isPlaying{
                        ProgressBarView(percentage: 0.37)
                            .transition(.move(edge: .leading))
                    }
                    if !rsvpVM.isPlaying{
                        PlayStackView(rsvpVM: rsvpVM)
                            .padding(.vertical, 20)
                            .transition(.move(edge: .trailing))
                    }
                } //: VStack
                .tabBarPadding()
                .zIndex(1)
                
            
        } //:ZSTACK
        .navigationBarHidden(true)
        .onDisappear{
            print("\(rsvpVM.currentIndex)") // set to save currentIndex
        }
        .onChange(of: rsvpVM.isPlaying, perform: { newValue in
            if newValue{
                withAnimation(.spring()){
                    appViewModel.showTabBar = false
                }
            }else{
                withAnimation(.spring()){
                    appViewModel.showTabBar = true
                }
            }
        })
        .background(
            ZStack{
                if !rsvpVM.isPlaying{
                    BlobView()
                        .transition(.move(edge: .top))
                        .zIndex(1)
                }
            }
        )
        .overlay(
            ZStack{
                if rsvpVM.showSpeedPopOver{
                    SpeedPopOverView(rsvpVM: rsvpVM)
                }
            }
        )
    }
}

// MARK: - PREVIEW
struct RSVPView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(rsvpVM: RSVPViewModel())
            .environmentObject(AppViewModel())
    }
}
