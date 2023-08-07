//
//  HelpView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 30.01.2023.
//

import SwiftUI

struct HelpView: View {
    @State var message = ""
    var body: some View {
        NavigationStack{
            VStack{
                
            }
            .navigationTitle("Help")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
