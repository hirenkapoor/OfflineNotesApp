//
//  Constants.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import Foundation

enum Constants {
    
    static let appName = "OfflineNotesApp"

    enum Signup {
        static let createAccount = "Create an Account"
        static let namePlaceholder = "Name"
        static let mobilePlaceholder = "Mobile"
        static let emailPlaceholder = "Email"
        static let passwordPlaceholder = "Password"
        static let signUpButton = "Sign Up"
        static let alreadyHaveAccount = "Already have an account? Log In"
        static let signupTitle = "Signup"
        static let successTitle = "Success"
        static let successMessage = "User registered successfully"
        static let okButton = "OK"
        static let errorNameLength = "Name must be 4 to 25 characters"
        static let errorInvalidMobile = "Invalid Indian mobile number"
        static let errorInvalidEmail = "Invalid email format"
        static let errorInvalidPassword = "Password does not meet criteria"
        static let errorUserExists = "User with email or mobile already exists"
        static let errorSignupFailed = "Signup failed"
        static let userExistsError = "User with this email or mobile already exists."
    }
    
    enum Login {
        static let welcomeBack = "Welcome Back"
        static let emailOrMobilePlaceholder = "Mobile or Email"
        static let passwordPlaceholder = "Password"
        static let loginButton = "Login"
        static let noAccountText = "Don't have an account? Sign Up"
        static let loginTitle = "Login"
        static let errorEmptyFields = "Please enter all fields"
        static let errorInvalidCredentials = "Invalid credentials"
        static let invalidCredentialsError = "Invalid email/mobile or password."
    }
    
    enum Home {
        static let noNotesAvailable = "No notes available"
        static let addNoteButton = "Add Note"
        static let homeTitle = "Home"
        static let logoutButton = "Logout"
    }
    
    enum AddNote {
        static let addNewNoteTitle = "Add New Note"
        static let titleLabel = "Title"
        static let titlePlaceholder = "Note Title"
        static let descriptionLabel = "Description"
        static let photosLabel = "Photos"
        static let addPhotoButton = "Add Photo"
        static let saveNoteButton = "Save Note"
        static let successTitle = "Success"
        static let successMessage = "Note added successfully"
        static let errorProcessImage = "Failed to process image"
        static let errorInvalidTitle = "Title must be 5 to 100 characters"
        static let errorInvalidDescription = "Description must be 100 to 1000 characters"
        static let errorNoPhotos = "Add at least one photo"
    }
    
    enum Validation {
        static let indianMobileRegex = "^[6-9]\\d{9}$"
        static let emailRegex = #"^[A-Za-z0-9._%+-]{4,25}@[A-Za-z0-9.-]{4,25}\.[A-Za-z]{2,}$"#
        static let passwordUppercasePattern = "[A-Z].*[A-Z]"
        static let passwordDigitPattern = "\\d.*\\d"
        static let passwordSpecialCharPattern = "[^A-Za-z\\d]"
        
        static let nameMinLength = 4
        static let nameMaxLength = 25
        
        static let titleMinLength = 5
        static let titleMaxLength = 100
        
        static let descriptionMinLength = 100
        static let descriptionMaxLength = 1000
        
        static let passwordMinLength = 8
        static let passwordMaxLength = 15
        
        static let errorNameLength = "Name must be between 4 and 25 characters."
        static let errorInvalidMobile = "Please enter a valid Indian mobile number."
        static let errorInvalidEmail = "Please enter a valid email address."
        static let errorInvalidPassword = "Password must be 8-15 characters, start with a lowercase letter, contain at least 2 uppercase letters, 2 digits, and 1 special character, and must not include your name."
        static let errorTitleLength = "Title must be between 5 and 100 characters."
        static let errorDescriptionLength = "Description must be between 100 and 1000 characters."
    }
    
    enum UserDefaultsKeys {
        static let loggedInUserId = "loggedInUserId"
        static let isLoggedIn = "isLoggedIn"
    }
    
    enum PhotoPicker {
        static let maxSelectionLimit = 10
    }
    
}
