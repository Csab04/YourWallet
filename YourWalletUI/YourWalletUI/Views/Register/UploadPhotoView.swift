//
//  UploadPhotoView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 25.01.2023.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct UploadPhotoView: View {
    @State var showImagePicker = false
    @State var photoItem: PhotosPickerItem?
    @State var  userProfilePicData: Data?
   @State  var selectedImage: UIImage?
    @State var profileImage: Image?
    @State var show = false
  
    @EnvironmentObject var authVM :  AuthViewModel
    var body: some View {
        
        NavigationStack{
            ZStack{
                VStack(spacing:50){
                    Text("Upload Photo")
                        .font(.title.bold())
                    HStack{
                        Spacer()
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Skip")
                        }
                        
                    }
                    .padding()
                    
                    VStack{
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Circle()
                                .fill(.ultraThickMaterial)
                                .overlay {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .foregroundColor(Color(Color.bGColor))
                                }
                        }
                        
                    }
                    .frame(width: 250)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .onTapGesture {
                        self.showImagePicker.toggle()
                    }
                    
                    if let selectedImage = selectedImage{
                        Button {
                            authVM.uploadImage(selectedImage)
                        } label: {
                            Button {
                                
                            } label: {
                                Text("Continue")
                                    .foregroundColor(.white)
                                    .frame(width: 350,height: 50)
                                    .background(Color(Color.bGColor))
                                    .cornerRadius(.infinity)
                            }
                        }
                        
                        
                    }
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $authVM.navigationHomeView) {
                    Home()
                }
                .blur(radius: authVM.showSuccesAlert ? 30 : 0)
                
               
                if authVM.showSuccesAlert {
                    SuccesRegisterView(succesLoding: $authVM.showSuccesAlert)
                }
            }
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    
}

struct UploadPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPhotoView()
            .environmentObject(AuthViewModel())
           
    }
}
