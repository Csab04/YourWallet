//
//  NotificationView.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 30.01.2023.
//

import SwiftUI

struct NotificationView: View {
    @State var enableNoti = false
    @State var reminder: Date = Date()
    var body: some View {
        NavigationStack{
            List{
                HStack{
                    Text("Enable notification")
                    Spacer()
                    Toggle("", isOn: $enableNoti)
                }
                
                DatePicker("Set reminder", selection: $reminder)
                    .datePickerStyle(.compact)
            }
            .navigationTitle("Notification")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
