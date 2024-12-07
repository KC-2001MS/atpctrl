//
//  BlockedAccounts.swift
//  
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit
import SwiftLI

// OK
struct BlockedAccounts: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "blocked-users",
        abstract: "View the list of blocked accounts",
        discussion: """
        Displays a list of blocked accounts in the logged-in account.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let atProto = try await restoreLogin()
        //Get a list of blocked accounts
        //FIXME: It seems to be a bug in the ATProtoKit framework. It could be fixed with an update.
        let result  = try await atProto.getListBlocks()
        let users = result.blocks
        //Display process
        Group {
            Text("Blocked Accounts")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            if users.isEmpty {
                Text("No Blocked Accounts")
                    .forgroundColor(.red)
                    .newLine()
            } else {
                for user in users {
                    if let deisplayName = user.displayName, !deisplayName.isEmpty {
                        Text(deisplayName)
                    } else {
                        Text("No display Name")
                    }
                    
                    Text("[\(user.actorHandle)]")
                        .forgroundColor(.eight_bit(244))
                        .newLine()
                }
            }
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
        }
        .render()
    }
}
