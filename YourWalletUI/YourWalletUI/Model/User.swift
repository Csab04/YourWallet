//
//  User.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 29.01.2023.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User:Identifiable,Codable{
    @DocumentID var id:String?
    var name:String
    var email:String
    var password:String
    var profileImageUrl:String
    var uid:String
    
    enum CodingKeys: CodingKey{
        case id
        case name
        case email
        case password
        case profileImageUrl
        case uid
    }
}
