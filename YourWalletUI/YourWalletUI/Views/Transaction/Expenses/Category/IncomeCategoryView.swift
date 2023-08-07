//
//  IncomeCategoryView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 13.02.2023.
//

import SwiftUI
import FirebaseFirestoreSwift
struct IncomeCategoryView: View {
    @FirestoreQuery(collectionPath: "IncomeCategory") var income: [IncomeCategory]
  
    let columns = Array(repeating: GridItem(.flexible(),spacing:20), count: 4)
    @Binding var show:Bool
    @Binding var categoryButtonAction:Bool
    @Binding var selectedIcon:String
    @Binding var selectedBG:String
    @Binding var selectedName:String
    @Binding var isExpense: Bool
    @Binding var categoryId:String
    var body: some View {
        VStack{
            VStack(alignment:.leading){
                
                LazyVGrid(columns:columns){
                    ForEach(income,id: \.id){income in
                        HStack{
                            categoryButton(income: income)
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
    @ViewBuilder
    func categoryButton(income: IncomeCategory) -> some View {
        Button{
            withAnimation(.spring()){
                self.show.toggle()
            }
            guard let id = income.id else {return}
            categoryButtonAction = true
            selectedIcon = income.imageName
            selectedBG  = income.color
            selectedName = income.name
            categoryId = id
            isExpense = false
        }label: {
            
            VStack{
                Circle()
                    .fill(Color(income.color))
                    .frame(width: 55)
                    .overlay {
                        Image(systemName: income.imageName)
                            .foregroundColor(.white)
                    }
                
                Text(income.name)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct IncomeCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeCategoryView( show: .constant(false),categoryButtonAction: .constant(false), selectedIcon: .constant(""),selectedBG: .constant(""), selectedName: .constant(""),isExpense: .constant(false), categoryId: .constant(""))
           
    }
}
