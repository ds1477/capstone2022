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
    var current_capacity: Int
    var ref = Database.database().reference()
    ref.child("sensor").getData(completion: {err, snapshot in
        guard err == nil else {
            print("An error has occurred.")
            return;
        }
    })
    let current_capacity = snapshot.value as? Int ?? 0;
}
