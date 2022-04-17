//
//  CapacityView.swift
//  digid
//
//  Created by Hojun Son on 2022/04/16.
//

import SwiftUI
import Foundation
import Firebase

func importData() {
    var ref = Database.database().reference()
    ref.child("sensor").child("current_cap").getData(completion: {err, snapshot in
        guard err == nil else {
            print("An error has occurred.")
            return;
        }
        let current_capacity = snapshot.value as? Int ?? 0;
        Text("Current Capacity: \(current_capacity)")
    })
}

struct CapacityView: View {
    var body: some View {
        VStack {
            Button("Extract Data") {
                importData()
            }
        }
    }
}


struct CapacityView_Previews: PreviewProvider {
    static var previews: some View {
        CapacityView()
    }
}
