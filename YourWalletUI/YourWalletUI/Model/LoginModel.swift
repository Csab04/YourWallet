//
//  LoginModel.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 23.01.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class AuthViewModel:ObservableObject{
    @AppStorage("logged") var logged: Bool = false
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var isLoading = false
    @Published var users : [User] = []
    @Published var myProfile:User?
    @Published var userProfilePickData : Data?
    @Published var showUploadPhotoView = false
    @Published var navigationHomeView = false
    @Published var showSuccesAlert = false
    func login(email:String,password:String){
        self.isLoading = true
        Task{
            do{
                try await Auth.auth().signIn(withEmail: email, password: password)
                
                withAnimation(.spring()){
                    self.logged.toggle()
                }
                
                print("User logged")
              
            } catch{
                await setError(error)
                print("Error:\(error.localizedDescription)")
            }
        }
    }
    
    
    
    func signOut(){
       
        withAnimation(.spring()){
            self.logged = false
        }
        try! Auth.auth().signOut()
    }
     
    
    func resetPassword(email:String){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: email)
               
            } catch{
                await setError(error)
            }
        }
    }
    
    func registUser(name:String,email:String,password:String){
        self.isLoading = true
        Task{
            do{
              try await Auth.auth().createUser(withEmail: email, password: password)
                guard let uid = Auth.auth().currentUser?.uid else{return}
               
                let user = User(name: name, email: email, password: password, profileImageUrl: "", uid: uid)
                let _ = try Firestore.firestore().collection("User").document(uid).setData(from: user) { error in
                    if error == nil{
                        print("Saved succesfully")
                        withAnimation(.spring()){
                            self.showUploadPhotoView = true
                        }
                    }
                }
            } catch{
                try await Auth.auth().currentUser?.delete()
                await setError(error)
            }
        }
    }
    
   
    func fetchUserData()async{
        guard let userUID = Auth.auth().currentUser?.uid else{return}
        guard let user = try? await Firestore.firestore().collection("User").document(userUID).getDocument(as: User.self) else{return}
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    func deleteAccunt(){
        Task{
            do{
                guard let uid = Auth.auth().currentUser?.uid else{return}
                let fileName = NSUUID().uuidString
                
                let ref = Storage.storage().reference(withPath: "/profile/image\(fileName)")
                try await ref.delete()
                
                try await Firestore.firestore().collection("User").document(uid).delete()
                
                try await Auth.auth().currentUser?.delete()
                self.logged = false
            } catch{
               await  setError(error)
            }
        }
    }
     
    
    func uploadImage(_ image:UIImage){
        self.isLoading = true
        Task{
            do{
                guard let uid = Auth.auth().currentUser?.uid else {return}
                ImageUploader.uploadImage(image: image) { profileImageUrl in
                    Firestore.firestore().collection("User").document(uid).updateData(["profileImageUrl":profileImageUrl]) { error in
                        if error == nil{
                            print("Saved succesfully photo")
                            withAnimation(.spring()){
                                withAnimation(.spring()){
                                    self.showSuccesAlert.toggle()
                                }
                            }
                            
                        } else {
                            print("Error uplod photo:\(error!.localizedDescription)")
                        }
                        
                    }
                }
            } 
            
        }
    }
    
    
    func setError(_ error:Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError = true
            isLoading = false
        })
    }
}

