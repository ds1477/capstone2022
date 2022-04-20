//
//  GymView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/19.
//

import SwiftUI

struct GymView: View {
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                VStack {
                    Text("College Ave Fitness Center: ")
                    .fontWeight(.black)
                    Text("Current: 115 | Max: 120")
                    Text("Percentage Filled: 96%")
                        .foregroundColor(Color.white)
                        .frame(width:200, height: 50)
                        .background(Color("Color"))
                        .cornerRadius(4)
                    Text("Werblin Recreation Center: ")
                    .fontWeight(.black)
                    Text("Current: 162 | Max: 150")
                    Text("Percentage Filled: 108%")
                        .foregroundColor(Color.white)
                        .frame(width:200, height: 50)
                        .background(Color("Color"))
                        .cornerRadius(4)
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

struct GymView_Previews: PreviewProvider {
    static var previews: some View {
        GymView()
    }
}
