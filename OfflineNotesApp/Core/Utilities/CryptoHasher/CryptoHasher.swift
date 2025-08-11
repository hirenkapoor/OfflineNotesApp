//
//  Hasher.swift
//  OfflineNotesApp
//
//  Created by Kapoor Hiren on 10/08/25.
//

import CryptoKit
import Foundation

struct CryptoHasher {
    static func hash(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
}
