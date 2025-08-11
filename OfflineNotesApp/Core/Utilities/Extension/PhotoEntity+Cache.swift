//
//  PhotoEntity+Cache.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import Foundation
import UIKit

extension PhotoEntity {
    var cachedImage: UIImage? {
        let key = id.uuidString as NSString

        if let cached = ImageCache.shared.object(forKey: key) {
            return cached
        }

        guard let originalImage = UIImage(data: imageData) else { return nil }

        let resizedImage = originalImage.resized(to: 150) ?? originalImage

        ImageCache.shared.setObject(resizedImage, forKey: key)
        return resizedImage
    }
}

extension UIImage {
    func resized(to maxDimension: CGFloat) -> UIImage? {
        let size = self.size
        let aspectRatio = size.width / size.height

        var newSize: CGSize
        if aspectRatio > 1 {
            newSize = CGSize(width: maxDimension, height: maxDimension / aspectRatio)
        } else {
            newSize = CGSize(width: maxDimension * aspectRatio, height: maxDimension)
        }

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }

    func compressedJPEGData(quality: CGFloat = 0.8) -> Data? {
        return self.jpegData(compressionQuality: quality)
    }
}

