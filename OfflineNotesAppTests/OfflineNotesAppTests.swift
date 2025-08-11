//
//  OfflineNotesAppTests.swift
//  OfflineNotesAppTests
//
//  Created by Kapoor Hiren on 09/08/25.
//

import XCTest
@testable import OfflineNotesApp

final class ValidatorTests: XCTestCase {
    
    func testIsValidIndianMobile() {
        // Valid cases
        XCTAssertTrue(Validator.isValidIndianMobile("9876543210"))
        XCTAssertTrue(Validator.isValidIndianMobile("9876543210"))
        XCTAssertTrue(Validator.isValidIndianMobile("9876543210"))
        
        // Invalid cases
        XCTAssertFalse(Validator.isValidIndianMobile("12345"))
        XCTAssertFalse(Validator.isValidIndianMobile("abcdefghij"))
        XCTAssertFalse(Validator.isValidIndianMobile("987654321")) // 9 digits
    }
    
    func testIsValidEmail() {
        // Valid cases
        XCTAssertTrue(Validator.isValidEmail("test@example.com"))
        XCTAssertTrue(Validator.isValidEmail("user.name+tag+sorting@example.com"))
        
        // Invalid cases
        XCTAssertFalse(Validator.isValidEmail("plainaddress"))
        XCTAssertFalse(Validator.isValidEmail("missingatsign.com"))
        XCTAssertFalse(Validator.isValidEmail("user@.com"))
    }
    
    func testIsValidPassword() {
        let name = "Hiren"
        
        // Valid password
        let validPassword = "aAA11!!bb"
        XCTAssertTrue(Validator.isValidPassword(validPassword, name: name))
        
        // Invalid cases
        
        // Too short
        XCTAssertFalse(Validator.isValidPassword("aA1!", name: name))
        
        // First character not lowercase
        XCTAssertFalse(Validator.isValidPassword("AA11!!bb", name: name))
        
        // Less than 2 uppercase letters
        XCTAssertFalse(Validator.isValidPassword("aA1!bbbb", name: name))
        
        // Less than 2 digits
        XCTAssertFalse(Validator.isValidPassword("aAA1!bbb", name: name))
        
        // No special character
        XCTAssertFalse(Validator.isValidPassword("aAA11bbb", name: name))
        
        // Contains name
        XCTAssertFalse(Validator.isValidPassword("ahirenAA11!!", name: name))
    }
    
    func testIsValidName() {
        // Assuming Constants.Validation.nameMinLength = 2, nameMaxLength = 50
        
        XCTAssertTrue(Validator.isValidName("Hiren"))
        XCTAssertFalse(Validator.isValidName("A"))  // Too short
        XCTAssertFalse(Validator.isValidName(String(repeating: "a", count: 51)))  // Too long
    }
    
    func testIsValidTitle() {
        // Assuming Constants.Validation.titleMinLength = 5, titleMaxLength = 100
        
        XCTAssertTrue(Validator.isValidTitle("Hello World"))
        XCTAssertFalse(Validator.isValidTitle("Hey"))  // Too short
        XCTAssertFalse(Validator.isValidTitle(String(repeating: "a", count: 101)))  // Too long
    }
    
    func testIsValidDescription() {
        // Assuming Constants.Validation.descriptionMinLength = 100, descriptionMaxLength = 1000
        
        XCTAssertTrue(Validator.isValidDescription("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat ddf"))
        XCTAssertFalse(Validator.isValidDescription("Too short"))
    }
}
