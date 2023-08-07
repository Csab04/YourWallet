//
//  TransactionUploadView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 16.02.2023.
//

import SwiftUI
import Firebase
struct TransactionUploadView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @Binding var showExpensesView : Bool
    @State var  showExpensesCategory = true
    @State var transaction = false
    @State var categoryAction = false
    @State var showDatePicker = false
    @State var isLoading = false
    @State var expenses : Double = 0.0
    @State var note = ""
    @State var date: Date = Date()
    @State var selectedImage = ""
    @State var selectedName = ""
    @State var selectedBG = ""
    @State var categoryID = ""
    @State var incomCategoryId = ""
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    HStack{
                        Button {
                            withAnimation(.spring()){
                                showExpensesView.toggle()
                            }
                        } label: {
                            Image(systemName: "xmark")
                            
                        }
                        Spacer()
                    }
                    Text( categoryAction ? selectedName : "Add transicons")
                        .font(.title2.bold())
                    
                    
                    Spacer()
                    HStack{
                        TextField(transaction ? "0.0" : " 0.0", value: $expenses, formatter: NumberFormatter())
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
                                    Image(systemName: categoryAction ? selectedImage : "creditcard")
                                        .foregroundColor(.black)
                                }
                                .onTapGesture {
                                    if showDatePicker == true {
                                        showExpensesView = false
                                    } 
                                }
                        }
                        
                    }
                    Divider()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:.infinity,maxHeight: 200)
                .background(categoryAction ? Color(selectedBG) : Color(Color.bGColor))
                
                
                VStack(alignment: .leading,spacing: 20) {
                    HStack{
                        Image(systemName: "calendar")
                        Text("Date")
                        Spacer()
                        Text("\(date.displayFormatForSectiomHeader)")
                            .onTapGesture {
                                withAnimation(.spring()){
                                    showDatePicker = true
                                }
                                withAnimation(.spring()){
                                    showExpensesCategory = false
                                }
                            }
                    }
                    Divider()
                    TextField("Write note", text: $note)
                        .padding(.horizontal,24)
                        .overlay {
                            HStack{
                                Image(systemName: "pencil")
                                Spacer()
                            }
                            
                        }
                    Divider()
                }
                .foregroundColor(categoryAction ? Color(selectedBG) : Color(Color.bGColor))
                .padding()
                Button {
                    guard let uid = Auth.auth().currentUser?.uid else{return}
                    
                    transactionViewModel.getTransaction(transaction: Transaction(amount: expenses, categoryID: categoryID, category: selectedName, date: date, note: note, color: selectedBG, uid: uid, isExpens: transaction, imageName: selectedImage))
                  
                   withAnimation(.spring()){
                        showExpensesView.toggle()
                    }
                } label: {
                    Text("Add expenses")
                        .foregroundColor(.white)
                        .frame(width: 250,height: 40)
                        .background(categoryAction ? Color(selectedBG) : Color(Color.bGColor))
                        .cornerRadius(.infinity)
                }
                
                Spacer()
            }
            
            
            TransactionCategoryView(show:$showExpensesCategory,transaction:$transaction, categoryAction: $categoryAction, selectedImage: $selectedImage, selectedName: $selectedName, selectedBG: $selectedBG, categoryID: $categoryID, incomCategoryId: $incomCategoryId)
                .clipShape(CustomCorner(corner: [.topLeft,.topRight], radius: 20))
                .ignoresSafeArea()
                .offset(x:0,y:showExpensesCategory ? getRect().height / 2 : getRect().height / 1)
            
            DatePickerView(date: $date, showPicker: $showDatePicker)
                     .clipShape(CustomCorner(corner: [.topLeft,.topRight], radius: 20))
                     .ignoresSafeArea()
                    .offset(x:0,y:showDatePicker ? getRect().height / 3 : getRect().height / 1)
         
        }
        
    }
}

struct TransactionUploadView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionUploadView(showExpensesView: .constant(false))
            .environmentObject(TransactionViewModel())
    }
}
