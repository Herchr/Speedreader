//
//  Auth.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/02/2022.
//

import SwiftUI
import FirebaseAuth

struct Authentication: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmail: Bool = false
    @State private var editingPassword: Bool = false
    @State private var rotation: Double = 0.0
    @State private var signupToggle: Bool = true
    
    func signup(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else{
                print(error!.localizedDescription)
                print("scooby")
                return
            }
            appViewModel.activeFullScreenCover = ActiveFullScreenCover.WPMText
            print("Created user")
        }
    }
    
    func signin(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            appViewModel.activeFullScreenCover = nil
            print("User logged in")
        }
    }
    
    var body: some View {
        ZStack{
            VStack {
                VStack {
                    HStack {
                        Text(signupToggle ? "Sign Up" : "Sign In")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    HStack {
                        Icon(iconName: "envelope.open.fill", isEditing: $editingEmail)
                            //.scaleEffect(editingEmail ? 1.2 : 1)
                        TextField("Email", text: $email){ isEditing in
                            editingEmail = isEditing
                            editingPassword = false
                        }
                        .textContentType(.emailAddress)
                    }
                    .frame(width: screen.width*0.7, height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(.linearGradient(colors: [.black.opacity(0.4), .black.opacity(0.2)], startPoint: .leading, endPoint: .bottom), lineWidth: 4)
                            .blendMode(.overlay)
                    )
                    HStack {
                        Icon(iconName: "key.fill", isEditing: $editingPassword)
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                    }
                    .frame(width: screen.width*0.7, height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(.linearGradient(colors: [.black.opacity(0.4), .black.opacity(0.2)], startPoint: .leading, endPoint: .bottom), lineWidth: 4)
                            .blendMode(.overlay)
                    )
                    .onTapGesture{
                        editingEmail = false
                        editingPassword = true
                    }
                    .padding(.bottom)
                    
                    
                        Button(action: {
                            if signupToggle{
                                signup()
                            }else{
                                signin()
                            }
                            
                        }, label: {
                            HStack {
                                Text(signupToggle ? "Create account" : "Sign In")
                                    .font(Font.title3.bold())
                            }
                            .frame(width: screen.width*0.7, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color.white)
                                    
                            )
                        })
                        .foregroundColor(Color.theme.text)
                        
                    
                    
                    
                    Divider()
                        .padding(.vertical, 5)
                    HStack(spacing: 0) {
                        Text(signupToggle ? "Already have an account? " : "Dont have an account? ")
                            .font(Font.caption)
                            .foregroundColor(.white)
                        Button(action: {
                            withAnimation{
                                rotation += 180.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.17) {
                                signupToggle.toggle()
                            }
                        }, label: {
                            Text(signupToggle ? "Sign in" : "Sign up")
                                .font(Font.caption.bold())
                                .foregroundColor(.white)
                        })
                        Spacer()
                    }
                    
                }
                .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
                .padding(screen.width*0.1)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(lineWidth: 4)
                        .foregroundStyle(.linearGradient(colors: [.white, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .blendMode(.overlay)
                )
                .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
                
            } //: VSTACK
            .padding()
            .background(
                Image("GuidedBG3")
                    .resizable()
                    .frame(width: screen.width, height: screen.height)
                    .ignoresSafeArea()
            )
            
        } //: ZSTACK
    }
}

struct Auth_Previews: PreviewProvider {

    static var previews: some View {
        Authentication()
            .environmentObject(AppViewModel())
    }
}
