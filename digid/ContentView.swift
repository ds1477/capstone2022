//
//  ContentView.swift
//  digid
//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(netID: String, password: String) {
        auth.signIn(withEmail: netID + "@scarletmail.rutgers.edu", password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //Successful Login
                self?.signedIn = true
            }
        }
    }
    
    func signUp(firstName: String, lastName: String, netID: String, password: String) {
        auth.createUser(withEmail: netID + "@scarletmail.rutgers.edu", password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //Successful Login
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
}

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                //Will be Main Page with functionalities
                VStack {
                    Text("You are signed in")
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                       NavigationLink("Logout", destination: SignInView())
                            .cornerRadius(5)
                            .padding()
                    })
                }
            }
            else {
                SignInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var netID: String = ""
    @State private var password: String = ""
    @State var color = Color.black.opacity(0.7)
    
    
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
           
                VStack {
                    TextField("netID", text: $netID)
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
                        
                        viewModel.signIn(netID: netID, password: password)
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
}

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var netID: String = ""
    @State private var password: String = ""
    @State var color = Color.black.opacity(0.7)
    
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
           
                VStack {
                    TextField("First Name", text: $firstName)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.firstName != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    TextField("Last Name", text: $lastName)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.lastName != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    TextField("netID", text: $netID)
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
                        
                        viewModel.signUp(firstName: firstName, lastName: lastName, netID: netID, password: password)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


