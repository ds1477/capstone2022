//
//  MainView.swift
//  digid
//
//  Created by Daniel Samojlik on 2/20/22.
//

import SwiftUI



struct MainView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Logout") {
            appState.hasOnboarded = false
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
