//
//  IncomeListRow.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 14.02.2023.
//

import SwiftUI

struct IncomeListRow: View {
    var income:Income
    var body: some View {
        HStack{
           Circle()
                .fill(Color(income.color))
                .frame(width: 30)
                .overlay {
                    Image(systemName: income.imageName)
                        .foregroundColor(.white)
                }
            VStack(alignment:.leading){
                Text(income.name)
                    .font(.system(size: 15))
                    .fontWeight(.semibold) 
                Text(income.note)
                    .font(.system(size: 13))
            }
             Spacer()
            Text("\(income.amount.formatted(.number))")
                .foregroundColor(Color(Color.bGColor))
        }
        .padding()
    }
}

struct IncomeListRow_Previews: PreviewProvider {
    static var previews: some View {
        IncomeListRow(income: Income(amount: 23.50, name: "Salary", imageName: "creditcard", categoryId: UUID().uuidString, color: "green", note: "First note", date: Date(), uid: ""))
    }
}
