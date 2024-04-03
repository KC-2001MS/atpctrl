//
//  BlockedAccounts.swift
//  
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit

struct BlockedAccounts: AsyncParsableCommand {
    @OptionGroup var account: Account
    
    static var configuration = CommandConfiguration(
        commandName: "blocked-users",
        abstract: "View the list of blocked accounts",
        discussion: """
        Displays a list of blocked accounts in the logged-in account.
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
        case .failure(_):
            throw(RuntimeError(""))
        }
        let result  = try await atProto.getListBlocks()
        let users: Array<ActorProfileView>
        switch result {
        case .success(let success):
            users = success.blocks
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
