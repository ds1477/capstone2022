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
    
    var body: some View {
        VStack {
            NavigationView {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                Button("Logout") {
                    appState.hasOnboarded = false
                    signOut()
                }
                Button("Generate a QR Code") {
                    appState.hasOnboarded = false
                    qrGenerator()
                }
            }
            .navigationBarTitle("Hidden Title")
            .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear {
                self.isNavigationBarHidden = true
            }
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

private func qrGenerator() {
    let auth = Auth.auth()
    do {
        try auth.qrGenerator()
    } catch let qrGeneratorError as NSError {
        print("Error generating a QR COde: %@", qrGeneratorError)
    }
}
