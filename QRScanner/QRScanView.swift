//
//  QRScanView.swift
//  QRScanner
//
//  Created by JonathanTriC on 24/01/23.
//

import SwiftUI
import CarBode
import AVFoundation
import AlertToast

struct QRScanView: View {
    @Environment(\.openURL) var openURL
    @State private var showToast = false
    @State private var showAlert = false
    @State private var value = ""
    
    var body: some View {
        VStack {
            CBScanner(
                supportBarcode: .constant([.qr, .code128]),
                scanInterval: .constant(5.0)
            ){
                if !$0.value.isEmpty{
                    value = $0.value
                    if $0.value.contains("http") || $0.value.contains("://") {
                        openURL(URL(string: $0.value)!)
                    } else {
                        UIPasteboard.general.setValue(
                            $0.value,
                            forPasteboardType: UTType.plainText.identifier)
                        showToast = true
                    }
                }
                print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
            }
        onDraw: {
            let lineWidth = 2.0
            let lineColor = UIColor.blue
            let fillColor = UIColor.clear
            $0.draw(lineWidth: lineWidth, lineColor: lineColor, fillColor: fillColor)
        }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .banner(.slide), type: .regular, title: "Text copied to clipboard!", subTitle: value)
        }
    }
}

struct QRScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRScanView()
    }
}
