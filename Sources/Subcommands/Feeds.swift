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
    @Argument(help: "Keywords for the feed you want to search") var text: String = ""
    
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
        let atProto: ATProtoKit
        
        do {
            atProto = try await restoreLogin()
        } catch {
            LoginErrorView().render()
            return
        }
        //Get a list of suggested feeds
        let feeds: [AppBskyLexicon.Feed.GeneratorViewDefinition]

        let getSuggestedFeedsItem  = try? await atProto.getSuggestedFeeds()
        feeds = getSuggestedFeedsItem?.feeds ?? []

        
        //Display process
        Group {
            Text("Discover New Feeds")
                .forgroundColor(.blue)
                .bold()
                .newLine()
            
            HDivider(10)
                .lineStyle(.double_line)
                .forgroundColor(.eight_bit(244))
                .newLine()
            
            if feeds.isEmpty {
                Text("No Feeds")
                    .forgroundColor(.red)
                    .newLine()
            } else {
                for suggestion in feeds {
                    Text(suggestion.displayName.isEmpty ? "No display Name" : suggestion.displayName)
                        .newLine()
                    
                    if let displayName = suggestion.creator.displayName {
                        Text("Created by \(displayName)")
                            .forgroundColor(.eight_bit(244))
                            .newLine()
                    }
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
