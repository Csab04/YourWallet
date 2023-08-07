//
//  SuccesRegisterView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 27.02.2023.
//

import SwiftUI

struct SuccesRegisterView: View {
    @Binding var succesLoding:Bool
    var body: some View {
        VStack{
            Text(" Succes")
                .font(.title.bold())
                .foregroundColor(.white)
                .padding()
            Spacer()
            Text("Congratulation!Welcome our family")
                .font(.title3)
                .foregroundColor(.white)
            Text("Please click the button and go to the Login page! Let's go!😎")
                .font(.title3)
                .foregroundColor(.white)
               
            Spacer()
            NavigationLink{
                LoginView()
            } label: {
                Button {
                        succesLoding.toggle()
                    } label: {
                        Text("Go to Login Page")
                            .foregroundColor(Color(Color.bGColor))
                            .frame(width: 150,height: 50)
                            .background(Color.white)
                            .cornerRadius(.infinity)
                    }
            }
            .padding()

        }
        .frame(width: 350,height: 300)
        .background{
            RoundedRectangle(cornerRadius: 15,style: .continuous)
                .fill(Color(Color.bGColor))
        }
        .shadow(radius: 20)
    }
}

struct SuccesRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        SuccesRegisterView(succesLoding: .constant(false))
    }
}
