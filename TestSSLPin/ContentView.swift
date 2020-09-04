//
//  ContentView.swift
//  TestSSLPin
//
//  Created by Mac on 04.09.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    let baseURLYahoo = "https://www.yahoo.com/"
    let baseURLDT = "https://www.google.ru/"
    let net = NetManager.shared
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                self.net.loadURL(url: URL(string: self.baseURLYahoo)!) { (res) in
                    self.alertMessage = res
                    self.showAlert = true
                }
            }) {
                Text("Wrong SSL")
                    .foregroundColor(.white)
                    .background(Color.red)
                    .frame(width: 100, height: 50)
            }

            Button(action: {
                self.net.loadURL(url: URL(string: self.baseURLDT)!) { (res) in
                    self.alertMessage = res
                    self.showAlert = true
                }
            }) {
                Text("Correct SSL")
                    .foregroundColor(.white)
                    .background(Color.green)
                    .frame(width: 100, height: 50)
            }
        }
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text("Test Result"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                self.showAlert = false
            }))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
