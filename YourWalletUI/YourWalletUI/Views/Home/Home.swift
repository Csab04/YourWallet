//
//  Home.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 07.02.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
struct Home: View {
   
    @State var showMenu:Bool = false
    @State var myProfile:User?
    var body: some View {
        NavigationStack{
            ZStack(alignment:.topLeading){
               TransactionView()
                    .navigationBarHidden(showMenu)
                    .environmentObject(TransactionViewModel())
                if showMenu {
                    ZStack{
                        Color(.black).opacity(0.25)
                    }
                    .onTapGesture {
                        withAnimation(.spring()){
                            showMenu.toggle()
                        }
                    }
                    .ignoresSafeArea()
                }
                  
                
                SideMenu(show: $showMenu)
                    .frame(width:300)
                    .offset(x: showMenu ? 0 : -350,y:0)
                
            }
            .navigationTitle("Home")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                   
                        Button {
                            withAnimation(.spring()){
                                self.showMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(Color(Color.wBColor))
                        }
                       
                 
                    
                }
                
                ToolbarItem(placement:.navigationBarTrailing) {
                    VStack{
                        if let myProfile = myProfile {
                            WebImage(url:URL(string: myProfile.profileImageUrl)).placeholder {
                                Circle()
                                    .frame(width: 150)
                                    .overlay {
                                        ProgressView()
                                            .foregroundColor(Color(Color.bGColor))
                                    }
                            }
                            .resizable()
                            .frame(width: 50,height: 50)
                            .clipShape(Circle())
                        }
                       
                    }
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    
                }
            }
            .onAppear(){
                showMenu = false
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
        Home()
            .preferredColorScheme(.dark)
    }
}
