//
//  DiningHallView.swift
//  digid
//
//  Created by Hojun Son on 2022/04/16.
//

import SwiftUI
import Foundation
import Firebase

struct CapacityCheck {
    static var current_capacity = 0
    static var max_capacity = 0
}

func importCurrent() -> Int {
    let ref = Database.database().reference()
    ref.child("sensor").child("current_cap").getData(completion: {err, snapshot in
        guard err == nil else {
            print("An error has occurred.")
            return;
        }
        CapacityCheck.current_capacity = snapshot.value as? Int ?? 0;
    })
    return CapacityCheck.current_capacity
}

func importMax() -> Int {
    let ref = Database.database().reference()
    ref.child("sensor").child("max_cap").getData(completion: {err, snapshot in
        guard err == nil else {
            print("An error has occurred.")
            return;
        }
        CapacityCheck.max_capacity = snapshot.value as? Int ?? 0;
    })
    return CapacityCheck.max_capacity
}

func capacityFilled(current_cap: Int, max_cap: Int) -> Int {
    return (100 * current_cap) / max_cap
}


struct DiningHallView: View {
    @State var isNavigationBarHidden: Bool = true
    var current_cap = importCurrent()
    var max_cap = importMax()
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                    Spacer()
                
                let current_cap = importCurrent()
                let max_cap = importMax()
                let capacity = capacityFilled(current_cap: current_cap, max_cap: max_cap)
                VStack {
                    Text("Brower Commons: ")
                    .fontWeight(.black)
                    Text("Current: \(current_cap) | Max: \(max_cap)")
                    cell1(" Percentage Filled: \(capacity)% ")
                    Spacer()
                            .frame(height: 10)
                    
                    Text("Busch Dining Hall: ")
                    .fontWeight(.black)
                    Text("Current: 160 | Max: 240")
                    cell2(" Percentage Filled: 67% ")
                    Spacer()
                            .frame(height: 10)
                }
                VStack {
                    Text("Livingston Dining Commons: ")
                    .fontWeight(.black)
                    Text("Current: 140 | Max: 250")
                    cell3(" Percentage Filled: 56% ")
                    Spacer()
                            .frame(height: 10)
                    
                    Text("Neilson Dining Hall: ")
                    .fontWeight(.black)
                    Text("Current: 120 | Max: 270")
                    cell4(" Percentage Filled: 44% ")
                    Spacer()
                            .frame(height: 10)
                }
                Spacer()
            }
        }
        .navigationBarTitle("Hidden Title")
        .navigationBarHidden(self.isNavigationBarHidden)
        .onAppear {
            self.isNavigationBarHidden = true
        }
    }
}

struct DiningHallView_Previews: PreviewProvider {
    static var previews: some View {
        DiningHallView()
    }
}

let current_cap = importCurrent()
let max_cap = importMax()
let capacity = capacityFilled(current_cap: current_cap, max_cap: max_cap)

private var percent1: CGFloat = CGFloat(capacity)
private var percent2: CGFloat = 0.67
private var percent3: CGFloat = 0.56
private var percent4: CGFloat = 0.44

@ViewBuilder
private func cell1(_ string: String) -> some View {
    Text(string)
        .padding(.all, 5)
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color("Color-1"))
                        .frame(width: geometry.size.width * percent1/100, height: geometry.size.height)
                    Capsule()
                        .stroke(Color("Color"), lineWidth: 1)
                }
            }
        )
        .clipShape(Capsule())
}

@ViewBuilder
private func cell2(_ string: String) -> some View {
    Text(string)
        .padding(.all, 5)
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color("Color-1"))
                        .frame(width: geometry.size.width * percent2, height: geometry.size.height)
                    Capsule()
                        .stroke(Color("Color"), lineWidth: 1)
                }
            }
        )
        .clipShape(Capsule())
}

@ViewBuilder
private func cell3(_ string: String) -> some View {
    Text(string)
        .padding(.all, 5)
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color("Color-1"))
                        .frame(width: geometry.size.width * percent3, height: geometry.size.height)
                    Capsule()
                        .stroke(Color("Color"), lineWidth: 1)
                }
            }
        )
        .clipShape(Capsule())
}

@ViewBuilder
private func cell4(_ string: String) -> some View {
    Text(string)
        .padding(.all, 5)
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color("Color-1"))
                        .frame(width: geometry.size.width * percent4, height: geometry.size.height)
                    Capsule()
                        .stroke(Color("Color"), lineWidth: 1)
                }
            }
        )
        .clipShape(Capsule())
}
