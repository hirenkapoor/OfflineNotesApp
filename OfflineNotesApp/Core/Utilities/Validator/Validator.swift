//
//  Validator.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 09/08/25.
//

import Foundation

struct Validator {
    static func isValidIndianMobile(_ mobile: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Constants.Validation.indianMobileRegex)
            .evaluate(with: mobile)
    }

    static func isValidEmail(_ email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", Constants.Validation.emailRegex)
            .evaluate(with: email)
    }

    static func isValidPassword(_ password: String, name: String) -> Bool {
        // Length check
        guard password.count >= Constants.Validation.passwordMinLength,
              password.count <= Constants.Validation.passwordMaxLength else { return false }
        
        // First character lowercase
        guard password.first?.isLowercase == true else { return false }
        
        // At least 2 uppercase letters
        guard password.range(of: Constants.Validation.passwordUppercasePattern, options: .regularExpression) != nil else { return false }
        
        // At least 2 digits
        guard password.range(of: Constants.Validation.passwordDigitPattern, options: .regularExpression) != nil else { return false }
        
        // At least 1 special character
        guard password.range(of: Constants.Validation.passwordSpecialCharPattern, options: .regularExpression) != nil else { return false }
        
        // Should not contain the user's name (case insensitive)
        guard !password.lowercased().contains(name.lowercased()) else { return false }
        
        return true
    }

    static func isValidName(_ name: String) -> Bool {
        return name.count >= Constants.Validation.nameMinLength &&
               name.count <= Constants.Validation.nameMaxLength
    }

    static func isValidTitle(_ title: String) -> Bool {
        return title.count >= Constants.Validation.titleMinLength &&
               title.count <= Constants.Validation.titleMaxLength
    }

    static func isValidDescription(_ description: String) -> Bool {
        return description.count >= Constants.Validation.descriptionMinLength &&
               description.count <= Constants.Validation.descriptionMaxLength
    }
}
