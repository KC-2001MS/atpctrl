//
//  loginLogic.swift
//  
//  
//  Created by Keisuke Chinone on 2024/06/12.
//



import ATProtoKit

func restoreLogin() async throws -> (ATProtoKit, UserSession) {
    let atProto: ATProtoKit
    let session: UserSession
    if let account = try? FileHelper.loadLoginData() {
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        do {
            let result = try await config.authenticate()
            session = result
            atProto = ATProtoKit(session: result)
        } catch {
            throw(RuntimeError("\(error)"))
        }
    } else {
        print("There is no login record. Please login with the login command.")
        throw(RuntimeError("There is no login record. Please login with the login command."))
    }
    return (atProto, session)
}
