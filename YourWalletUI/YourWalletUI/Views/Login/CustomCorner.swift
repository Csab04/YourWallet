//
//  CustomCorner.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 06.02.2023.
//

import Foundation
import SwiftUI
struct CustomCorner: Shape{
    
    var corner: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
    
}
