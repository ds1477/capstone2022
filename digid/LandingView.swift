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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Logout") {
            appState.hasOnboarded = false
            signOut()
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
