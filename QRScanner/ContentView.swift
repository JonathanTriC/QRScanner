//
//  ContentView.swift
//  QRScanner
//
//  Created by JonathanTriC on 24/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("icon")
                Text("QR Scanner")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.indigo)
                
                Spacer()
                
                NavigationLink(destination: QRScanView()) {
                    Text("Scan QR Code")
                }
                .foregroundColor(Color.blue)
                .padding()
                
                NavigationLink(destination: GenerateQRView()) {
                    Text("Generate New QR Code")
                }
                .foregroundColor(Color.indigo)
                .padding()
                
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
