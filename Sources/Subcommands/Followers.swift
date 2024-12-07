//
//  Followers.swift
//  atpctrl
//
//  Created by 茅根啓介 on 2024/12/07.
//

import ArgumentParser
import ATProtoKit
import SwiftLI

// OK
struct Followers: AsyncParsableCommand {
    @Argument(help: "The user's handle you want to display") var text: String = ""
    
    static var configuration = CommandConfiguration(
        commandName: "followers",
        abstract: "View the list of blocked accounts",
        discussion: """
        Displays a list of blocked accounts.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let atProto = try await restoreLogin()
        //Get a list of blocked accounts
        //FIXME: It seems to be a bug in the ATProtoKit framework. It could be fixed with an update.
        let result = try await atProto.getFollowers(by: text.isEmpty ? atProto.session?.handle ?? text : text)
        let accounts = result.followers
        //Display process
        Group {
            Text("Followers")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            
            if accounts.isEmpty {
                Text("No Followers")
                    .forgroundColor(.red)
                    .newLine()
            } else {
                for account in accounts {
                    if let deisplayName = account.displayName, !deisplayName.isEmpty {
                        Text(deisplayName)
                    } else {
                        Text("No display Name")
                    }
                    
                    Text("[\(account.actorHandle)]")
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
