//
//  loginLogic.swift
//  
//  
//  Created by Keisuke Chinone on 2024/06/12.
//



import ATProtoKit

func restoreLogin() async throws -> ATProtoKit {
    let atProto: ATProtoKit
    
    if let account = try? FileHelper.loadLoginData() {
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        do {
            try await config.authenticate()
        } catch {
            throw(RuntimeError("\(error)"))
        }
        atProto = ATProtoKit(sessionConfiguration: config)
    } else {
        print("There is no login record. Please login with the login command.")
        throw(RuntimeError("There is no login record. Please login with the login command."))
    }
    return atProto
}
