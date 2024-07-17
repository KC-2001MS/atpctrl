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

    static func saveLoginData(_ loginData: AccountData) throws(FileError) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData: Data
        
        do {
            jsonData = try encoder.encode(loginData)
        } catch {
            throw FileError.encodeFailed
        }
        
        do {
            try jsonData.write(to: fileURL, options: .atomic)
        } catch {
            throw FileError.unableToWriteFile
        }
    }

    static func loadLoginData() throws(FileError) -> AccountData? {
        guard let jsonData = try? Data(contentsOf: fileURL) else {
            throw FileError.fileNotFound
        }
        
        let decoder = JSONDecoder()
        
        let data: AccountData
        do {
            data = try decoder.decode(AccountData.self, from: jsonData)
        } catch {
            throw FileError.decodeFailed
        }
        
        return data
    }

    static func deleteLoginData() throws(FileError) {
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            throw FileError.deleteFailed
        }
    }
}

enum FileError: Error {
    case fileNotFound
    case unableToReadFile
    case unableToWriteFile
    case encodeFailed
    case decodeFailed
    case deleteFailed
}
