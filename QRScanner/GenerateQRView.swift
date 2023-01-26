//
//  GenerateQRView.swift
//  QRScanner
//
//  Created by JonathanTriC on 24/01/23.
//

import SwiftUI
import CarBode
import AlertToast

struct GenerateQRView: View {
    @State var dataString: String = ""
    @State var QRString: String = ""
    @State var QRType = CBBarcodeView.BarcodeType.qrCode
    @State var rotate = CBBarcodeView.Orientation.up
    @State var QRImage: UIImage?
    @State private var showToast = false
    
    var body: some View {
        VStack {
            if QRString.isEmpty {
                TextField("Enter your link or text", text: $dataString)
                    .onSubmit {
                        QRString = dataString
                    }
                    .padding()
            } else {
                CBBarcodeView(
                    data: $QRString,
                    barcodeType: $QRType,
                    orientation: $rotate
                )
                { image in
                    self.QRImage = image
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 400,
                    maxHeight: 400,
                    alignment: .topLeading
                )
                
                Button {
                    guard let imgQR = QRImage else { return }
                    let ciImage = imgQR.ciImage
                    let context = CIContext()
                    let cgImage = context.createCGImage(ciImage!, from: ciImage!.extent)
                    let uiImage = UIImage(cgImage: cgImage!)
                    let imageSaver = ImageSaver()
                    imageSaver.writeToPhotoAlbum(image: uiImage)
                    showToast = true
                } label: {
                    Text("Save To Photos")
                }
                .toast(isPresenting: $showToast) {
                    AlertToast(
                        displayMode: .alert,
                        type: .complete(Color.green),
                        title: "Success!")
                }
                .padding()
                
                Button {
                    QRString = ""
                    dataString = ""
                } label: {
                    Text("Generate New QR Code")
                }
                .padding()
                
            }
        }
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("error: \(error.localizedDescription)")
        } else {
            print("Save completed!")
        }
    }
}


struct GenerateQRView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateQRView()
    }
}
