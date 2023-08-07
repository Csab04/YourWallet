//
//  AlertView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 25.01.2023.
//

import SwiftUI

struct ErrorAlertsView: View {
    var errorMessage: String
    @Binding var errorLoading:Bool
    var body: some View {
        VStack{
            Text("Error Message")
                .font(.title.bold())
                .foregroundColor(.white)
                .padding()
            Spacer()
            Text(errorMessage)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
            Spacer()
            Button {
                errorLoading.toggle()
            } label: {
                Text("OK")
                    .foregroundColor(.red)
                    .frame(width: 150,height: 50)
                    .background(Color.white)
                    .cornerRadius(.infinity)
            }
            .padding()

        }
        .frame(width: 350,height: 300)
        .background{
            RoundedRectangle(cornerRadius: 15,style: .continuous)
                .fill(Color.red)
        }
        .shadow(radius: 20)
    }
}

struct ErrorAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorAlertsView(errorMessage: "This e-mail already using another account", errorLoading: .constant(false))
    }
}
