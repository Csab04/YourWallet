//
//  ExpensesModel.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 15.02.2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

typealias ExpensesGroup = [String:[Expenses]]
struct ExpensesCategory: Identifiable,Codable{
    @DocumentID var id:String?
    var name:String
    var imageName:String
    var color:String
}

struct Expenses:Identifiable,Codable{
    
    @DocumentID var id:String?
    var amount:Double
    var name:String
    var imageName:String
    var categoryId:String
    var color:String
    var note:String
    var date:Date
    var uid:String
    var month:String {
        date.displayFormatForSectiomHeader
    }
}

 

class ExpensesViewModel:ObservableObject{
  
    @Published private(set) var expensCategory: [ExpensesCategory] = []
    @Published private var expenses: [Expenses] = []
    private var db = Firestore.firestore()
   
   
    
    func getExpensesCategory(expenses:Expenses){
        Task{
            do{
               
                let _ = try db.collection("Expenses").addDocument(from: expenses)
                
            }catch{
                print("Error:\(error)")
            }
            
        }
    }
    
    
    
    
}
