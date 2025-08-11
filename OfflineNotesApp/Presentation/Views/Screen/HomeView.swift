//
//  HomeView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//


import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel
    @EnvironmentObject var router: Router

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: Constants.Home.homeTitle,
                showBackButton: false,
                trailingButtonTitle: Constants.Home.logoutButton,
                trailingAction: {
                    vm.logout()
                }
            )

            if vm.notes.isEmpty {
                EmptyStateText(text: Constants.Home.noNotesAvailable)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(vm.notes, id: \.id) { note in
                    Button {
                        router.push(.noteDetail(note: note))
                    } label: {
                        NoteRowView(note: note)
                    }
                }
                .listStyle(.plain)
            }

            AppButton(title: Constants.Home.addNoteButton) {
                router.push(.addNote(userId: vm.userId))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true) 
        .onChange(of: vm.didLogout) { loggedOut in
            if loggedOut {
                router.resetToLogin()
            }
        }
        .onAppear {
            vm.fetchNotes()
        }
    }
}
