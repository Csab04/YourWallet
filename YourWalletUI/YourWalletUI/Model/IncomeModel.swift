//
//  IncomeModel.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 25.01.2023.
//
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Income: Identifiable,Codable {
    @DocumentID  var id: String?
    var amount:Double
    var name:String
    var imageName:String
    var categoryId:String
    var color:String
    var note:String
    var date:Date
    var uid:String
}



struct IncomeCategory: Identifiable,Codable{
    @DocumentID var id:String?
    var name:String
    var imageName:String
    var color:String
}


class BalanceViewModel: ObservableObject {
    @Published var cancel = false
    @Published private(set)var incomeCategory: [IncomeCategory] = []
    @Published private(set)var income:[Income] = []
    @Published private(set)var totalIncome:Double = 0.0
   
    func uploadIncome(amount:Double,name:String,categoryId:String,imageName:String,note:String,color:String,date:Date){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        Task{
            do{
                let income = Income(amount: amount, name: name, imageName: imageName, categoryId: categoryId, color: color, note: note, date: date, uid: uid)
                let _ = try Firestore.firestore().collection("Income").addDocument(from: income)
            } catch{
                print("\(error)")
            }
        }
           
    }
    
    func totalIncomeFunc(income:Income){
        totalIncome = income.amount + income.amount
    }
    
}
