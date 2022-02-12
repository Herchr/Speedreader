//
//  Auth.swift
//  Speedreader
//
//  Created by Herman Christiansen on 10/02/2022.
//

import SwiftUI
import FirebaseAuth

struct Authentication: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var editingEmail: Bool = false
    @State private var editingPassword: Bool = false
    
    var setActiveItem : (ActiveFullScreenCover?) -> Void
    
    func signup(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else{
                print(error!.localizedDescription)
                print("scooby")
                return
            }
            print("Created user")
        }
    }
    
    var body: some View {
        ZStack{
            Color.red   //Background
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Text("Sign Up")
                            .font(.largeTitle.bold())
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
                    .frame(height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.gray, lineWidth: 1.0)
                            //.blendMode(.overlay)
                    )
                    HStack {
                        Icon(iconName: "key.fill", isEditing: $editingPassword)
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                    }
                    .frame(height: 52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.gray, lineWidth: 1.0)
                            //.blendMode(.overlay)
                    )
                    .onTapGesture{
                        editingEmail = false
                        editingPassword = true
                    }

                    
                    HStack {
                        Button("Create account"){
                            signup()
                            setActiveItem(nil)
                        }
                        .foregroundColor(.white)
                        .frame(width: 320 , height: 50)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }
                .padding()
            } //: VSTACK
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
            )
            .padding()
        } //: ZSTACK
    }
}

struct Auth_Previews: PreviewProvider {

    static var previews: some View {
        Authentication(setActiveItem: {_ in })
    }
}
