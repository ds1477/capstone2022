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
            }
        }
    }
}

struct DiningHallView: View {
    var body: some View {
        Text("Hello, world")
    }
}

struct GymView: View {
    var body: some View {
        Text("Hello, world")
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
