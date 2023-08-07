//
//  TransactionView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 16.02.2023.
//

import SwiftUI

struct TransactionView: View {
  @StateObject var transactionViewModel = TransactionViewModel()
    @State var showTransactionView = false
    @State var total:Double = 0.0
    @State var transactions: Transaction?
    var body: some View {
        
        ZStack(alignment:.bottomTrailing){
          
            VStack{

                    Text("Recent Activity")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding()
                
                    TransationList()
                        .environmentObject(transactionViewModel)
                
                
                Spacer()
            }
            HStack{
                Spacer()
               
                Spacer()
                Button {
                    withAnimation(.spring()){
                        showTransactionView.toggle()
                    }
                } label: {
                    Circle()
                        .fill(Color(Color.bGColor))
                        .frame(width: 60)
                        .shadow(radius: 10)
                        .overlay {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                }
            }
            .padding()
            
        } 
        .navigationTitle("Cash flow")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: SearchTransactionView()) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(Color.wBColor))
                }
            }
        })
        .sheet(isPresented: $showTransactionView) {
            TransactionUploadView(showExpensesView: $showTransactionView)
                .environmentObject(transactionViewModel)
        }
        .safeAreaInset(edge: .top) {
            VStack{
                HStack{
                    Spacer()
                    let data = transactionViewModel.calculated()
                    if !data.isEmpty {
                        let totalExpneses = data.last?.1 ?? 0
                        
                        Circle()
                            .stroke(Color.white)
                            .frame(width: 150)
                            .overlay {
                                Text("\(totalExpneses,format: .number)")
                                    .font(.system(size: 40))
                                    .bold()
                                
                            }
                       
                        
                    }
                    Spacer()
                    
                }
                .padding()
                
                NavigationLink {
                    OverView()
                } label: {
                    Text("Spending overviews")
                        .frame(width: 200,height: 50)
                        .background(.ultraThinMaterial)
                        .cornerRadius(.infinity)
                        .shadow(radius: 5)
                }
                .padding()
            }
            .background(Color(Color.bGColor))
            
        }
       
    }
    
    
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
           
    }
}
