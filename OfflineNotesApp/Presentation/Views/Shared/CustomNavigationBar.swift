//
//  CustomNavigationBar.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    var showBackButton: Bool = false
    var onBack: (() -> Void)? = nil
    var trailingButtonTitle: String? = nil
    var trailingAction: (() -> Void)? = nil

    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    onBack?()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.blue)
                }
            } else {
                Spacer().frame(width: 44)
            }

            Spacer()

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()

            if let trailingTitle = trailingButtonTitle {
                Button(action: {
                    trailingAction?()
                }) {
                    Text(trailingTitle)
                        .foregroundColor(.red)
                        .font(.system(size: 16, weight: .medium))
                }
            } else {
                Spacer().frame(width: 44)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
