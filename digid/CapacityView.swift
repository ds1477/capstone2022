//
//  CapacityView.swift
//  digid
//
//  Created by Hojun Son on 2022/04/16.
//

import Foundation
import FirebaseDatabase

func importData() {
    var browerCurrent: Int
    var ref = Database.database().reference()
    ref.child("sensor").child("current_cap")
}
