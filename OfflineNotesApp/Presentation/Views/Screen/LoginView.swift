//
//  LoginView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm: LoginViewModel
    @EnvironmentObject var router: Router
    @FocusState private var isInputActive: Bool

    var body: some View {
        VStack(spacing: 0) {
            
            CustomNavigationBar(title: Constants.Login.loginTitle)

            ScrollView {
                VStack(spacing: 20) {
                    AppText(
                        text: Constants.Login.welcomeBack,
                        font: .largeTitle,
                        fontWeight: .bold,
                        paddingTop: 40,
                        frameAlignment: .center
                    )
                    
                    VStack(spacing: 15) {
                        AppTextField(
                            placeholder: Constants.Login.emailOrMobilePlaceholder,
                            text: $vm.emailOrMobile,
                            keyboardType: .emailAddress,
                            isSecure: false,
                            textContentType: .emailAddress
                        ).focused($isInputActive)

                        AppTextField(
                            placeholder: Constants.Login.passwordPlaceholder,
                            text: $vm.password,
                            isSecure: true,
                            textContentType: .password
                        ).focused($isInputActive)
                    }
                    .padding(.horizontal, 24)

                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }

                    AppButton(title: Constants.Login.loginButton,
                              isEnabled: vm.isFormValid) {
                        isInputActive = false
                        vm.login()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)

                    Button(action: {
                        isInputActive = false
                        router.setRoot(.signup)
                    }) {
                        Text(Constants.Login.noAccountText)
                            .foregroundColor(.blue)
                            .underline()
                    }
                    .padding(.top, 20)

                    Spacer()
                }
            }
            .background(Color(UIColor.systemBackground).ignoresSafeArea())
            .onChange(of: vm.isLoginSuccess) { success in
                if success, let user = vm.loggedInUser {
                    DispatchQueue.main.async {
                        router.setRoot(.home(userId: user.id))
                    }
                }
            }
            .onTapGesture {
                isInputActive = false
            }
        }
        .navigationBarHidden(true) 
    }
}

private extension LoginViewModel {
    var isFormValid: Bool {
        !emailOrMobile.isEmpty && !password.isEmpty
    }
}
