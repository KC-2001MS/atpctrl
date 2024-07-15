//
//  Users.swift
//
//
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit
import SwiftLI

struct Users: AsyncParsableCommand {
    @Argument(help: "String to be searched") var text: String = ""
    
    static var configuration = CommandConfiguration(
        commandName: "users",
        abstract: "View a list of logged-in SNS users",
        discussion: """
        Displays a list of users who fit the criteria. If blank, a list of recommended users is displayed.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let (atProto, session) = try await restoreLogin()
        //Get account list
        let users: Array<AppBskyLexicon.Actor.ProfileViewDefinition>
        if text.isEmpty {
            let result  = try await atProto.getSuggestedFollowsByActor(session.sessionDID)
            users = result.suggestions
        } else {
            let result  = try await atProto.searchUsers(by: text)
            users = result.actors
        }
        //Display process
        Group {
            Text(text.isEmpty ? "Suggested Follows" : "Search Results")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            
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
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
        }
        .render()
    }
}
