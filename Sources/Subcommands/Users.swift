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
        let users: Array<ActorProfileView>
        if text.isEmpty {
            let result  = try await atProto.getSuggestedFollowsByActor(session.sessionDID)
            switch result {
            case .success(let success):
                users = success.suggestions
            case .failure(let failure):
                throw(RuntimeError("\(failure)"))
            }
        } else {
            let result  = try await atProto.searchUsers(by: text)
            switch result {
            case .success(let success):
                users = success.actors
            case .failure(let failure):
                throw(RuntimeError("\(failure)"))
            }
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
