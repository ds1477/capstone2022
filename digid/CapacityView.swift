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
    var ref = Database.database().reference()
    ref.child("sensor").child("current_cap").getData(completion: {error, snapshot in
        guard error == nil else {
            print("An error has occurred.")
            return;
        }
        let current_capacity = snapshot.value as? Int ?? 0;
    })
}
