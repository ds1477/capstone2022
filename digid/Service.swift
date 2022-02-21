//
//  Service.swift
//  digid
//
//  Created by Daniel Samojlik on 2/20/22.
//

import SwiftUI
import Firebase

class Service {
    
    static func getUserInfo(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        let ref = Database.database().reference()
        let defaults = UserDefaults.standard
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        
        ref.child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                let email = dictionary["email"] as! String
                
                defaults.set(email, forKey: "userEmailKey")
                
                onSuccess()
            }
        }) { (error) in
            onError(error)
        }
    }
    
}
