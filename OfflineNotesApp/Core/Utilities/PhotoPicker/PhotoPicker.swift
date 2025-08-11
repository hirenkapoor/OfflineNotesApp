//
//  PhotoPicker.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation
import SwiftUI
import PhotosUI

import SwiftUI
import PhotosUI
import Photos

struct PhotoPicker: UIViewControllerRepresentable {
    var selectionLimit: Int = 5
    var onComplete: ([UIImage]) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = selectionLimit
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard !results.isEmpty else {
                parent.onComplete([])
                return
            }

            var images: [UIImage] = []
            let group = DispatchGroup()

            for result in results {
                if let assetId = result.assetIdentifier {
                    // Load via PhotoKit for HEIF/HEIC support
                    let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject
                    if let asset = asset {
                        group.enter()
                        let options = PHImageRequestOptions()
                        options.isSynchronous = false
                        options.isNetworkAccessAllowed = true
                        options.deliveryMode = .highQualityFormat

                        PHImageManager.default().requestImageDataAndOrientation(for: asset, options: options) { data, _, _, _ in
                            if let data = data, let image = UIImage(data: data) {
                                images.append(image)
                            }
                            group.leave()
                        }
                    }
                } else if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    // Fallback for normal cases
                    group.enter()
                    result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
                        if let image = object as? UIImage {
                            images.append(image)
                        }
                        group.leave()
                    }
                }
            }

            group.notify(queue: .main) {
                self.parent.onComplete(images)
            }
        }
    }
}
