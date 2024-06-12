//
//  MutesAccounts.swift
//
//
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit
import SwiftLI

struct MutesAccounts: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "mutes-users",
        abstract: "View the list of muted accounts",
        discussion: """
        Displays a list of muted accounts in the logged-in account.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let (atProto, _) = try await restoreLogin()
        //Get a list of mutes accounts
        let result  = try await atProto.getMutes()
        let users: Array<ActorProfileView>
        switch result {
        case .success(let success):
            users = success.mutes
        case .failure(let failure):
            throw(RuntimeError("\(failure)"))
        }
        //Display process
        Group {
            Text("Mutes Accounts")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
        }
        .render()
 
        for user in users {
            if let deisplayName = user.displayName, !deisplayName.isEmpty {
                Text(deisplayName)
                    .render()
            } else {
                Text("No display Name")
                    .render()
            }
            
            Text("[\(user.actorHandle)]")
                .forgroundColor(.eight_bit(244))
                .newLine()
                .render()
        }
        
        HDivider(10)
            .lineStyle(.double_line)
            .forgroundColor(.eight_bit(244))
            .newLine()
            .render()
    }
}
