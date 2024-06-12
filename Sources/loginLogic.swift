//
//  loginLogic.swift
//  
//  
//  Created by Keisuke Chinone on 2024/06/12.
//



import ATProtoKit

func restoreLogin() async throws -> (ATProtoKit, UserSession) {
    if let account = try? FileHelper.loadLoginData() {
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        switch try await config.authenticate() {
        case .success(let result):
            let atProto = ATProtoKit(session: result)
            return (atProto, result)
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
    } else {
        print("There is no login record. Please login with the login command.")
        throw(RuntimeError("There is no login record. Please login with the login command."))
    }
}
