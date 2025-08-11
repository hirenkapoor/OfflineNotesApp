//
//  SignupView.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var vm: SignupViewModel
    @EnvironmentObject var router: Router
    @FocusState private var isInputActive: Bool

    init(viewModel: SignupViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0) {
            
            CustomNavigationBar(title: Constants.Signup.signupTitle)

            ScrollView {
                VStack(spacing: 20) {
                    AppText(
                        text: Constants.Signup.createAccount,
                        font: .largeTitle,
                        fontWeight: .bold,
                        paddingTop: 40,
                        frameAlignment: .center
                    )
                    
                    VStack(spacing: 15) {
                        AppTextField(placeholder: Constants.Signup.namePlaceholder,
                                     text: $vm.name,
                                     keyboardType: .default,
                                     textContentType: .name).focused($isInputActive)
                        
                        AppTextField(placeholder: Constants.Signup.mobilePlaceholder,
                                     text: $vm.mobile,
                                     keyboardType: .numberPad,
                                     textContentType: .telephoneNumber).focused($isInputActive)
                        
                        AppTextField(placeholder: Constants.Signup.emailPlaceholder,
                                     text: $vm.email,
                                     keyboardType: .emailAddress,
                                     textContentType: .emailAddress).focused($isInputActive)
                        
                        AppTextField(placeholder: Constants.Signup.passwordPlaceholder,
                                     text: $vm.password,
                                     isSecure: true,
                                     textContentType: .newPassword).focused($isInputActive)
                    }
                    .padding(.horizontal, 24)

                    if let error = vm.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }

                    AppButton(title: Constants.Signup.signUpButton,
                              isEnabled: vm.isFormValid) {
                        isInputActive = false 
                        vm.signup()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)

                    Button(action: {
                        isInputActive = false
                        router.push(.login)
                    }) {
                        Text(Constants.Signup.alreadyHaveAccount)
                            .foregroundColor(.blue)
                            .underline()
                    }
                    .padding(.top, 20)

                    Spacer()
                }
            }
            .alert(isPresented: $vm.isSignupSuccess) {
                Alert(
                    title: Text(Constants.Signup.successTitle),
                    message: Text(Constants.Signup.successMessage),
                    dismissButton: .default(Text(Constants.Signup.okButton)) {
                        vm.clearFields()
                        router.setRoot(.login)
                    }
                )
            }
            .background(Color(UIColor.systemBackground).ignoresSafeArea())
            .onTapGesture {
                isInputActive = false
            }
        }
        .navigationBarHidden(true) 
    }
}


private extension SignupViewModel {
    var isFormValid: Bool {
        !name.isEmpty && !mobile.isEmpty && !email.isEmpty && !password.isEmpty
    }
}
