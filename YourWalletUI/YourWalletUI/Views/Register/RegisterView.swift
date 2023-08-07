//
//  RegisterView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 23.01.2023.
//

import SwiftUI

struct RegisterView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var visibile = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var registerVM : AuthViewModel
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                    ScrollView{
                        
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
                            
                            VStack{
                                //               MARK: TextFields
                                VStack(alignment:.leading){
                                    RegisterTF(title: "Name", textField: $name, subTitle: "Ex:Mark Smtih")
                                    RegisterTF(title: "E-mail", textField: $email, subTitle: "Ex:mark.smith12@example.ex")
                                        .keyboardType(.emailAddress)
                                    
                                    RegisterPasswordTF(title: "Password", textField: $password, subTitle: "********", visibile: $visibile)
                                }
                                
                                Button {
                                    registerVM.registUser(name: name, email: email, password: password)
                                } label: {
                                    Text("Continue")
                                        .foregroundColor(.white)
                                        .frame(width: 350,height: 50)
                                        .background(Color(Color.bGColor))
                                        .cornerRadius(.infinity)
                                }
                                .disableWithOpacity(name == "" || email == "" || password == "")
                                .padding()
                                
                                .padding()
                                Spacer()
                                HStack{
                                    Text("Already have an account?")
                                    Button {
                                        dismiss()
                                    } label: {
                                        Text("Sign in")
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .blur(radius: registerVM.showError ? 30 : 0)
            
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $registerVM.showUploadPhotoView) {
                  UploadPhotoView()
                }
                .overlay {
                    LoadingView(show: $registerVM.isLoading)
                }
                if  registerVM.showError {
                    ErrorAlertsView(errorMessage: registerVM.errorMessage, errorLoading: $registerVM.showError)
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(AuthViewModel())
            
    }
}
 
extension View {
    func disableWithOpacity(_ condition:Bool)-> some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
        
    }
}


struct RegisterTF: View{
    var title:String
@Binding   var textField:String
    var subTitle:String
    var body: some View{
        VStack(alignment:.leading){
            Text(title)
                .fontWeight(.heavy)
            
           TextField(subTitle, text: $textField)
                .padding(.leading,24)
                .frame(width: 350,height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(.infinity)

        }
    }
}


struct RegisterPasswordTF:View{
    var title:String
@Binding   var textField:String
    var subTitle:String
    @Binding var visibile:Bool
    var body: some View{
        VStack(alignment:.leading){
            Text("Password")
                .fontWeight(.heavy)
        VStack{
            
            if visibile {
                TextField("********", text: $textField)
                    .padding(.leading,24)
                    .frame(width: 350,height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(.infinity)
            } else{
                SecureField("********", text: $textField)
                    .padding(.leading,24)
                    .frame(width: 350,height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(.infinity)
            }
        }
        .overlay(
            HStack{
                Spacer()
                Button {
                    withAnimation(.spring()){
                        self.visibile.toggle()
                    }
                } label: {
                    Image(systemName: visibile ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(Color(Color.wBColor))
                }
                .padding()
                
            }
            
        )
    }
    }
}
