//
//  TransactionsDetaliView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 20.02.2023.
//

import SwiftUI

struct TransactionsDetaliView: View {
  @State  var transaction:Transaction
    @EnvironmentObject var tVM: TransactionViewModel
    @Environment (\.dismiss) var dismiss
    @State var showDatePicker = false
    @State var showExpensesCategory = false
    @State var categoryAction  = false
    @State var categoryID = ""
    @State var incomCategoryId = ""
    @State var transactions = false
    var body: some View {
        
        ZStack(alignment:.bottom){
            VStack{
                VStack{
                    HStack{
                        Button {
                            withAnimation(.spring()){
                               dismiss()
                            }
                        } label: {
                            Image(systemName: "xmark")
                            
                        }
                        Spacer()
                        
                        Button {
                            tVM.deleteTransaction(t: transaction)
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                    Text( transaction.category)
                        .font(.title2.bold())
                    
                    
                    Spacer()
                    HStack{
                        TextField("", value: $transaction.amount,formatter: NumberFormatter())
                            .font(.system(size: 30))
                            .frame(width: 160)
                        
                        Spacer()
                        
                        Button {
                            withAnimation(.spring()){
                                showExpensesCategory.toggle()
                            }
                        } label: {
                            Circle()
                                .frame(width: 50)
                                .overlay {
                                    Image(systemName: transaction.imageName)
                                        .foregroundColor(.black)
                                }
                        }
                        
                    }
                    Divider()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:.infinity,maxHeight: 200)
                .background(Color(transaction.color))
                
                
                VStack(alignment:.leading){
                    Text("Date")
                    Text("\(transaction.date.displayFormatForSectiomHeader)")
                        .foregroundColor(Color(Color.bGColor))
                        .onTapGesture {
                            withAnimation(.spring()){
                                self.showDatePicker.toggle()
                                
                                self.showExpensesCategory = false
                            }
                        }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                
                VStack{
                    Text("Note")
                        .frame(maxWidth: .infinity,alignment: .leading)
                    TextField("", text:$transaction.note)
                     Divider()
                }
                .padding()
                Button {
                    tVM.updateTransactions(transaction)
                    dismiss()
                } label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(width: 200,height: 50)
                        .background(Color(Color.bGColor))
                        .cornerRadius(.infinity)
                }
                Spacer()
                
            }
          
            
            
            DatePickerView(date: $transaction.date, showPicker: $showDatePicker)
                     .clipShape(CustomCorner(corner: [.topLeft,.topRight], radius: 20))
                     .ignoresSafeArea()
                    .offset(x:0,y:showDatePicker ? getRect().height / 5 : getRect().height / 1)
            
            
            TransactionCategoryView(show:$showExpensesCategory,transaction:$transactions, categoryAction: $categoryAction, selectedImage: $transaction.imageName, selectedName: $transaction.category, selectedBG: $transaction.color, categoryID: $categoryID, incomCategoryId: $incomCategoryId)
                .clipShape(CustomCorner(corner: [.topLeft,.topRight], radius: 20))
                .ignoresSafeArea()
                .offset(x:0,y:showExpensesCategory ? getRect().height / 2 : getRect().height / 1)
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
    
    
}


struct TransactionsDetaliView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsDetaliView(transaction: Transaction(amount: 12.0, categoryID: UUID().uuidString, category: "Car", date: Date(), note: "First transaction", color: "green", uid: "", isExpens: true, imageName: "car"))
            .environmentObject(TransactionViewModel())
    }
}


struct DatePickerView: View {
    @Binding var date:Date
    @Binding var showPicker:Bool
    var body: some View{
        VStack{
            HStack{
                Text("Selected date")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity,alignment: .leading)
                Button {
                    withAnimation(.spring()){
                        showPicker.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                }
                
            }
            .foregroundColor(.white)
            DatePicker("\(date)", selection: $date)
                .datePickerStyle(.graphical)
            
        }
        .padding()
        .background(Color.black.opacity(0.3))
        
    }
}
