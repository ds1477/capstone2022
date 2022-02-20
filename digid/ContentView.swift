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
        auth.signIn(withEmail: netID, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.global().async {
                //Successful Login
                self?.signedIn = true
            }
        }
    }
    
    func signUp(firstName: String, lastName: String, netID: String, password: String) {
        if netID.contains("@scarletmail.rutgers.edu") {
            auth.createUser(withEmail: netID, password: password) { [weak self] result, error in
                guard result?.user != nil, error == nil else {
                    //error
                    return
                }
                DispatchQueue.global().async {
                    //Successful Login
                    self?.signedIn = true
                }
            }
        }
        else {
            //alert to enter correct email addess
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.signedIn = false
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State var isNavigationBarHidden: Bool = true
    
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
        .navigationBarTitle("Hidden Title")
                     .navigationBarHidden(self.isNavigationBarHidden)
                     .onAppear {
                         self.isNavigationBarHidden = true
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
        .navigationBarTitle("Hidden Title")
                     .navigationBarHidden(self.isNavigationBarHidden)
                     .onAppear {
                         self.isNavigationBarHidden = true
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
           
                VStack { //todo have textfields clear once user lands on page
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
                        guard !firstName.isEmpty, !lastName.isEmpty, !netID.isEmpty, !password.isEmpty else {
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


