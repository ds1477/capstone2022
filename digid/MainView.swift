//
//  ContentView.swift
//  digid
//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Text("digid")
                    .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 1.0))
                            .padding()
                }.background(Color.red).ignoresSafeArea(.all)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
            
        }
    }
}
