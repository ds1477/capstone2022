//
//  QRCodeGenerator.swift
//  digid
//
//  Created by Daniel Samojlik on 4/26/22.
//

import CoreImage.CIFilterBuiltins
import FirebaseAuth
import FirebaseDatabase

struct QRCodeGenerators {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    private let string = getUserEmail() + "_" + getUserVcode()
    
    
    public func generateQRCodeImage(forString string: String) -> QRCode? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                let qrCode = QRCode(string: string, uiImage: UIImage(cgImage: qrCodeCGImage))
                return qrCode
            }
        }
        return nil
    }
}

struct QRCode {
    let string: String
    let uiImage: UIImage
}

private func getUserEmail() -> (String) {
    let defaults = UserDefaults.standard
    
    guard let user = Auth.auth().currentUser else {
        print("User not found")
        return "No user exists"
    }
    
    let uid = user.uid
    let ref = Database.database().reference()
    
    ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
        if let dictionary = snapshot.value as? [String: Any] {
            let email = dictionary["netID"] as? String ?? ""
            print(email)
            defaults.set(email, forKey: "userEmailKey")
        }
    })
    return defaults.string(forKey: "userEmailKey") ?? "No user exists"
}

private func getUserVcode() -> (String) {
    let defaults = UserDefaults.standard
    
    guard let user = Auth.auth().currentUser else {
        print("User not found")
        return "No user exists"
    }
    
    let uid = user.uid
    let ref = Database.database().reference()
    
    ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
        if let dictionary = snapshot.value as? [String: Any] {
            let vcode = dictionary["VCode"] as? String ?? ""
            print(vcode)
            defaults.set(vcode, forKey: "userVcodeKey")
        }
    })
    return defaults.string(forKey: "userVcodeKey") ?? "No Vcode exists"
}
