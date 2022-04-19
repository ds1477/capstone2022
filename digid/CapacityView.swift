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
        print("Current Capacity: \(CapacityCheck.current_capacity)")
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
        print("Maximum Capacity: \(CapacityCheck.max_capacity)")
    })
    return CapacityCheck.max_capacity
}


struct CapacityView: View {
    var body: some View {
        VStack {
            Spacer()
            Button("Current Capacity") {
                let current_cap = importCurrent()
                Text("Current Capacity: \(current_cap)")
            }
            Spacer()
            Button("Maximum Capacity") {
                let max_cap = importMax()
                Text("Current Capacity: \(max_cap)")
            }
            Spacer()
        }
    }
}

struct CapacityView_Previews: PreviewProvider {
    static var previews: some View {
        CapacityView()
    }
}
