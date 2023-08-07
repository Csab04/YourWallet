//
//  ExpensesListRow.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 16.02.2023.
//

import SwiftUI

struct ExpensesListRow: View {
    var expenses: Expenses
    var body: some View {
        HStack{
           Circle()
                .fill(Color(expenses.color))
                .frame(width: 30)
                .overlay {
                    Image(systemName: expenses.imageName)
                        .foregroundColor(.white)
                }
            VStack(alignment:.leading){
                Text(expenses.name)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                Text(expenses.note)
                    .font(.system(size: 13))
            }
             Spacer()
            Text("-\(expenses.amount.formatted(.number))")
                .foregroundColor(.red)
        }
        .padding()
    }
}

struct ExpensesListRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListRow(expenses: Expenses(amount: 23, name: "", imageName: "", categoryId: "", color: "", note: "", date: Date(), uid: ""))
    }
}
