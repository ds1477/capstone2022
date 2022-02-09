//
//  ContentView.swift
//  digid
//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color("deepRed").ignoresSafeArea(.all)
            VStack {
                        Text("digid")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                        Text("A Rutgers Digital ID")
                            .fontWeight(.light)
                            .foregroundColor(Color.white)
                    }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                
            
        }
    }
}
