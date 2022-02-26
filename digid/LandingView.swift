//
//  LandingView.swift
//  digid
//
//  Created by Daniel Samojlik on 2/20/22.
//

import SwiftUI
import FirebaseAuth

struct LandingView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var qrState: QRState
    
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                Button(action: {
                    
                    
                    appState.hasOnboarded = true
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width:200, height: 50)
                        .background(Color("Color"))
                        .cornerRadius(4)
                })
                Button("Logout") {
                    appState.hasOnboarded = false
                    signOut()
                }
                
            }
            
        }
        .navigationBarTitle("Hidden Title")
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = true
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

private func signOut() {
    let auth = Auth.auth()
    do {
        try auth.signOut()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
}

