//
//  SearchTransactionView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 20.02.2023.
//

import SwiftUI

struct SearchTransactionView: View {
    @State var search = ""
    @ObservedObject var transactionVM = TransactionViewModel()
    var body: some View {
        NavigationStack{
            List{
                if search.isEmpty {
                    SearchEmptyView()
                } else {
                  
                        ForEach(self.transactionVM.transaction.filter{self.search.isEmpty ? true :  $0.category.localizedCaseInsensitiveContains(self.search)},id: \.id){ t in
                            TransactionSearchListRow(transaction: t)
                        }
                    
                }
            }
            .navigationTitle("Search transactions")
            .searchable(text: $search)
        }
    }
}

struct SearchTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTransactionView()
    }
}


struct TransactionSearchListRow:View{
    var transaction:Transaction
    var body: some View{
        HStack{
            Rectangle()
                .foregroundColor(transaction.isExpens ? .red : Color(Color.bGColor))
                .frame(width: 10,height: 30)
                .cornerRadius(.infinity)
            
            Circle()
                .fill(Color(transaction.color))
                .frame(width: 40)
                .overlay {
                    Image(systemName: transaction.imageName)
                        .foregroundColor(.white)
                }
            VStack(alignment:.leading){
                Text(transaction.category)
                    .font(.callout.bold())
                Text(transaction.note)
                    .font(.caption)
                
                Text(transaction.month)
                    .font(.callout.bold())
            }
            Spacer()
            
            Text(transaction.isExpens ? "-\(transaction.amount,format: .number)" :  "\(transaction.amount,format: .number)")
                .foregroundColor(transaction.isExpens ? .red : Color(Color.bGColor))
            
           
                
        }
        .padding()
    }
}
