//
//  ProfileView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 09.02.2023.
//

import SwiftUI
import FirebaseFirestoreSwift
import SDWebImageSwiftUI
struct ProfileView: View {
    @StateObject var authVM :AuthViewModel = AuthViewModel()
    var user:User?
 
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading){
                if let user = authVM.myProfile {
                    ProfileRow(user: user)
                       
                }
                
                Spacer()
            }
           
        }
            .task {
                if authVM.myProfile != nil{return}
                await authVM.fetchUserData()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}


struct ProfileRow:View{
  @State var user:User
 
    var body: some View{
        VStack(spacing:20){
            VStack(spacing:20){
                WebImage(url:URL(string: user.profileImageUrl)).placeholder {
                    Circle()
                        .frame(width: 150)
                        .overlay {
                            ProgressView()
                                .foregroundColor(Color(Color.bGColor))
                        }
                }
                .resizable()
                .frame(width: 200,height: 200)
                .clipShape(Circle())
                
                NavigationLink(destination: UpdatePhotoView()) {
                    Text("Upload Photo")
                        .foregroundColor(Color(Color.wBColor))
                        .frame(width: 150,height: 40)
                        .background(.ultraThinMaterial)
                        .cornerRadius(.infinity)
                        .shadow(radius: 10)
                }
            }
            
            
            VStack(alignment: .leading,spacing: 20){
                TextField("", text: $user.name)
                    .font(.title2.bold())
                    .foregroundColor(Color(Color.wBColor))
                    
                TextField("", text: $user.email)
                    .font(.title2.bold())
                    .foregroundColor(Color(Color.wBColor))
                    
                
                TextField("", text: $user.password)
                    .font(.title2.bold())
                    .foregroundColor(Color(Color.wBColor))
                    
            }
           
        }
        .padding()
    }
}
