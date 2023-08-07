//
//  CardView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 10.02.2023.
//

import SwiftUI

struct CardView: View {
  @StateObject var balanceViewModel = BalanceViewModel()
    var body: some View {
        VStack(spacing:25){
            Text("Cash flow")
                .font(.title2)
               
            Text("\(balanceViewModel.totalIncome.formatted(.number))")
                .font(.title.bold())
            Spacer()
            Image(systemName: "wallet.fill")
        }
        .foregroundColor(.white)
        .frame(width: 370,height: 170)
        .background(Color(Color.bGColor))
        .clipShape(CustomCorner(corner: [.allCorners], radius: 20))
        .shadow(radius: 10)
        .padding()
        .task {
            
           
        }
    }
    
   
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .environmentObject(BalanceViewModel())
    }
}
