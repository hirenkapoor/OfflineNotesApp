//
//  UserRepository.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation
import CoreData

protocol UserRepositoryProtocol {
    func saveUser(_ user: UserEntity) throws
    func fetchUser(emailOrMobile: String, password: String) throws -> UserEntity?
    func isEmailOrMobileExists(emailOrMobile: String) throws -> Bool
    func getLoggedInUserId() -> UUID?
}

final class UserRepository: UserRepositoryProtocol {
    private let coreDataStack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }

    func saveUser(_ user: UserEntity) throws {
        let context = coreDataStack.context
        
        // Check if user exists to avoid duplicates
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ OR mobile == %@", user.email, user.mobile)
        
        let existingUsers = try context.fetch(fetchRequest)
        
        if let existingUser = existingUsers.first {
            // Update existing user
            existingUser.fromEntity(user)
        } else {
            // Create new user
            let userMO = User(context: context)
            userMO.fromEntity(user)
        }
        try coreDataStack.saveContext()
    }

    func fetchUser(emailOrMobile: String, password: String) throws -> UserEntity? {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ OR mobile == %@", emailOrMobile, emailOrMobile)

        let users = try context.fetch(fetchRequest)
        let hashedInputPassword = CryptoHasher.hash(password)

        for user in users {
            if let storedPassword = user.password,
               storedPassword == hashedInputPassword {
                return user.toEntity()
            }
        }
        return nil
    }

    func isEmailOrMobileExists(emailOrMobile: String) throws -> Bool {
        let context = coreDataStack.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ OR mobile == %@", emailOrMobile, emailOrMobile)
        let count = try context.count(for: fetchRequest)
        return count > 0
    }

    func getLoggedInUserId() -> UUID? {
        if let idString = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.loggedInUserId) {
            return UUID(uuidString: idString)
        }
        return nil
    }
}
