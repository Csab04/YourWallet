//
//  ExpensesCategoryView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 15.02.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
struct ExpensesCategoryView: View {
    @FirestoreQuery(collectionPath: "ExpensesCategory") var expensCategory: [ExpensesCategory]
    let columns = Array(repeating: GridItem(.flexible(),spacing:20), count: 4)
    @Binding var show:Bool
    @Binding var categoryButtonAction:Bool
    @Binding var selectedIcon:String
    @Binding var selectedBG:String
    @Binding var selectedName:String
    @Binding var isExpense:Bool
    @Binding var categoryID:String
    var body: some View {
        
        VStack{
            VStack(alignment:.leading){
               
               
                LazyVGrid(columns:columns){
                    ForEach(expensCategory,id: \.id){expenes in
                        
                        HStack{
                           categoryButton(expenses: expenes)
                            
                        }
                        
                    }
                   
                }
            }
            .padding()
            
            Spacer()
        }
        
        .foregroundColor(.white)
        .background(Color.black.opacity(0.5))
    }
        
    
    func categoryButton(expenses: ExpensesCategory) -> some View {

        Button{
            withAnimation(.spring()){
                self.show.toggle()
            }
            guard let id = expenses.id else {return}
            categoryButtonAction = true
                selectedIcon = expenses.imageName
                selectedBG  = expenses.color
                selectedName = expenses.name
            categoryID = id
            isExpense = true
        }label: {
            
            VStack{
                Circle()
                    .fill(Color(expenses.color))
                    .frame(width: 55)
                    .overlay {
                        Image(systemName: expenses.imageName)
                            .foregroundColor(.white)
                    }
                
                Text(expenses.name)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ExpensesCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesCategoryView(show: .constant(false), categoryButtonAction: .constant(false), selectedIcon: .constant(""), selectedBG: .constant(""), selectedName: .constant(""), isExpense: .constant(false), categoryID: .constant(""))
    }
}
