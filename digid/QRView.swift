//
//  QRView.swift
//  digid
//
//  Created by Hojun Son on 2022/02/20.
//

import Foundation
import SwiftUI
import FirebaseAuth
import CoreImage.CIFilterBuiltins

struct QRView: View {
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
                QRCodeGenerator() //TODO: need to fix this so that the QR code updates
            }, label: {
                Text("Generate New QR Code")
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                    .background(Color("Color"))
                    .cornerRadius(4)
            })
        }
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
    let userInfo = getUserInfo()
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

private func getUserInfo() -> String {
    guard let user = Auth.auth().currentUser else {
        print("User not found")
        return "No user exists"
    }
    guard let userEmail: String = user.email else {
        print("Email not found")
        return "No email exists"
    }
    
    let random = Int.random(in: 0...567848) + Int.random(in: 0...567848)
    let vcode = String(random)
    
    //let vcode: String = user.
    return userEmail + "_" + vcode
}
