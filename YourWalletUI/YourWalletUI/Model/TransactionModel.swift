//
//  TransactionModel.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 16.02.2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Collections

struct Transaction:Identifiable,Codable{
    @DocumentID var id:String?
    var amount:Double
    var categoryID : String
    var category:String
    var date:Date
    var note:String
    var color:String
    var uid:String
    var isExpens:Bool
    var imageName:String
    
    var month:String {
        date.displayFormatForSectiomHeader
    }
    
    
    
}

typealias TransactionGroup = OrderedDictionary<String,[Transaction]>
typealias TransactionCategoryGroup = OrderedDictionary<String,[ExpensesCategory]>
typealias TransactionPreFixSum = [(String,Double)]
class TransactionViewModel:ObservableObject{
    
    @Published  var transaction: [Transaction] = []
    @Published var transactions: Transaction?
    @Published var expnesCategory: [ExpensesCategory] = []
    @Published  private(set) var totalIncome: Double = 0.0
    @Published var isLoading = false
    
    init(){
        readTransactions()
        
    }
    
    
    
    
    func getTransaction(transaction:Transaction){
        self.isLoading = true
        Task{
            do{
                let _ = try Firestore.firestore().collection("Transaction").addDocument(from: transaction){ err in
                    if err == nil {
                        print("Succes to add a newTransactions")
                        self.readTransactions()
                    }
                }
                
            } catch{
                print("Error\(error)")
            }
        }
    }
    
    
    func readTransactions(){
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("Transaction").order(by: "date", descending: true).whereField("uid",isEqualTo: uid).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetchinf documents:\(String(describing: error))")
                return
            }
            
            
            self.transaction = documents.compactMap{ document -> Transaction? in
                do {
                    
                    return try document.data(as: Transaction.self)
                    
                } catch {
                    print("Error decoding into Transactions:\(error)")
                    return nil
                }
            }
        }
    }
    
    func updateTransactions(_ transaction:Transaction){
        guard let id = transaction.id else {return}
        let _ = try!  Firestore.firestore().collection("Transaction").document(id).setData(from: transaction)
    }
    func deleteTransaction(t:Transaction){
        self.isLoading = true
        guard let id = t.id else {return}
        do{
            Firestore.firestore().collection("Transaction").document(id).delete()
        }
    }
    
    func groupedByMonth() -> TransactionGroup {
        guard !transaction.isEmpty else {
            return [:]
        }
        let groupedTransaction = TransactionGroup(grouping: transaction) { $0.month }
        
        return groupedTransaction
    }
     
    
    func groupedByCategory() -> TransactionGroup {
        guard !transaction.isEmpty else {
            return [:]
        }
        let groupedTransaction = TransactionGroup(grouping: transaction) { $0.categoryID }
        
        return groupedTransaction
    }
    
    
   
    
    func calculated() -> TransactionPreFixSum {
        guard !transaction.isEmpty else {return []}
        
        
        var sum: Double = .zero
        var calculated = TransactionPreFixSum()
        
        for t in transaction {
            if t.isExpens == true {
                sum -= t.amount
            } else {
                sum += t.amount
            }
            
            
            calculated.append(("",sum))
        }
        
        return calculated
    }
    
    
    
    
    func uploadCategory(name:String,color:String,imageName:String,selectCategoryType:Bool) {
        if selectCategoryType {
            let expensesCategory =  ExpensesCategory(name: name, imageName: imageName, color: color)
            
            let _ = try! Firestore.firestore().collection("ExpensesCategory").document().setData(from: expensesCategory)
        } else {
            let incomeCategory = IncomeCategory(name: name, imageName: imageName, color: color)
            let _ = try! Firestore.firestore().collection("IncomeCategory").document().setData(from: incomeCategory)
            
        }
        
    }
    
    func deleteExpensesCategory(expenses:ExpensesCategory){
        guard let id = expenses.id else {return}
        Firestore.firestore().collection("ExpensesCategory").document(id).delete()
    }
    
    func deleteIncomeCategory(income:IncomeCategory){
        guard let id = income.id else {return}
        Firestore.firestore().collection("IncomeCategory").document(id).delete()
    }
    
}
