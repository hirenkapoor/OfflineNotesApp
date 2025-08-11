//
//  SignupUseCase.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

final class SignupUseCase {
    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute(user: UserEntity) throws {
        if try (userRepository.isEmailOrMobileExists(emailOrMobile: user.email) ||
                userRepository.isEmailOrMobileExists(emailOrMobile: user.mobile)) {
            throw SignupError.userExists
        }
        try userRepository.saveUser(user)
    }

}

enum SignupError: Error, LocalizedError {
    case userExists

    var errorDescription: String? {
        switch self {
        case .userExists:
            return Constants.Signup.userExistsError
        }
    }
}
