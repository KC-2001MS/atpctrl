//
//  Feeds.swift
//
//  
//  Created by Keisuke Chinone on 2024/04/03.
//


import ArgumentParser
import ATProtoKit
import SwiftLI

struct Feeds: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "feeds",
        abstract: "View a list of social networking feeds",
        discussion: """
        Returns a list of recommended feeds for the logged-in account.
        """,
        version: "0.0.2",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )
    
    mutating func run() async throws {
        let (atProto, _) = try await restoreLogin()
        //Get a list of suggested feeds
        let result  = try await atProto.getSuggestedFeeds()
        let suggestions = result.feeds
        //Display process-------------------------------------------------------")
        Group {
            Text("Discover New Feeds")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            
            
            for suggestion in suggestions {
                    Text(suggestion.displayName.isEmpty ? "No display Name" : suggestion.displayName)
                        .newLine()
                    
                if let displayName = suggestion.creator.displayName {
                    Text("Created by \(displayName)")
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
