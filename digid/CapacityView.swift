//
//  CapacityView.swift
//  digid
//
//  Created by Hojun Son on 2022/04/16.
//

import SwiftUI
import Foundation
import Firebase

struct CapacityCheck {
    static var current_capacity = 0
    static var max_capacity = 0
}

func importCurrent() -> Int {
    var ref = Database.database().reference()
    ref.child("sensor").child("current_cap").getData(completion: {err, snapshot in
        guard err == nil else {
            print("An error has occurred.")
            return;
        }
        CapacityCheck.current_capacity = snapshot.value as? Int ?? 0;
    })
    return CapacityCheck.current_capacity
}

func importMax() -> Int {
    var ref = Database.database().reference()
    ref.child("sensor").child("max_cap").getData(completion: {err, snapshot in
        guard err == nil else {
            print("An error has occurred.")
            return;
        }
        CapacityCheck.max_capacity = snapshot.value as? Int ?? 0;
    })
    return CapacityCheck.max_capacity
}

func capacityFilled(current_cap: Int, max_cap: Int) -> Int {
    return (100 * current_cap) / max_cap
}


struct CapacityView: View {
    @State var isNavigationBarHidden: Bool = true
    var current_cap = importCurrent()
    var max_cap = importMax()
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                let current_cap = importCurrent()
                let max_cap = importMax()
                let capacity = capacityFilled(current_cap: current_cap, max_cap: max_cap)
                Text("Brower Commons: ")
                .fontWeight(.black)
                Text("Current: \(current_cap) | Max: \(max_cap)")
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                Text("Capacity Filled: \(capacity)%")
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                    .background(Color("Color"))
                    .cornerRadius(4)
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

struct CapacityView_Previews: PreviewProvider {
    static var previews: some View {
        CapacityView()
    }
}
