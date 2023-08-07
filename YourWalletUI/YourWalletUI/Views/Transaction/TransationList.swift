//
//  TransationList.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 10.03.2023.
//

import SwiftUI

struct TransationList: View {
    @StateObject var transactionViewModel  = TransactionViewModel()
      @State var showTransactionView = false
      @State var total:Double = 0.0
      @State var transactions: Transaction?
    var body: some View {
        VStack{
            if transactionViewModel.transaction.isEmpty {
                 TransactionEmptyView()
             } else {
                 ScrollView{
                     ForEach(Array(transactionViewModel.groupedByMonth()),id:\.key){ month,transaction in
                         Section {
                             ForEach(transaction){ transaction in
                                 VStack{
                                     NavigationLink {
                                         TransactionsDetaliView(transaction: transaction)
                                         
                                     } label: {
                                         TransactionListRow(transaction: transaction)
                                         
                                     }
                                    Divider()
                                 }
                                 
                             }
                         } header: {
                             SectionHeaderView(month:month)
                                 
                         }
                         
                         .listStyle(.grouped)
                     }
                     .padding(.bottom,24)
                 }
                 .refreshable {
                     transactionViewModel.readTransactions()
                 }
                 .onAppear(){
                     transactionViewModel.readTransactions()
                 }
                
                 

          }
             
        }
       
    }
}

struct TransationList_Previews: PreviewProvider {
    static var previews: some View {
        TransationList()
          
    }
}
 
struct SectionHeaderView:View {
     var month:String
    var body: some View {
        HStack{
            Text(month)
                .foregroundColor(Color(Color.wBColor))
            Spacer()
        }
        
    }
}
