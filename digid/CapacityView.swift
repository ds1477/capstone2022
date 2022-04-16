//
//  CapacityView.swift
//  digid
//
//  Created by Hojun Son on 2022/04/16.
//

import Foundation
import Firebase

func initrealtimeFirebase() {
    FirebaseApp.configure()
}

func importData() {
    var current_capacity: String
    var ref = Database.database().reference()
    ref.child("sensor").child("current_cap").getData(completion: {err, snapshot in
        guard err == nil else {
            print("An error has occurred.")
            return;
        }
    })
    let current_capacity = snapshot.value as? String ?? "0";
}
