//
//  CategoryUploadView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 06.03.2023.
//

import SwiftUI

struct CategoryUploadView: View {
    @Binding var cancel:Bool
    @State var category = ""
    @State var selectedBG = ""
    @State var selectedIcon = ""
    @State var categoryBG: CategoryBG = .teel
    @State var showSelectedBG = false
    @State var showSelectedIcon = false
    let row = [GridItem(.flexible(maximum: 40))]
    let columns = Array(repeating: GridItem(.flexible(),spacing:20), count: 4)
    @EnvironmentObject var tVM : TransactionViewModel
    @Binding var showCategoryType:Bool
    var body: some View {
        VStack{
            
            HStack{
                Button {
                    withAnimation(.spring()){
                        cancel.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color(Color.wBColor))
                }

                Spacer()
                Text("Create new category")
                    .font(.callout.bold())
                Spacer()
                Button {
                    tVM.uploadCategory(name: category, color: selectedBG, imageName: selectedIcon, selectCategoryType: showCategoryType)
                    withAnimation(.spring()){
                        cancel.toggle()
                    }
                } label: {
                    Text("Save")
                }

            } 
            .padding()
            HStack{
                Circle()
                    .fill(showSelectedBG ?   Color(selectedBG) : Color.gray.opacity(0.3))
                    .overlay(content: {
                        Image(systemName: showSelectedIcon ? selectedIcon : "")
                            .foregroundColor(.white)
                    })
                    .frame(width: 70)
                VStack{
                    TextField("Category", text: $category)
                    
                    Rectangle()
                        .fill(Color(Color.wBColor))
                        .frame(height: 1)
                }
                .frame(width: 250)
                .padding()
            }
            ScrollView(.vertical){
                VStack{
                    
                    Text("Category color")
                        .font(.callout.bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    ScrollView(.horizontal){
                        LazyHGrid(rows: row) {
                            ForEach(CategoryBG.allCases,id: \.rawValue){ cBG in
                                Button {
                                    withAnimation(.spring()){
                                        self.showSelectedBG = true
                                        self.selectedBG = cBG.rawValue
                                    }
                                } label: {
                                    Circle()
                                        .fill(Color(cBG.rawValue))
                                        .frame(width: 30)
                                }
                                
                            }
                        }
                        
                    }
                }
                .padding()
                
                
                VStack{
                    Text("Category icon")
                        .font(.callout.bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    LazyVGrid(columns: columns){
                        ForEach(CategoryIcon.allCases,id: \.rawValue){ icon in
                            Button {
                              
                                    self.showSelectedIcon = true
                                
                                self.selectedIcon = icon.rawValue
                            } label: {
                                Circle()
                                    .frame(width: 70)
                                    .overlay {
                                        Image(systemName: icon.rawValue)
                                            .foregroundColor(.white)
                                    }
                            }

                           
                        }
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}

struct CategoryUploadView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryUploadView(cancel: .constant(false),showCategoryType: .constant(false))
            .environmentObject(TransactionViewModel())
    }
}


enum CategoryBG:String,CaseIterable {
    case green =  "green"
    case teel = "teel"
    case gray = "gray"
    case pink = "pink"
    case orange = "orange"
    case red = "red"
    case salamon = "salamon"
    case brown = "brown"
    case yellow = "yellow"
}


enum CategoryIcon:String,CaseIterable{
    case car =  "car"
    case bag = "bag"
    case house = "house"
    case tshirt = "tshirt"
    case airplane = "airplane"
    case tramfill = "tram.fill"
    case display = "display"
    case macbookandiphone = "macbook.and.iphone"
    case figureamericanfootball = "figure.american.football"
    case banknote = "banknote"
    case boltfill = "bolt.fill"
    case network = "network"
    case lightbulbfill = "lightbulb.fill"
    case crosscase = "cross.case"
    case cupandsaucer = "cup.and.saucer"
    case forkknife = "fork.knife"
}
