//
//  ContentView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 23.01.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM : AuthViewModel
    var body: some View {
        if authVM.logged{
         Home()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

