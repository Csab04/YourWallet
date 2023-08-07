//
//  CalendarView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 30.01.2023.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var tVM: TransactionViewModel
    @Environment(\.dismiss) var dissmiss
    @State var date : Date = Date()
    var body: some View {
        VStack{
            HStack{
                Button {
                    dissmiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(Color.wBColor))
                }

                Spacer()
                Text("Calendar")
                    .font(.title.bold())
                Spacer()
            }
            .padding()
           CalendarsView(date: $date)
                .clipShape(CustomCorner(corner: [.allCorners], radius: 20))
                .padding()
            List{
               
                    ForEach(Array(tVM.groupedByMonth()),id: \.key){month,transaction in
                        if month == date.displayFormatForSectiomHeader {
                            ForEach(transaction){ t in
                                if month.isEmpty {
                                   TransactionEmptyView()
                                } else {
                                    NavigationLink {
                                        TransactionsDetaliView(transaction: t)
                                    } label: {
                                        TransactionListRow(transaction: t)
                                    }
                                }
                            }
                        }
                    }
                    .refreshable {
                        tVM.readTransactions()
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(TransactionViewModel())
    }
}

struct CalendarsView:View{
    @Binding var date :Date
   
    var body: some View{
        VStack{
             
            DatePicker("", selection: $date,displayedComponents: .date)
                .datePickerStyle(.graphical)
            
        }
        .foregroundColor(.white)
        .background(Color.gray.opacity(0.2))
        .shadow(radius: 20)
    }
}
