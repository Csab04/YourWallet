//
//  TransactionListRow.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 16.02.2023.
//

import SwiftUI

struct TransactionListRow: View {
    var transaction:Transaction
    var body: some View {
        HStack{
           
            Circle()
                .fill(Color(transaction.color))
                .frame(width: 40)
                .overlay {
                    Image(systemName: transaction.imageName)
                        .foregroundColor(.white)
                }
            VStack(alignment:.leading){
                Text(transaction.category)
                    .foregroundColor(transaction.isExpens ? .red : Color(Color.bGColor))
                    .font(.callout.bold())
                Text(transaction.note)
                    .foregroundColor(Color(Color.wBColor))
                    .font(.caption)
            }
            Spacer()
            
            Text(transaction.isExpens ? "-\(transaction.amount,format: .number)" :  "\(transaction.amount,format: .number)")
                .foregroundColor(transaction.isExpens ? .red : Color(Color.bGColor))
            
           
                
        }
        .padding()
    }
}

struct TransactionListRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListRow(transaction: Transaction( amount: 20.0, categoryID: UUID().uuidString, category: "Tech", date: Date(), note: "First note", color: "green", uid: "", isExpens: true,imageName: "creditcard"))
    }
}
