//
//  LoginView.swift
//  digid
//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase


struct LoginView: View {
    
    @EnvironmentObject var appState: AppState
    @State var showForgotPassword = false
    
    @State private var netID: String = ""
    @State private var password: String = ""
    @State var color = Color.black.opacity(0.7)
    @State var isNavigationBarHidden: Bool = true
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
           
                VStack { //todo have textfields clear once user lands on page
                    TextField("netID@scarletmail.rutgers.edu", text: $netID)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.netID != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    HStack {
                        Spacer()
                        Button (action: {
                            showForgotPassword.toggle()
                        }, label: {
                            Text("Forgot Password?")
                        })
                            .font(.system(size: 14))
                            .sheet(isPresented: $showForgotPassword) {
                                ForgotPasswordView()
                            }

                    }
                    
                    Button(action: {
                        guard !netID.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        signIn(netID: netID, password: password)
                        appState.hasOnboarded = true
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width:200, height: 50)
                            .background(Color("Color"))
                            .cornerRadius(4)
                    })
                    NavigationLink("Create an Account", destination: SignUpView())
                        .padding()
                }
                .padding()
                
                Spacer()
            }
        }
        .navigationBarTitle("Hidden Title")
                     .navigationBarHidden(self.isNavigationBarHidden)
                     .onAppear {
                         self.isNavigationBarHidden = true
                     }
    }
}

struct SignUpView: View {
    
    @EnvironmentObject var appState: AppState
    @State private var netID: String = ""
    @State private var password: String = ""
    @State var color = Color.black.opacity(0.7)
    
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
           
                VStack { //todo have textfields clear once user lands on page
                    
                    TextField("netID@scarletmail.rutges.edu", text: $netID)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.netID != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    Button(action: {
                        guard !netID.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                       signUp(netID: netID, password: password)
                        appState.hasOnboarded = true
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width:200, height: 50)
                            .background(Color("Color"))
                            .cornerRadius(4)
                    })
                }
                .padding()
                
                Spacer()
        }
    }
}

struct ForgotPasswordView: View {
    @State private var netID: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var alertIsPresented = false
    
    var body: some View {
        //TODO: Password Reset View with Email Link to send password reset
        VStack {
           Text("Password Reset")
                .font(.title)
                .padding(.horizontal, 16)
                .foregroundColor(Color("Color"))
            
            TextField("netID@scarletmail.rutgers.edu", text: $netID)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.netID != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                .frame(width: 350)
            
            
                Button("Send Password Reset") {
                    passwordReset(netID: netID)
                    presentationMode.wrappedValue.dismiss()
                    self.alertIsPresented = true
                }
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                    .background(Color("Color"))
                    .cornerRadius(4)
                    .alert(isPresented: $alertIsPresented, content: {
                        Alert(title: Text("Reset Password Verification"), message: Text("A link has been sent to your email to reset your password."), dismissButton: .default(Text("Got it!")))
                    })
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
       LoginView()
    }
}

private func signIn(netID: String, password: String) {
    
    let auth = Auth.auth()
    
    let netID = netID.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
    
    auth.signIn(withEmail: netID, password: password) { (result, error) in
        
        if let error = error {
            print("Failed to sign in.", error.localizedDescription)
            return
        }
    }
}

private func signUp (netID: String, password: String) {
    
    let auth = Auth.auth()
    
    let netID = netID.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if netID.contains("@scarletmail.rutgers.edu") {
        auth.createUser(withEmail: netID, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to create new user.", error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else {return}
            
            let values = ["netID": netID]
            
            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                if let error = error {
                    print("Failed to update database.", error.localizedDescription)
                    return
                }
                
                print("Successfully signed user up.")
                
            }
        }
        
    }
    else {
        //alert to enter correct email addess
    }
}

private func passwordReset(netID: String) {
    let auth = Auth.auth()
    
    auth.sendPasswordReset(withEmail: netID) {(error) in
        if let error = error {
            print("Failed to send reset password link.", error.localizedDescription)
            return
        }
        print("Successfully sent reset password link.")
    }
}
