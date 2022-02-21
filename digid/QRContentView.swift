//
//  QRContentView.swift
//  XCode_QRGenerator
//
//  Created by Hojun Son on 2022/02/19.
//

import SwiftUI

struct QRContentView: View {
    var body: some View {
        VStack {
            Text("Hello!")
            QRCodeGenerator(url: "www.RUscrewed.app")
        }
    }
}

struct QRContentView_Previews: PreviewProvider {
    static var previews: some View {
        QRContentView()
    }
}
