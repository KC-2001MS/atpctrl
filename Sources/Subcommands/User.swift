//
//  User.swift
//
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit

struct User: AsyncParsableCommand {
    @OptionGroup var account: Account
    
    @Argument(help: "The user's handle you want to display") var text: String = ""
    
    static var configuration = CommandConfiguration(
        commandName: "user",
        abstract: "View user profile",
        discussion: """
        Displays user profiles for the specified handle. If blank, your own profile will be displayed.
        """,
        version: "0.0.1",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    
    mutating func run() async throws {
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        let session: UserSession
        var atProto: ATProtoKit
        switch try await config.authenticate() {
        case .success(let result):
            atProto = ATProtoKit(session: result)
            session = result
        case .failure(_):
            throw(RuntimeError(""))
        }
        if text.isEmpty {
            let result  = try await atProto.getProfile(session.handle)
            let myAccount: ActorProfileViewDetailed
            switch result {
            case .success(let success):
                myAccount = success.actorProfileView
            case .failure(let failure):
                throw(RuntimeError("\(failure)"))
            }
            print("Profile")
            print("---------------------------------------------------------")
            print(myAccount.displayName ?? "No Display Name", terminator: "")
            print("[\(myAccount.actorHandle)]")
            if let description = myAccount.description {
                print(description)
            }
            print("---------------------------------------------------------")
        } else {
            let result  = try await atProto.getProfile(text)
            let account: ActorProfileViewDetailed
            switch result {
            case .success(let success):
                account = success.actorProfileView
            case .failure(let failure):
                throw(RuntimeError("\(failure)"))
            }
            print("Profile")
            print("---------------------------------------------------------")
            print(account.displayName ?? "No Display Name", terminator: "")
            print("[\(account.actorHandle)]")
            if let description = account.description {
                print(description)
            }
            print("---------------------------------------------------------")
        }
    }
}
