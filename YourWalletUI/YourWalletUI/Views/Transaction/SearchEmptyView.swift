//
//  SearchEmptyView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 03.03.2023.
//

import SwiftUI

struct SearchEmptyView: View {
    var body: some View {
        VStack{
            Circle()
                .fill(Color(Color.bGColor))
                .frame(width: 250)
                .overlay {
                    Image(systemName: "doc.text.magnifyingglass")
                        .resizable()
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 160,height: 180)
                        
                }
            
            Text("There are no transactions!")
                .font(.title.bold())
            Text("Are you a productiv person? I think you should, click the plus botton and add bunch of transactions to your wallet ")
        }
        .padding()
    }
}

struct SearchEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEmptyView()
    }
}
