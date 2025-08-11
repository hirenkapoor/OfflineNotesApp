//
//  AddNoteView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import SwiftUI
import PhotosUI

struct AddNoteView: View {
    @StateObject private var vm: AddNoteViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isInputActive: Bool
    @EnvironmentObject var router: Router
    @State private var showPhotoPicker = false
    
    init(vm: AddNoteViewModel) {
            _vm = StateObject(wrappedValue: vm)
        }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: "Add New Note",
                showBackButton: true,
                onBack: {
                    router.pop()
                }
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Title Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title").font(.headline)
                        TextField("Enter title", text: $vm.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .focused($isInputActive)
                    }
                    
                    // Description Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description").font(.headline)
                        FixedHeightTextView(text: $vm.description, height: 200)
                            .frame(height: 200)
                            .cornerRadius(8)
                    }
                    
                    // Photos
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Photos").font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(vm.photos, id: \.self) { photo in
                                    Image(uiImage: photo)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .clipped()
                                        .cornerRadius(8)
                                }
                                if vm.photos.count < 10 {
                                    AddPhotoButton {
                                        isInputActive = false
                                        requestPhotoLibraryPermission()
                                        showPhotoPicker = true
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    
                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding(.top, 5)
                    }
                    
                    Button(action: {
                        isInputActive = false
                        vm.saveNote()
                    }) {
                        Text("Save Note")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                (vm.title.isEmpty || vm.description.isEmpty || vm.photos.isEmpty) ?
                                Color.gray : Color.blue
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(vm.title.isEmpty || vm.description.isEmpty || vm.photos.isEmpty)
                    .padding(.vertical)
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
            }
            .onTapGesture {
                isInputActive = false
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selectionLimit: 10) { images in
                for img in images {
                    vm.addPhoto(img)
                }
                showPhotoPicker = false
            }
        }
        .alert(isPresented: $vm.isNoteSaved) {
            Alert(
                title: Text("Success"),
                message: Text("Note saved successfully"),
                dismissButton: .default(Text("OK")) {
                    vm.clearFields()
                    router.pop()
                }
            )
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                break
            case .denied, .restricted:
                // Here you can add a user alert if needed
                break
            case .notDetermined:
                break
            @unknown default:
                break
            }
        }
    }
}

struct AddPhotoButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                Text("Add Photo")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 90, height: 90)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

struct FixedHeightTextView: UIViewRepresentable {
    @Binding var text: String
    var height: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: FixedHeightTextView
        
        init(_ parent: FixedHeightTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
