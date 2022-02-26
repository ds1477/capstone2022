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
                Button("Generate a QR Code") {
                    qrState.hasOnboarded2 = false
                    
                }
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

