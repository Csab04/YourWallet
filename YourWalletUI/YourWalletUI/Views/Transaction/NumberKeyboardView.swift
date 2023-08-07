//
//  NumberKeyboardView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 11.03.2023.
//

import SwiftUI

struct NumberKeyboardView: View {
    let numbers : [[Number]] = [
        [.seven,.eight,.night,.divide],
        [.four,.five,.six,.precent],
        [.one,.two,.three,.minus],
        [.zero,.point,.plus]
    
    ]
    var body: some View {
        VStack{
            ForEach(numbers,id: \.self){row in
                HStack{
                    ForEach(row,id: \.self){ item in
                        Button {
                            
                        } label: {
                            Text(item.rawValue)
                                .font(.system(size: 40))
                                .frame(width:100,height: 100)
                        }

                        
                        
                    }
                }
                
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity,maxHeight: getRect().height / 2)
        .background(Color.black.opacity(0.5))
        
    }
}

struct NumberKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        NumberKeyboardView()
    }
}

enum Number:String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case night = "9"
    case plus = "+"
    case minus = "-"
    case precent = "x"
    case divide = "/"
    case point = "."
}
