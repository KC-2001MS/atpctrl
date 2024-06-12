//
//  FileHelper.swift
//  
//  
//  Created by Keisuke Chinone on 2024/06/12.
//


import Foundation
// FIXME: Currently, there is a problem with saved account information being stored in plain text.
struct FileHelper {
    static let fileManager = FileManager.default
    
    static let fileURL = fileManager.temporaryDirectory.appendingPathComponent("login_data.json")

    static func saveLoginData(_ loginData: AccountData) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(loginData)
        
        do {
            try jsonData.write(to: fileURL, options: .atomic)
        } catch {
            throw(RuntimeError("\(error)"))
        }
    }

    static func loadLoginData() throws -> AccountData? {
        guard let jsonData = try? Data(contentsOf: fileURL) else {
            return nil
        }
        let decoder = JSONDecoder()
        return try decoder.decode(AccountData.self, from: jsonData)
    }

    static func deleteLoginData() throws {
        try FileManager.default.removeItem(at: fileURL)
    }
}
