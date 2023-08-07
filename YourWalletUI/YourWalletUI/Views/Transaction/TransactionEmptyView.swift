//
//  TransactionEmptyView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 19.02.2023.
//

import SwiftUI

struct TransactionEmptyView: View {
    var body: some View {
        VStack{
            Circle()
                .fill(Color(Color.bGColor))
                .frame(width: 250)
                .overlay {
                    Image("note")
                        .resizable()
                        .frame(width: 200,height: 200)
                        
                }
            
            Text("There are no transactions!")
                .font(.title.bold())
            Text("Are you a productiv person? I think you should, click the plus botton and add bunch of transactions to your wallet ")
        }
        .padding()
    }
}

struct TransactionEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionEmptyView()
    }
}
