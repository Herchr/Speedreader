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
    
    @State var disabled: Bool = false
    // MARK: - BODY
    var body: some View {
        ZStack {
            if let img = rsvpVM.activeBook?.img{
                if !rsvpVM.isPlaying{
                    VStack(spacing:0){
                        Text("Practice")
                            .font(Font.largeTitle.bold())
                            .foregroundColor(.white)
                            //.padding(.bottom, 20)
                        ZStack {
                            //BookOnShelfView(bookTitle: "Siddhartha")
                            BookOnShelfView(bookTitle: rsvpVM.activeBook?.title ?? "", bookImg: UIImage(data: img))
                        }
                        Spacer()
                    }
                    //.padding(.top)
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
                        ProgressBarView(rsvpVM: rsvpVM)
                            .transition(.move(edge: .leading))
                    }
                    if !rsvpVM.isPlaying{
                        PlayStackView(rsvpVM: rsvpVM)
                            .padding(.vertical, 20)
                            .transition(.move(edge: .trailing))
                            .disabled(disabled)
                    }
                } //: VStack
                .tabBarPadding()
                .zIndex(1)
            }else{
                VStack {
                    Spacer()
                    Text("Download a book from the library to start reading.")
                        .font(Font.title.bold())
                    Spacer()
                }
            }
                
            
        } //:ZSTACK
        .navigationBarHidden(true)
        .onDisappear{
            print("\(rsvpVM.currentIndex)") // set to save currentIndex
        }
        .onChange(of: rsvpVM.isPlaying, perform: { newValue in
            if newValue{
                withAnimation(.spring()){
                    appViewModel.showTabBar = false
                    print("rsvp")
                }
            }else{
                withAnimation(.spring()){
                    appViewModel.showTabBar = true
                }
            }
        })
        .background(
            ZStack{
                if !rsvpVM.isPlaying && rsvpVM.activeBook?.img != nil{
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
        .onDisappear {
            disabled = true
        }
        .onAppear{
            disabled = false
        }
    }
}

// MARK: - PREVIEW
struct RSVPView_Previews: PreviewProvider {
    static var previews: some View {
        RSVPView(rsvpVM: RSVPViewModel())
            .environmentObject(AppViewModel())
    }
}
