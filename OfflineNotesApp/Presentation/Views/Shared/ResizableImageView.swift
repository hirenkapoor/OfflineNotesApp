//
//  ResizableImageView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import SwiftUI
import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}

struct ResizableImageView: View {
    let imageData: Data?
    let placeholderColor: Color
    let cornerRadius: CGFloat
    let width: CGFloat
    let height: CGFloat

    init(imageData: Data?,
         placeholderColor: Color = Color.gray.opacity(0.3),
         cornerRadius: CGFloat = 8,
         width: CGFloat,
         height: CGFloat) {
        self.imageData = imageData
        self.placeholderColor = placeholderColor
        self.cornerRadius = cornerRadius
        self.width = width
        self.height = height
    }

    private func cachedImage() -> UIImage? {
        guard let data = imageData else { return nil }
        let key = NSString(string: data.base64EncodedString())
        if let cached = ImageCache.shared.object(forKey: key) {
            return cached
        }
        if let image = UIImage(data: data) {
            ImageCache.shared.setObject(image, forKey: key)
            return image
        }
        return nil
    }

    var body: some View {
        Group {
            if let uiImage = cachedImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            } else {
                Rectangle()
                    .fill(placeholderColor)
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
            }
        }
    }
}
