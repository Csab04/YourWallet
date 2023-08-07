//
//  TransactionCategoryView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 16.02.2023.
//

import SwiftUI

struct TransactionCategoryView: View {
    @Binding var show:Bool
    @Binding var transaction :Bool
    @Binding var categoryAction : Bool
    @Binding var selectedImage : String
    @Binding var selectedName : String
    @Binding var selectedBG : String
    @Binding var categoryID:String
    @Binding var incomCategoryId:String
    var body: some View {  
        VStack{
            
            Picker("Transaction", selection: $transaction) {
                Text("Expenses")
                    .tag(true)
                
                Text("Income")
                    .tag(false)
               
            }
            .pickerStyle(.segmented)
            
            
            if  transaction{
                
                ExpensesCategoryView(show: $show, categoryButtonAction: $categoryAction, selectedIcon: $selectedImage, selectedBG: $selectedBG, selectedName: $selectedName, isExpense: $transaction, categoryID: $categoryID)
                    .tag(true)
            } else {
                IncomeCategoryView(show: $show, categoryButtonAction: $categoryAction, selectedIcon: $selectedImage, selectedBG: $selectedBG, selectedName: $selectedName, isExpense: $transaction, categoryId: $incomCategoryId)
                    .tag(false)
            }
            
           
                
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct TransactionCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCategoryView(show: .constant(false), transaction: .constant(false), categoryAction: .constant(false), selectedImage: .constant(""), selectedName: .constant(""), selectedBG: .constant(""), categoryID: .constant(""), incomCategoryId: .constant(""))
            
    }
}
