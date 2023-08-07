//
//  LoginView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 23.01.2023.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var visibile = false
    @State var showResetPassView = false
    @EnvironmentObject var authVM : AuthViewModel
   
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                
                        Text("Sign in")
                        .font(.title)
                        .fontWeight(.bold)
                    VStack{
                        ZStack{
                            
                            HStack{
                                MemojiViews(image: "csab2", color: .purple.opacity(0.3))
                                Spacer()
                                MemojiViews(image: "csab1", color: .green.opacity(0.3))
                            }
                            MemojiViews(image: "anya1", color: .yellow.opacity(0.3))
                        }
                        .padding()
                        
                        RegisterTF(title: "E-mail", textField: $email, subTitle: "Ex:mark.smith12@example.ex")
                      RegisterPasswordTF(title: "Password", textField: $password, subTitle: "********", visibile: $visibile)
                        
                        HStack{
                            Spacer()
                            Button {
                                withAnimation(.spring()){
                                    self.showResetPassView.toggle()
                                }
                            } label: {
                                Text("Forgat Password")
                                    .foregroundColor(Color(Color.wBColor))
                                
                                    .padding()
                            }
                            
                        }
                        
                        Button {
                            authVM.login(email: email, password: password)
                        } label: {
                            Text("Login")
                                .foregroundColor(.white)
                                .frame(width: 350,height: 50)
                                .background(Color(Color.bGColor))
                                .cornerRadius(.infinity)
                        }
                        
                    }
                    
                    Spacer()
                    HStack{
                        Text("Don't have an account?")
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Sign up")
                        }
                        
                    }
                }
                .overlay {
                    LoadingView(show: $authVM.isLoading)
                }
                .blur(radius: showResetPassView ? 30 : 0)
                .blur(radius: authVM.showError ? 30 : 0)


                if showResetPassView {
                    ResetPasswordAlertsView(showRAV: $showResetPassView)
                }  else {
                    
                    if authVM.showError {
                        ErrorAlertsView(errorMessage: authVM.errorMessage, errorLoading: $authVM.showError)
                        
                    }
                }
            }
            
            .navigationBarBackButtonHidden(true)
           
        }
        .navigationSplitViewStyle(.automatic)
       
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
            
    }
}
