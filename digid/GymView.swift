//
//  GymView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/19.
//

import SwiftUI

struct GymView: View {
    @State var isNavigationBarHidden: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
        }
        .navigationBarTitle("Hidden Title")
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = true
        }
    }
}

struct GymView_Previews: PreviewProvider {
    static var previews: some View {
        GymView()
    }
}
