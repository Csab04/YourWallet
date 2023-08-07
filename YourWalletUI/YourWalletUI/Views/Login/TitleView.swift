//
//  TitleView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 23.01.2023.
//

import SwiftUI

struct TitleView: View {
    var title: String
    var subTitle: String
    var symbolName:String
    var body: some View {
        VStack{
            HStack{
                Spacer()
             
                    Image(systemName: symbolName)
                    
            }
            Text(title)
                .font(.title.bold())
                .frame(maxWidth:.infinity,alignment:.leading)
                
            Text(subTitle)
                .font(.title3.italic())
                .frame(maxWidth:.infinity,alignment:.leading)
               
        }
        .foregroundColor(.white)
        .padding()
        .background {
            Color(Color.bGColor)
        }
        .clipShape(CustomCorner(corner: [.bottomRight], radius: 10))
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Your Wallet", subTitle: "Follow the way of your money, not just your dreams", symbolName: "gear")
         
    }
}
 


