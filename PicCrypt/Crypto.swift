//
//  Crypto.swift
//  PicCrypt
//
//  Created by Fraser King on 2016-12-20.
//  Copyright © 2016 Fraser King. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        if let data = Data(base64Encoded: self) {
            let decrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).decrypt([UInt8](data))
            let decryptedData = Data(decrypted)
            return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
        } else {
            return "Could not decrypt"
        }
    }
    
    func isLowercase() -> Bool {
        let set = CharacterSet.lowercaseLetters
        
        if let scala = UnicodeScalar(self) {
            return set.contains(scala)
        } else {
            return false
        }
    }
    
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
