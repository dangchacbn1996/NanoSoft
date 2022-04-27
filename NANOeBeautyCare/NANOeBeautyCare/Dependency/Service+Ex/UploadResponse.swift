//
//  UploadResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/19/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

let resizeImageWidth: CGFloat = 800.0

// MARK: - UploadResponse
struct UploadResponse: Codable {
    var code: Int?
    var msg: String?
    var data: [UploadResponseDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct UploadResponseDatum: Codable {
    var url: String?

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
extension UIImage
{
    // convenience function in UIImage extension to resize a given image
    func convert(toSize size:CGSize, scale:CGFloat) ->UIImage
    {
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return copied!
    }
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage

        let size = self.size
        let aspectRatio =  size.width/size.height

        switch contentMode {
            case .scaleAspectFit:
                if aspectRatio > 1 {                            // Landscape image
                    width = dimension
                    height = dimension / aspectRatio
                } else {                                        // Portrait image
                    height = dimension
                    width = dimension * aspectRatio
                }

        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }

        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = opaque
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
                newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }

        return newImage
    }
}

