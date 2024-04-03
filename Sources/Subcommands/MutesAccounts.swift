//
//  MutesAccounts.swift
//
//
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit

struct MutesAccounts: AsyncParsableCommand {
    @OptionGroup var account: Account
    
    static var configuration = CommandConfiguration(
        commandName: "mutes-users",
        abstract: "View the list of muted accounts",
        discussion: """
        Displays a list of muted accounts in the logged-in account.
        """,
        version: "0.0.1",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    
    mutating func run() async throws {
        let config = ATProtocolConfiguration(handle: account.handle, appPassword: account.password)
        var atProto: ATProtoKit
        switch try await config.authenticate() {
        case .success(let result):
            atProto = ATProtoKit(session: result)
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        let result  = try await atProto.getMutes()
        let users: Array<ActorProfileView>
        switch result {
        case .success(let success):
            users = success.mutes
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        print("Blocked Accounts")
        print("---------------------------------------------------------")
        for user in users {
            if let deisplayName = user.displayName {
                print(deisplayName.isEmpty ? "No display Name" : deisplayName, terminator: "")
            } else {
                print("No display Name", terminator: "")
            }
            print("[\(user.actorHandle)]")
        }
        print("---------------------------------------------------------")
    }
}
