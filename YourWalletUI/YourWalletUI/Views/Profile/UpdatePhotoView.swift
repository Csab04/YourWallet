//
//  UpdatePhotoView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 19.02.2023.
//

import SwiftUI

struct UpdatePhotoView: View {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    @State var selectedImage: UIImage?
    @State var showImagePicker = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    if let selectedImage = selectedImage {
                        authVM.uploadImage(selectedImage)
                    }
                   dismiss()
                } label: {
                    Text("Update")
                }

            }
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
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
        
}

struct UpdatePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePhotoView()
    }
}
