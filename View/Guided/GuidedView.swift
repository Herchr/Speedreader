//
//  GuidedView.swift
//  Speedreader
//
//  Created by Herman Christiansen on 14/10/2021.


import SwiftUI

struct GuidedView: View {
    @ObservedObject var rsvpVM: RSVPViewModel
    @ObservedObject var kineticVM: KineticViewModel
    @StateObject var guidedVM: GuidedViewModel = GuidedViewModel()
    @EnvironmentObject var globalVM: AppViewModel
    var firestoreManager: FirestoreManager = FirestoreManager()
    
    @State var inFocus: Bool = false
    @State var kinetic: Bool = true
    //@State var countdownFinished = false
    
    func startGuided(sessionType: SessionType){
        guidedVM.sessionType = sessionType
        withAnimation{
            guidedVM.started = true
            globalVM.showTabBar = false
            print("guided")
        }
        if sessionType == SessionType.RSVP{
            //guidedVM.initialSpeed = rsvpVM.wpm // ENDRE DENNE TIL FETCH FRA FIREBASE
            rsvpVM.start()
            // TRIGGER FIRST CONTINUE POPUP
            delay(seconds: guidedVM.timeInterval){
                rsvpVM.stop()
//                DispatchQueue.main.async {
//                    rsvpVM.stopTimer()
//                }
                withAnimation(.spring()){
                    guidedVM.showContinuePopUp = true
                }
            }
        }else{
            //guidedVM.initialSpeed = kineticVM.wpm
            delay(seconds: 1){
                kineticVM.toggleIsPlaying()
                
                // TRIGGER FIRST CONTINUE POPUP
                delay(seconds: guidedVM.timeInterval){
                    if guidedVM.started{
                        DispatchQueue.main.async {
                            kineticVM.toggleIsPlaying()
                        }
                        delay(seconds: guidedVM.popUpPause){
                            withAnimation(.spring()){
                                guidedVM.showContinuePopUp = true
                            }
                        }
                    }
                }
            }
        }
    }

    var body: some View {
        ZStack {
            //Text("\(kineticVM.wpm)")
            if guidedVM.started{
                VStack{
                    //CLOSE BUTTON
                    HStack {
                        Button(action: {
                            guidedVM.endPrematurely()
                            if guidedVM.sessionType == SessionType.RSVP{
                                rsvpVM.stop()
                            }else{
                                kineticVM.toggleIsPlaying()
                            }
                            delay(seconds: 0.2){
                                withAnimation(.spring()){
                                    globalVM.showTabBar = true
                                }
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color.theme.text)
                        })
                            .frame(width: 44, height: 44)
                            .padding([.top, .leading])
                        Spacer()
                    }
                    Spacer()
                    if guidedVM.sessionType == SessionType.RSVP{
                        RSVPTextView(rsvpVM: rsvpVM)
                    }else{
                        KineticTextView(kineticVM: kineticVM)
                    }
                    Spacer()
                }
                .transition(.move(edge: .bottom))
            }else{
                if guidedVM.showCompleteScreen{
                    CompletedView()
                        .ignoresSafeArea()
                        .transition(.move(edge: .bottom))
                }else{
                    ZStack {
                        VStack {
                            HStack {
                                Text("Guided")
                                    .font(Font.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .padding(.leading)
                            
                            Spacer()
                        }
                        VStack {
                            Spacer()
                            Button {
                                startGuided(sessionType: SessionType.KINETIC)
                                firestoreManager.setTechnique(technique: "Kinetic")
                            } label: {
                                VStack {
                                    HStack {
                                        Text("Moving underline")
                                            .font(Font.title.bold())
                                            .kerning(2)
                                            //.padding(.vertical, 15)
                                            //.padding(.horizontal, 15)
                                            .foregroundColor(Color.white)
                                    } //: HSTACK
                                    Divider()
                                    Image("Kinetic_Illustration")
                                        .frame(height: screen.height*0.12)
                                        .scaleEffect(0.85)
                                } //: VSTACK
                            }
                            .frame(width: screen.width * 0.8)
                            .padding()
                            .padding(.vertical, 10)
//                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 35, style: .continuous))
                            .background(ZStack {
                                BlurView(style: .systemUltraThinMaterialDark)
                            })
                            .mask(RoundedRectangle(cornerRadius: 35, style: .continuous))
                            .shadow(radius: 8, x: 4, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 35, style: .continuous)
                                    .stroke(Color.white, lineWidth: 1)
                                    .blendMode(.overlay)
                            )
                            .overlay(ZStack {
                                if !kinetic{
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: screen.width * 0.8)
                                }
                            }
                            )
                            .padding(.bottom, screen.height * 0.025)
                            .disabled(!kinetic)
                            
                            Button {
                                startGuided(sessionType: SessionType.RSVP)
                                firestoreManager.setTechnique(technique: "RSVP")
                            } label: {
                                VStack {
                                    HStack {
                                        Text("Word sequence")
                                            .font(Font.title.bold())
                                            .kerning(2)
                                            //.padding(.vertical, 15)
                                            //.padding(.horizontal, 25)
                                            .foregroundColor(Color.white)
                                    } //: HSTACK
                                    Divider()
                                    Image("RSVP_Illustration")
                                        .frame(height: screen.height*0.12)
                                } //: VSTACK
                            }
                            .frame(width: screen.width * 0.8)
                            .padding()
                            .padding(.vertical, 10)
//                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 35, style: .continuous))
                            .background(ZStack {
                                BlurView(style: .systemUltraThinMaterialDark)
                            })
                            .mask(RoundedRectangle(cornerRadius: 35, style: .continuous))
                            .shadow(radius: 8, x: 4, y: 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 35, style: .continuous)
                                    .stroke(Color.white, lineWidth: 1)
                                    .blendMode(.overlay)
                            )
                            .overlay(ZStack {
                                if kinetic{
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: screen.width * 0.8)
                                }
                            }
                            )
                            .disabled(kinetic)
                        Spacer()
                        }
                        
                    }
                }
            }
            
            //Popup
            if guidedVM.showContinuePopUp && guidedVM.started{
                ContinuePopUpView(guidedVM: guidedVM, rsvpVM: rsvpVM, kineticVM: kineticVM)
                    .transition(.move(edge: .bottom))
            }
        } //: ZSTACK
        //.tabBarPadding(started: guidedVM.started)
        .background(
            ZStack{
                if !guidedVM.started{
                    Image("GuidedBGCircles")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        //.frame(width: screen.width, height: screen.height)
                        .ignoresSafeArea()
                }
            }
            
        )
        .task{
            let wpm = await (firestoreManager.getWPMBefore() ?? 0)
            guidedVM.initialSpeed = wpm
            rsvpVM.wpm = wpm
            kineticVM.wpm = wpm
            let technique = await firestoreManager.getTechniqueGroup()
            if technique == "R"{
                kinetic = false
            }
        }
    }
}

struct GuidedView_Previews: PreviewProvider {
    static var previews: some View {
        GuidedView(rsvpVM: RSVPViewModel(), kineticVM: KineticViewModel(), guidedVM: GuidedViewModel()).environmentObject(AppViewModel())
    }
}
