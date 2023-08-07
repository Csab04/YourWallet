//
//  SecurityView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 30.01.2023.
//

import SwiftUI

struct SecurityView: View {
    @State var turnOnB = false
    @State var securityCodToggle = false
    var body: some View {
        NavigationStack{
            List{
                HStack{
                    Text("FaceID/TouchID")
                    Spacer()
                    Toggle("", isOn: $turnOnB)
                }
                HStack{
                    Text("Security cod")
                    Spacer()
                    Toggle("", isOn: $securityCodToggle)
                }
            }
            .navigationTitle("Security")
            .navigationBarTitleDisplayMode(.inline)
        }
       
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
