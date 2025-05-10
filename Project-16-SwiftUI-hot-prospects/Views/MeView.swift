//
//  MeView.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 28/04/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@site.com"
    
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                HStack {
                    Spacer()
                    Image(uiImage: qrCode)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .contextMenu {
                            ShareLink(
                                item: Image(uiImage: qrCode),
                                preview: SharePreview(
                                    "My QR Code",
                                    image: Image(uiImage: qrCode)
                                )
                            )
                        }
                    Spacer()
                }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImg = filter.outputImage {
            if let cgImg = context.createCGImage(
                outputImg,
                from: outputImg.extent
            ) {
                qrCode = UIImage(cgImage: cgImg)
                return qrCode
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

#Preview {
    MeView()
}
