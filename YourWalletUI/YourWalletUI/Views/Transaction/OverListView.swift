//
//  OverListView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 15.03.2023.
//

import SwiftUI

struct OverListView: View {
    var transaction:Transaction
    var body: some View {
        VStack{
            HStack{
                Circle()
                    .fill(Color(transaction.color))
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: transaction.imageName)
                            .foregroundColor(.white)
                    }
                Text(transaction.category)
                    .font(.callout.bold())
            }
              
            Text("3456 RON")
                .font(.title.bold())
            List{
                HStack{
                    Circle()
                        .fill(Color(transaction.color))
                        .frame(width: 50)
                        .overlay {
                            Image(systemName: transaction.imageName)
                                .foregroundColor(.white)
                        }
                    VStack(alignment:.leading){
                        Text(transaction.category)
                            .font(.callout.bold())
                        Text(transaction.note)
                        Text(transaction.month)
                    }
                    Spacer()
                    Text(transaction.isExpens ? "-\(transaction.amount,format: .number)" :  "\(transaction.amount,format: .number)")
                        .foregroundColor(transaction.isExpens ? .red : Color(Color.bGColor))
                }
            }
            Spacer()
        }
    }
}

struct OverListView_Previews: PreviewProvider {
    static var previews: some View {
        OverListView(transaction: Transaction(amount: 12.0, categoryID: "\(UUID().uuidString)", category: "Home", date: Date(), note: "First note", color: "red", uid: "", isExpens: true, imageName: "house"))
    }
}
