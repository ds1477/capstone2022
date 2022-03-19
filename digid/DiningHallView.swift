//
//  DiningHallView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/19.
//

import SwiftUI

struct DiningHallView: View {
    
    @State var buschMax: Int = 250
    @State var buschCurrent: Int = 0
    @State var liviMax: Int = 250
    @State var liviCurrent: Int = 0
    @State var browerMax: Int = 200
    @State var browerCurrent: Int = 0
    @State var neilsonMax: Int = 300
    @State var neilsonCurrent: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Busch Dining Hall")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(buschMax)")
                    Text("Current Capacity: \(buschCurrent)")
                }
                Text("Livingston Dining Hall")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(liviMax)")
                    Text("Current Capacity: \(liviCurrent)")
                }
                Text("Brower Commons")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(browerMax)")
                    Text("Current Capacity: \(browerCurrent)")
                }
                Text("Neilson Dining Hall")
                .fontWeight(.black)
                VStack {
                    Text("Recommended Maximum Capacity: \(neilsonMax)")
                    Text("Current Capacity: \(neilsonCurrent)")
                }
            }
        }
    }
}

struct DiningHallView_Previews: PreviewProvider {
    static var previews: some View {
        DiningHallView()
    }
}
