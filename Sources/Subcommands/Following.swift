//
//  Following.swift
//  atpctrl
//
//  Created by 茅根啓介 on 2024/12/07.
//

import ArgumentParser
import ATProtoKit
import SwiftLI

// OK
struct Following: AsyncParsableCommand {
    @Argument(help: "The user's handle you want to display") var text: String = ""
    
    static var configuration = CommandConfiguration(
        commandName: "follows",
        abstract: "View the list of following accounts",
        discussion: """
        Displays a list of following accounts.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let atProto = try await restoreLogin()
        //Get a list of blocked accounts
        //FIXME: It seems to be a bug in the ATProtoKit framework. It could be fixed with an update.
        let result = try await atProto.getFollows(from: text.isEmpty ? atProto.session?.handle ?? text : text)
        let follows = result.follows
        //Display process
        Group {
            Text("Follows")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            
            if follows.isEmpty {
                Text("No Follows")
                    .forgroundColor(.red)
                    .newLine()
            } else {
                for follow in follows {
                    if let deisplayName = follow.displayName, !deisplayName.isEmpty {
                        Text(deisplayName)
                    } else {
                        Text("No display Name")
                    }
                    
                    Text("[\(follow.actorHandle)]")
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
