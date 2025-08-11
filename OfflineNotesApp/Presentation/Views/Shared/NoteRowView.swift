//
//  NoteRowView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import SwiftUI

struct NoteRowView: View {
    let note: NoteEntity

    var body: some View {
        HStack {
            ResizableImageView(
                imageData: note.photos.first?.imageData,
                width: 60,
                height: 60
            )

            VStack(alignment: .leading) {
                AppText(text: note.title, font: .headline)
                AppText(
                    text: note.desc.prefix(50) + "...",
                    font: .subheadline,
                    foregroundColor: .gray
                )
            }
        }
    }
}
