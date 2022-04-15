//
//  DiningHallView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/19.
//

import SwiftUI
import FirebaseDatabase

struct DiningHallView: View {
    
    @State var buschMax: Int = 250
    @State var buschCurrent: Int = 130
    @State var liviMax: Int = 250
    @State var liviCurrent: Int = 261
    @State var browerMax: Int = 200
    @State var browerCurrent: Int = 160
    @State var neilsonMax: Int = 300
    @State var neilsonCurrent: Int = 270
    @State var buschAvg: Int = 52
    @State var liviAvg: Int = 104
    @State var browerAvg: Int = 80
    @State var neilsonAvg: Int = 90
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Busch Dining Hall")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(buschMax)")
                    Text("Current Capacity: \(buschCurrent)")
                    Text("\(buschAvg)% filled")
                }
                Text("Livingston Dining Hall")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(liviMax)")
                    Text("Current Capacity: \(liviCurrent)")
                    Text("\(liviAvg)% filled")
                }
                Text("Brower Commons")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(browerMax)")
                    Text("Current Capacity: \(browerCurrent)")
                    Text("\(browerAvg)% filled")
                }
                Text("Neilson Dining Hall")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(neilsonMax)")
                    Text("Current Capacity: \(neilsonCurrent)")
                    Text("\(neilsonAvg)% filled")
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

struct DiningHallView_Previews: PreviewProvider {
    static var previews: some View {
        DiningHallView()
    }
}
