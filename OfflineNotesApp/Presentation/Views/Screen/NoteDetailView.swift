//
//  NoteDetailView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import SwiftUI

struct NoteDetailView: View {
    let note: NoteEntity
    @EnvironmentObject var router: Router

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: "Note Detail",
                showBackButton: true,
                onBack: {
                    router.pop()
                }
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AppText(
                        text: note.title,
                        font: .largeTitle,
                        fontWeight: .bold,
                        frameMaxWidth: .infinity,
                        frameAlignment: .leading
                    )
                    AppText(
                        text: note.desc,
                        font: .body,
                        frameMaxWidth: .infinity,
                        frameAlignment: .leading
                    )
                    HorizontalImageScrollView(imagesData: note.photos.map { $0.imageData })
                }
                .padding()
            }
        }
        .navigationBarHidden(true) 
    }
}

struct HorizontalImageScrollView: View {
    let imagesData: [Data?]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(imagesData.indices, id: \.self) { index in
                    ResizableImageView(
                        imageData: imagesData[index],
                        cornerRadius: 12,
                        width: 150,
                        height: 150
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
                }
            }
            .padding(.vertical)
        }
    }
}
