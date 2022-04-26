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
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150, alignment: .center)
                    Spacer()

                VStack {
                    Text("College Ave Fitness Center: ")
                    .fontWeight(.black)
                    Text("Current: 115 | Max: 120")
                    cell1(" Percentage Filled: 96% ")
                    Spacer()
                            .frame(height: 10)
                    
                    Text("Werblin Recreation Center: ")
                    .fontWeight(.black)
                    Text("Current: 162 | Max: 150")
                    cell2(" Percentage Filled: 108% ")
                    Spacer()
                            .frame(height: 10)
                }
                VStack {
                    Text("Livingston Fitness Center: ")
                    .fontWeight(.black)
                    Text("Current: 105 | Max: 120")
                    cell3(" Percentage Filled: 88% ")
                    Spacer()
                            .frame(height: 10)
                   
                    Text("Cook/Douglass Recreation Center: ")
                    .fontWeight(.black)
                    Text("Current: 110 | Max: 140")
                   cell4(" Percentage Filled: 79% ")
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

struct GymView_Previews: PreviewProvider {
    static var previews: some View {
        GymView()
    }
}

private var percent1: CGFloat = 0.96
private var percent2: CGFloat = 1.00
private var percent3: CGFloat = 0.88
private var percent4: CGFloat = 0.79

@ViewBuilder
private func cell1(_ string: String) -> some View {
    Text(string)
        .padding(.all, 5)
        .background(
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color("Color-1"))
                        .frame(width: geometry.size.width * percent1, height: geometry.size.height)
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
