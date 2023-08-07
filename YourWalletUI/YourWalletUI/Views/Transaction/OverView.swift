//
//  OverView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 14.03.2023.
//

import SwiftUI
import FirebaseFirestoreSwift
enum SelectButtons:String ,CaseIterable{
    case expnes = "Expens"
    case income = "Income"
}
struct OverView: View {
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
    }
    @FirestoreQuery(collectionPath: "ExpensesCategory") var expensCategory: [ExpensesCategory]
    @FirestoreQuery(collectionPath: "IncomeCategory") var income: [IncomeCategory]
    @State var selectButtons:SelectButtons = .expnes
    @ObservedObject var tVM = TransactionViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                Circle()
                    .frame(width: 350)
                
                Picker("", selection: $selectButtons) {
                    ForEach(SelectButtons.allCases,id: \.self){
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                if selectButtons == .expnes {
                    List{
                        ForEach(expensCategory) { category in
                            NavigationLink {
                                if let transaction = tVM.transactions {
                                    OverListView(transaction: transaction)
                                }
                            } label: {
                                HStack{
                                    Circle()
                                        .fill(Color(category.color))
                                        .frame(width: 50)
                                        .overlay {
                                            Image(systemName: category.imageName)
                                                .foregroundColor(.white)
                                        }
                                    VStack{
                                        Text(category.name)
                                            .font(.title2.bold())
                                        Text("\(tVM.transaction.count) transaction")
                                    }
                                    Spacer()
                                    

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
                                VStack{
                                    Text(category.name)
                                        .font(.title2.bold())
                                    Text("\(tVM.transaction.count) transaction")
                                }
                                Spacer()
                            }
                            
                        }
                    }
                        

                    }
                Spacer()
            }
            
            .navigationTitle("March 2023")
        }
    }
}

struct OverView_Previews: PreviewProvider {
    static var previews: some View {
        OverView()
    }
}
