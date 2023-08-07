//
//  LoadingView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 25.01.2023.
//

import SwiftUI

struct LoadingView: View {
    @Binding var show:Bool
    var body: some View {
        ZStack{
            if show{
                Group {
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.black.opacity(0.5),in:RoundedRectangle(cornerRadius:15,style: .continuous))
                }
            }
        }
        .animation(.easeOut(duration: 0.25), value: show)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(show: .constant(false))
        LoadingView(show: .constant(false))
            .preferredColorScheme(.dark)
    }
}
