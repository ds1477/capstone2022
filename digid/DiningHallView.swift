//
//  DiningHallView.swift
//  digid
//
//  Created by Hojun Son on 2022/03/19.
//

import SwiftUI

struct DiningHallView: View {
    
    @State var buschMax: Int = 250
    @State var liviMax: Int = 250
    @State var browerMax: Int = 200
    @State var neilsonMax: Int = 300
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Busch Dining Hall")
                Text("Livingston Dining Hall")
                Text("Brower Commons")
                Text("Neilson Dining Hall")
            }
        }
    }
}

struct DiningHallView_Previews: PreviewProvider {
    static var previews: some View {
        DiningHallView()
    }
}
