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
    @State var liviFitnessCurrent: Int = 30
    @State var collegeAveFitnessMax: Int = 40
    @State var collegeAveFitnessCurrent: Int = 40
    @State var cookDougFitnessMax: Int = 40
    @State var cookDougFitnessCurrent: Int = 35
    
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

struct GymView_Previews: PreviewProvider {
    static var previews: some View {
        GymView()
    }
}
