//
//  QRView.swift
//  digid
//
//  Created by Hojun Son on 2022/02/20.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeGenerator : View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var url : String
    var body: some View {
        Image(uiImage: generateQRCodeImage(url: "www.naver.com"))
            .interpolation(.none)
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
    }

    func generateQRCodeImage( url : String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
