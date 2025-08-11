//
//  EmptyStateText.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import SwiftUI

struct EmptyStateText: View {
    let text: String

    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center) 
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
