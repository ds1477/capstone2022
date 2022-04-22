//
//  LocationView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/01.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                Spacer()
                Image("dininghallpic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                NavigationLink(destination: DiningHallView(), label: {
                    Text("Dining Hall Capacitance")
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                    .background(Color("Color"))
                    .cornerRadius(4)
                })
                NavigationLink(destination: GymView(), label: {
                    Text("Gym Capacitance")
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                    .background(Color("Color"))
                    .cornerRadius(4)
                })
                Spacer()
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
