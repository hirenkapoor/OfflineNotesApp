//
//  TitleText.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import SwiftUI

struct AppText: View {
    let text: String
    
    var font: Font = .body
    var fontWeight: Font.Weight? = nil
    var foregroundColor: Color = .primary
    var multilineTextAlignment: TextAlignment = .leading
    var lineLimit: Int? = nil
    var truncationMode: Text.TruncationMode = .tail
    
    var paddingTop: CGFloat? = nil
    var paddingBottom: CGFloat? = nil
    var paddingHorizontal: CGFloat? = nil
    
    var frameMaxWidth: CGFloat? = .infinity
    var frameAlignment: Alignment = .leading
    
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(foregroundColor)
            .multilineTextAlignment(multilineTextAlignment)
            .lineLimit(lineLimit)
            .truncationMode(truncationMode)
            .frame(maxWidth: frameMaxWidth, alignment: frameAlignment)
            .padding(.top, paddingTop ?? 0)
            .padding(.bottom, paddingBottom ?? 0)
            .padding(.horizontal, paddingHorizontal ?? 0)
    }
}
