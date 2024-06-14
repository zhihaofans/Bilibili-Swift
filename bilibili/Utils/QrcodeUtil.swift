//
//  QrcodeUtil.swift
//  bilibili
//
//  Created by zzh on 2024/6/14.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins
class QrcodeUtil{
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    func generateQRCode(from string: String) -> NSImage? {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let size = NSSize(width: outputImage.extent.width, height: outputImage.extent.height)
                let nsImage = NSImage(cgImage: cgimg, size: size)
                return nsImage
            }
        }
        return nil
    }
}
