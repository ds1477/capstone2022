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
    @State public var showingAlert = false
  
    
    
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
                        
                        let auth = Auth.auth()
                        
                        let netID = netID.trimmingCharacters(in: .whitespacesAndNewlines)
                        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        auth.signIn(withEmail: netID, password: password) { (result, error) in
                            
                            guard error == nil else {
                                print("User not signed in.")
                                showingAlert = true
                                return
                            }
                            print("User signed in.")
                            appState.hasOnboarded = true
                        }
                        
                        
           /*             if Auth.auth().currentUser?.isEmailVerified == true {
                            appState.hasOnboarded = true
                        }
                        else {
                            showingAlert = true
                            Auth.auth().currentUser?.sendEmailVerification { (error) in
                                if let error = error {
                                    print("Failed to send verification.", error.localizedDescription)
                                    return
                                }
                            }
                        } */
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width:200, height: 50)
                            .background(Color("Color"))
                            .cornerRadius(4)
                    }).alert("The credentials you have provided are invalid.", isPresented: $showingAlert){
                        Button("OK", role: .cancel) {}
                    }
                    
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
    @State private var showingAlert = false
    
    var body: some View {
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
                    
                    Button(action: {
                        guard !netID.isEmpty, !password.isEmpty, isValidEmail(netID) == true else {
                            print("Failed to create an account.")
                            return
                        }
                        
                       signUp(netID: netID, password: password)
                       showingAlert = true
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width:200, height: 50)
                            .background(Color("Color"))
                            .cornerRadius(4)
                    }).alert("Account was successfully created! Please verify your email address before signing in.", isPresented: $showingAlert){
                        Button("OK", role: .cancel) {}
                    }
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

/* private func signIn(netID: String, password: String) {

    let auth = Auth.auth()
    
    let netID = netID.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
    
    auth.signIn(withEmail: netID, password: password) { (result, error) in
        
        guard error == nil else {
            print("User not signed in.")
            return
        }
    }
    print("User signed in.")
    
} */

private func signUp (netID: String, password: String) {
    
    let auth = Auth.auth()
    
    let netID = netID.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
    if netID.contains("@scarletmail.rutgers.edu") &&  isValidEmail(netID) == true {
        auth.createUser(withEmail: netID, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to create new user.", error.localizedDescription)
                return
            }
            let random = Int.random(in: 0...567848) + Int.random(in: 0...567848)
            let vcode = String(random)
            
            guard let uid = result?.user.uid else {return}
            
            let values = ["netID": netID, "VCode": vcode]
            
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

private func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
                     "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                     "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
                     "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
                     "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                     "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
                     "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
    return emailTest.evaluate(with: email)
}
