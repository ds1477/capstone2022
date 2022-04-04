//
//  GymView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/19.
//

import SwiftUI

struct GymView: View {
    
    @State var werblinFitnessMax: Int = 50
    @State var werblinFitnessCurrent: Int = 50
    @State var liviFitnessMax: Int = 30
    @State var liviFitnessCurrent: Int = 28
    @State var collegeAveFitnessMax: Int = 40
    @State var collegeAveFitnessCurrent: Int = 40
    @State var cookDougFitnessMax: Int = 40
    @State var cookDougFitnessCurrent: Int = 35
    @State var werblinFitnessAvg: Int = 100
    @State var liviFitnessAvg: Int = 93
    @State var collegeAveFitnessAvg: Int = 100
    @State var cookDougFitnessAvg: Int = 88
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Werblin Fitness Center")
                .fontWeight(.black)
                VStack {
                    Text("Maximum Capacity: \(werblinFitnessMax)")
                    Text("Current Capacity: \(werblinFitnessCurrent)")
                    Text("\(werblinFitnessAvg)% filled")
                }
                Text("Livingston Fitness Center ")
                .fontWeight(.black)
                VStack {
                    Text("Maximum Capacity: \(liviFitnessMax)")
                    Text("Current Capacity: \(liviFitnessCurrent)")
                    Text("\(liviFitnessAvg)% filled")
                }
                Text("College Avenue Fitness Center")
                .fontWeight(.black)
                VStack {
                    Text("Maximum Capacity: \(collegeAveFitnessMax)")
                    Text("Current Capacity: \(collegeAveFitnessCurrent)")
                    Text("\(collegeAveFitnessAvg)% filled")
                }
                Text("Cook-Douglass Fitness Center")
                .fontWeight(.black)
                VStack {
                    Text("Maximum Capacity: \(cookDougFitnessMax)")
                    Text("Current Capacity: \(cookDougFitnessCurrent)")
                    Text("\(cookDougFitnessAvg)% filled")
                }
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

struct GymView_Previews: PreviewProvider {
    static var previews: some View {
        GymView()
    }
}
