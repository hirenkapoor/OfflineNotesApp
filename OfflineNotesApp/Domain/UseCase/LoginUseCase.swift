//
//  LoginUseCase.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

final class LoginUseCase {
    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute(emailOrMobile: String, password: String) throws -> UserEntity? {
        guard let user = try userRepository.fetchUser(emailOrMobile: emailOrMobile, password: password) else {
            throw LoginError.invalidCredentials
        }
        return user
    }
}

enum LoginError: Error, LocalizedError {
    case invalidCredentials

    var errorDescription: String? {
        Constants.Login.invalidCredentialsError
    }
}
