//
//  ResetPasswordAlertsView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 25.01.2023.
//

import SwiftUI

struct ResetPasswordAlertsView: View {
 @State var email:String = ""
    @Binding var showRAV:Bool
    @ObservedObject var authVM = AuthViewModel()
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    withAnimation(.spring()){
                    }
                    showRAV.toggle()
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                        .padding()
                }
            }
                
                Text("Resend Password")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                  
            
            VStack{
                VStack{
                    Text("Please add your email adrass")
                    
                    VStack{
                        TextField("EX:Mark.Smith@yahoo.com", text: $email)
                            Rectangle()
                            .frame(height: 1)
                    }
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                Button {
                    withAnimation(.spring()){
                        authVM.resetPassword(email: email)
                        showRAV.toggle()
                    }
                } label: {
                    Text("Send Link")
                        .foregroundColor(Color(Color.bGColor))
                        .frame(width: 200,height: 50)
                        .background(.white)
                        .cornerRadius(.infinity)
                }
                .padding()
            }
            Spacer()
        }
        .frame(width: 350,height: 300)
        .background{
            RoundedRectangle(cornerRadius: 15,style: .continuous)
                .fill(Color(Color.bGColor))
                .shadow(radius: 20)
        }
    }
}

struct ResetPasswordAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordAlertsView( showRAV: .constant(false))
    }
}
