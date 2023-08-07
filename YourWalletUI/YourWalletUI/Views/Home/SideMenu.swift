//
//  SideMenu.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 07.02.2023.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
struct SideMenu: View {
    @Binding var show: Bool
    @State var myProfile: User?
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        VStack(alignment:.leading,spacing: 32){
            HStack{
                Spacer()
                Button {
                    withAnimation(.spring()){
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.white)
                }
                .padding()

            }
            if let myProfile = authViewModel.myProfile {
                UserRow(user: myProfile)
                    
            }
            VStack(alignment:.leading,spacing:20){
                NavigationLink {
                   
                        ProfileView()
                    
                } label: {
                    Label("Profile", systemImage: "person")
                }
                NavigationLink {
                    NotificationView()
                } label: {
                    Label("Notification", systemImage: "bell")
                }
                
                NavigationLink {
                    SecurityView()
                } label: {
                    Label("Security", systemImage: "lock")
                }
                NavigationLink {
                    CalendarView()
                } label: {
                    Label("Calendar", systemImage: "calendar")
                }
                NavigationLink {
                    CategorySettnigs()
                } label: {
                    Label("Category", systemImage: "book")
                }


            }
            .foregroundColor(.white)
            .padding()
            Spacer()
            Divider()
            VStack(alignment:.leading,spacing: 20){
                NavigationLink {
                    HelpView()
                } label: {
                    Label("Help", systemImage: "questionmark")
                    
                }
                
                Button {
                    authViewModel.signOut()
                } label: {
                    Label("Logout", systemImage: "chevron.left")
                }

            }
            .foregroundColor(.white)
            .padding()
        }
        .background(Color(Color.bGColor))
        .task {
            if authViewModel.myProfile != nil{return}
            await authViewModel.fetchUserData()
        }
        .refreshable {
            await authViewModel.fetchUserData()
        }
        
       
    }
    
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(show: .constant(false))
            .environmentObject(AuthViewModel())
    }
}


struct UserRow:View{
    var user:User
    var body: some View{
        HStack(spacing:30){
            WebImage(url:URL(string: user.profileImageUrl)).placeholder {
                Circle()
                    .frame(width: 70)
                    .overlay {
                        ProgressView()
                    }
            }
            .resizable()
            .frame(width: 70,height: 70)
            .clipShape(Circle())
            
           
            VStack{
                Text(user.name)
                    .foregroundColor(.white)
                Text(user.email)
                    .font(.system(size: 11))
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}


// else if viewModel == .logout{
//    Button {
//        authViewModel.signOut()
//    } label: {
//        SideMenuOptionRowView(viewModel: viewModel)
//
//    }
//
//} else {
//        SideMenuOptionRowView(viewModel: viewModel)
//
//}
