//
//  LocationView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/01.
//

import SwiftUI

struct LocationView: View {
    
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                Spacer()
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
        .navigationBarTitle("Hidden Title")
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = true
        }
    }
}

struct DiningHallView: View {
    
    @State var buschMax: Int = 250
    @State var liviMax: Int = 250
    @State var browerMax: Int = 200
    @State var neilsonMax: Int = 300
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Werblin Fitness Center")
                Text("Livingston Fitness Center ")
                Text("College Avenue Fitness Center")
                Text("Cook-Douglass Fitness Center")
            }
        }
    }
}

struct GymView: View {
    
    @State var werblinFitnessMax: Int = 50
    @State var liviFitnessMax: Int = 30
    @State var collegeAveFitnessMax: Int = 40
    @State var cookDougFitnessMax: Int = 30
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Busch Dining Hall")
                Text("Livingston Dining Hall")
                Text("Brower Commons")
                Text("Neilson Dining Hall")
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
