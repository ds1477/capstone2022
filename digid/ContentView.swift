//
//  ContentView.swift
//  digid
//
//  Created by Daniel Samojlik on 1/20/22.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var netID: String = ""
    @State private var password: String = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("digid")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("deepRed"))
                Text("A Rutgers Digital ID")
                        .fontWeight(.light)
                        .foregroundColor(Color("deepRed"))
                            
                TextField("netID", text: self.$netID)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.netID != "" ? Color("deepRed") : Color("deepRed"),lineWidth: 2))
                    .padding(25)
                
                HStack{
                    VStack {
                        if self.visible{
                            TextField("Password", text: self.$password)
                                .autocapitalization(.none)
                        }
                        else {
                            SecureField("Password", text: self.$password)
                                .autocapitalization(.none)
                        }
                    }
                    Button(action: {
                        self.visible.toggle()
                    }) {
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(self.color)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : Color("deepRed"),lineWidth: 2))
                .padding(25)

                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.reset()
                        
                    }) {
                        
                        Text("Forget password")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Color"))
                    }
                }
                .padding(.top, 20)
                
                Button(action: {
                    
                    self.verify()
                    
                }) {
                    
                    Text("Log in")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 25)
                
            }
            }
            
        }

    func verify(){
    
        if self.netID != "" && self.password != ""{
            
            Auth.auth().signIn(withEmail: self.netID, password: self.password) { (res, err) in
                
                if err != nil{
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else{
            
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }

    func reset(){
        
        if self.netID != ""{
            
            Auth.auth().sendPasswordReset(withEmail: self.netID) { (err) in
                
                if err != nil{
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else{
            
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
                    
            }
        }
    }
