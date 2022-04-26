//
//  QRView.swift
//  digid
//
//  Created by Hojun Son on 2022/02/20.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import CoreImage.CIFilterBuiltins

struct QRView: View {
    @ObservedObject var model = Model()
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120, alignment: .center)
                Text("QR Code")
                    .foregroundColor(Color.black)
                QRCodeGenerator()
                Spacer()
                Button(action: {
                    model.reloadView()
                    updateUserVCode()

                }, label: {
                    Text("Generate New QR Code")
                        .foregroundColor(Color.white)
                        .frame(width:250, height: 50)
                        .background(Color("Color"))
                        .cornerRadius(4)
                })
                Button (action: {
                    //Guest QR Code implementation
                },label: {
                    Text("Generate Guest QR Code")
                        .foregroundColor(Color.white)
                        .frame(width:250, height: 50)
                        .background(Color("Color"))
                        .cornerRadius(4)
                })
                Spacer()
            }
        }
}

class Model: ObservableObject {
    func reloadView() {
        objectWillChange.send()
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView()
    }
}

struct QRCodeGenerator : View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    let userInfo = getUserEmail() + "_" + getUserVcode()
    var body: some View {
        Image(uiImage: generateQRCodeImage(String: userInfo))
            .interpolation(.none)
            .resizable()
            .frame(width: 250, height: 250, alignment: .center)
    }

    func generateQRCodeImage(String : String) -> UIImage {
        let data = Data(String.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
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

private func updateUserVCode() {
    guard let user = Auth.auth().currentUser else {
        print("User not found")
        return
    }
    
     let uid = user.uid
     let ref = Database.database().reference()
     let random = Int.random(in: 0...567848) + Int.random(in: 0...567848)
     let vcode = String(random)
     
     ref.child("users").child(uid).child("VCode").setValue(vcode)
}
