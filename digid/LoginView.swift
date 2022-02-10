//
//  ContentView.swift
//  digid
//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Color("deepRed").ignoresSafeArea(.all)
            VStack(spacing: 0) {
                        Text("digid")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                        Text("A Rutgers Digital ID")
                                .fontWeight(.light)
                                .foregroundColor(Color.white)
                            Spacer()
            }
        }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                
            
        }
    }
}
}
