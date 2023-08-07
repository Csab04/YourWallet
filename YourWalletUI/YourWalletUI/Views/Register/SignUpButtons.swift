//
//  SignUpButtons.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 06.02.2023.
//

import SwiftUI

struct SignUpButtons: View {
    var imageName:String
    var backGround: Color
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .frame(width: 35,height: 35)
        }
        .frame(width: 55,height: 55)
        .background(backGround)
        .clipShape(CustomCorner(
            corner: [.allCorners], radius: 10))
        .shadow(radius: 15)
    }
}

struct SignUpButtons_Previews: PreviewProvider {
    static var previews: some View {
        SignUpButtons(imageName: "facebook", backGround: .white)
    }
}
