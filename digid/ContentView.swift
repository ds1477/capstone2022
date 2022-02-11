//
//  ContentView.swift
//  digid
//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI


struct ContentView: View {
    @State private var netID: String = ""
    @State private var password: String = ""
    @State var color = Color.black.opacity(0.7)
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
           
                VStack {
                    TextField("netID", text: $netID)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.netID != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : Color("Color"),lineWidth: 2))
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width:200, height: 50)
                            .background(Color("Color"))
                            .cornerRadius(4)
                    })
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


