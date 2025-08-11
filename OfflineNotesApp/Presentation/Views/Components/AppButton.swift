//
//  AppButton.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import SwiftUI

struct AppButton: View {
    var title: String
    var isEnabled: Bool = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isEnabled ? Color.blue : Color.gray)
                .cornerRadius(10)
        }
        .disabled(!isEnabled)
    }
}
