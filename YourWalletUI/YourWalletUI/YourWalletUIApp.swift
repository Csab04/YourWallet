//
//  YourWalletUIApp.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 23.01.2023.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
 

@main
struct YourWalletUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authVM = AuthViewModel()
    @StateObject var transactionViewModel = TransactionViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .environmentObject(authVM)
                    .environmentObject(transactionViewModel)
                   
            }
            .navigationSplitViewStyle(.balanced)
        }
    }
}
