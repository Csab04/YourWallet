//
//  MemojiViews.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 06.02.2023.
//

import SwiftUI

struct MemojiViews: View {
    var image:String
    var color:Color
    var body: some View {
        VStack{
            Circle()
                .fill(color)
                .frame(width: 160)
                .overlay {
                    Image(image)
                        .resizable()
                        .frame(width: 100,height: 100)
                }
                .shadow(color: color, radius: 7)
           
        }
    }
}

struct MemojiViews_Previews: PreviewProvider {
    static var previews: some View {
        MemojiViews(image: "csab1", color: .purple.opacity(0.3))
    }
}
