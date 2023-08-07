//
//  CategorySettnigs.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 03.03.2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct CategorySettnigs: View {
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .purple
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.black], for: .selected)
    }
    @FirestoreQuery(collectionPath: "ExpensesCategory") var expensCategory: [ExpensesCategory]
    @FirestoreQuery(collectionPath: "IncomeCategory") var income: [IncomeCategory]
    @State var showCategory = false
    @State var showCategoryUploader = false
    @EnvironmentObject var tVM : TransactionViewModel
    var body: some View {
        NavigationStack{
            VStack{
                Picker("", selection: $showCategory) {
                    Text("Expenses")
                        .tag(true)
                    Text("Income")
                        .tag(false)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if showCategory {
                    List{
                        ForEach(expensCategory) { category in
                            HStack{
                                Circle()
                                    .fill(Color(category.color))
                                    .frame(width: 50)
                                    .overlay {
                                        Image(systemName: category.imageName)
                                            .foregroundColor(.white)
                                    }
                                
                                Text(category.name)
                                    .font(.title2.bold())
                                Spacer()
                                

                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    tVM.deleteExpensesCategory(expenses: category)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        
                        }
                       
                    
                    }
                } else {
                    List{
                        ForEach(income) { category in
                            HStack{
                                Circle()
                                    .fill(Color(category.color))
                                    .frame(width: 50)
                                    .overlay {
                                        Image(systemName: category.imageName)
                                            .foregroundColor(.white)
                                    }
                                
                                Text(category.name)
                                    .font(.title2.bold())
                                Spacer()
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    tVM.deleteIncomeCategory(income: category)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        

                    }
                }
                Spacer()
            }
            .navigationTitle("Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()){
                            showCategoryUploader.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(isPresented: $showCategoryUploader) {
                CategoryUploadView(cancel: $showCategoryUploader, showCategoryType: $showCategory)
            }
        }
        
    }
    
    
    enum Category:String,CaseIterable{
        case expenses = "Expenses"
        case  income = "Income"
    }
}

struct CategorySettnigs_Previews: PreviewProvider {
    static var previews: some View {
        CategorySettnigs()
            .environmentObject(TransactionViewModel())
    }
}
